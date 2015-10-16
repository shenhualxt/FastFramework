//
//  Section2Controller.m
//  WheelManager
//
//  Created by 刘献亭 on 15/10/11.
//  Copyright © 2015年 刘献亭. All rights reserved.
//

#import "Section2Controller.h"
#import "LTAlertView.h"
#import "PopoverView.h"
#import "ProgressView.h"
#import "LTFloorView.h"
#import "WithProgressController.h"

static NSString* const picURL = @"http://b.zol-img.com.cn/desk/bizhi/image/6/1680x1050/1444722383719.jpg";

@interface Section2Controller ()<UITableViewDelegate,LTFloorViewDataSource,LTFloorViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textFieldAlertUserName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldAlertPwd;
@property (strong,nonatomic) LTAlertView *alertView;

@end

@implementation Section2Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.helper.delegate=self;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger tag=indexPath.row+1;
    switch (indexPath.row) {
        case 0://1、自定义对话框
            if (tableView.tag==tag) {
                [self initAlertViewWithCode];
                tableView.tag=tag*10;
            }else{
                [self initAlertViewWithXIB];
                tableView.tag=tag;
            }
            break;
        case 1://1、popView
            [self initPopView:[tableView rectForRowAtIndexPath:indexPath]];
            break;
        case 2:{//1、ProgressView
            ProgressView *progressView=[[NSBundle mainBundle] loadNibNamed:@"ProgressAlertView" owner:self options:nil].lastObject;
            LTAlertView *alertView=[[LTAlertView alloc] initWithNib:progressView];
            [alertView show];
            [progressView setProgress:0.67f];
        }
            break;
        case 3:{//1、LTFloorView
            LTFloorView *floorView=[[NSBundle mainBundle] loadNibNamed:@"FlootAlertView" owner:self options:nil].lastObject;
            self.alertView=[[LTAlertView alloc] initWithNib:floorView];
             floorView.dataSource=self;
             floorView.delegate=self;
            [self.alertView show];
        }
            break;
        default:
            break;
    }
}

-(void)initAlertViewWithCode{
    LTAlertView *alertView=[[LTAlertView alloc] initWithTitle:@"标题" contentText:@"这是一个代码创建的对话框" leftButtonTitle:@"取消" rightButtonTitle:@"确定"];
    [alertView show];
    alertView.rightBlock=^{
        [[ToastHelper sharedToastHelper] toast:@"确定"];
    };
    alertView.leftBlock=^{
        [[ToastHelper sharedToastHelper] toast:@"取消"];
    };
}

-(void)initAlertViewWithXIB{
    UIView *alertNib=[[NSBundle mainBundle] loadNibNamed:@"CustomAlertView" owner:self options:nil].lastObject;
    LTAlertView *alertView=[[LTAlertView alloc] initWithNib:alertNib];
    [alertView show];
    UIButton *buttonCancel=(UIButton *)[alertView viewWithTag:3];
    UIButton *buttonSure=(UIButton *)[alertView viewWithTag:4];
    @weakify(self)
    [[buttonCancel rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        [alertView dismiss];
        [[ToastHelper sharedToastHelper] toast:[NSString stringWithFormat:@"用户名:%@",self.textFieldAlertUserName.text]];
    }];
    [[buttonSure rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        [alertView dismiss];
        [[ToastHelper sharedToastHelper] toast:[NSString stringWithFormat:@"密码:%@",self.textFieldAlertPwd.text]];
    }];

}

- (void)initPopView:(CGRect)relativeViewframe {
    NSArray *titles=@[@"分享",@"复制链接",@"浏览器打开"];
    relativeViewframe.origin.y+=64;//加上状态栏和导航栏的高度
    
    PopoverView *pop =[[PopoverView alloc] initWithBtnFrame:relativeViewframe titles:titles images:nil];
    pop.selectRowAtIndex = ^(NSInteger index) {
        [[ToastHelper sharedToastHelper] toast:titles[index]];
        };
    [pop show];
}

#pragma mark -floorView delegate
- (NSInteger)numberOfSubFloorsInFloorView:(LTFloorView *)floorView{
    return 4;
}

-(UIView *)floorView:(LTFloorView *)floorView subFloorViewAtIndex:(NSInteger)index{
    UIView *view=[[[NSBundle mainBundle] loadNibNamed:@"SubCommentView" owner:self options:nil] firstObject];
    UILabel *labelAuthorName=(UILabel *)[view viewWithTag:3];
    labelAuthorName.text=toString(@"xib自定义布局title", @(index+1));
    UILabel *labContent=(UILabel *)[view viewWithTag:4];
     labContent.text=toString(@"content", @(index+1));
    if (index%2) {
        labContent.text=toString(toString(@"content\n", @(index+1)), toString(@"content\n", @(index+1))) ;
    }
    return view;
}

-(void)floorView:(LTFloorView *)floorView didSelectRowAtIndex:(NSInteger)index{
    [[ToastHelper sharedToastHelper] toast:toString(@"", @(index+1))];
    [self.alertView dismiss];
}


- (NSMutableArray *)toolArray {
    NSMutableArray *toolArray = [NSMutableArray array];
    NSArray *titleArray = @[@"1、自定义对话框（两种方式）", @"2、自定义poperView", @"3、渐变色环形进度条",@"4、评论盖楼",@"5、UIImageView+进度条",@"6、UIWebView+进度条(LTProgressWebView)"];
    NSArray *detailTitleArray=@[@"使用xib,和代码创建对话框，点击两次切换创建方式", @"类似Android的popWindow(封装UITableView)", @"漂亮的进度条",@"使用自定义xib创建楼层，高复用性",@"结合SDWebImage,加一个参数添加UIProgressBar",@""];
    for (int i = 0; i < titleArray.count; ++i) {
        TemplateModel *tool=[TemplateModel new];
        tool.title=titleArray[i];
        tool.subTitle=detailTitleArray[i];
        tool.accessoryType=YES;
        if (i==4||i==5) {
            tool.targetController=[WithProgressController class];
        }
        [toolArray addObject:tool];
    }
    return toolArray;
}
@end
