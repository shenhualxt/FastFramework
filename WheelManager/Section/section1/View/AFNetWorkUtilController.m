//
//  AFNetWorkUtilController.m
//  WheelManager
//
//  Created by 刘献亭 on 15/10/11.
//  Copyright © 2015年 刘献亭. All rights reserved.
//

#import "AFNetWorkUtilController.h"

@interface Weather : NSObject

@property(assign,nonatomic) NSInteger error;

@property(strong,nonatomic) NSString *status;

@property(strong,nonatomic) NSString *date;

@end

@implementation Weather

@end

@interface AFNetWorkUtilController ()<UITableViewDelegate>

@property(nonatomic, strong) NSMutableArray *toolArray;

@property(nonatomic,strong) CETableViewBindingHelper *helper;

@end

@implementation AFNetWorkUtilController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"AFNetWorkUtils的使用";
    self.helper=[CETableViewBindingHelper bindingHelperForTableView:self.tableView sourceSignal:RACObserve(self, toolArray)];
    self.helper.delegate=self;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *url=@"http://api.map.baidu.com/telematics/v3/weather?output=json&ak=xc7Ij7992LSnVXDOI526r7Al&location=%E9%9D%92%E5%B2%9B";
    TemplateModel *model=self.helper.data[indexPath.row];
    switch (indexPath.row) {
        case 0:{
            //0、监听网络状态，如果是断网状态，不调用接口，直接返回
            [[[AFNetWorkUtils sharedAFNetWorkUtils] startMonitoringNet] subscribeNext:^(id x) {
                model.subTitle=x;
                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }];
        }
            break;
        case 1:{
            //1、错误处理示例
            [[AFNetWorkUtils get2racWthURL:@"https://api.weibo.com/2/statuses/public_timeline.json"] subscribeError:^(NSError *error) {
                  model.subTitle=[AFNetWorkUtils handleErrorMessage:error];
                 [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }];
        }
            break;
        case 2:{
            //2、get post 请求字典数据
            [[AFNetWorkUtils get2racWthURL:url] subscribeNext:^(id x) {
                //成功返回(id class is NSDictionary)
                model.subTitle=[NSString stringWithFormat:@"[x objectForKey:@\"date\"]=%@",[x objectForKey:@"date"]];
                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            } error:^(NSError *error) {
                model.subTitle=[AFNetWorkUtils handleErrorMessage:error];
                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }];
        }
            break;
        case 3:{
            //3、get post 请求模型数据
            [[AFNetWorkUtils racGETWithURL:url class:Weather.class] subscribeNext:^(Weather *weather) {
                model.subTitle=[NSString stringWithFormat:@"weather.date=%@",weather.date];
                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            } error:^(NSError *error) {
                
            }];
        }
            break;
        case 4:{
            //4、get post 获取非字典数据
            NSString *unJSONUrl=@"http://jandan.net/index.php?acv_ajax=true&option=%@&ID=%@";
            unJSONUrl=[NSString stringWithFormat:unJSONUrl,@(0),@(2941297)];
            [[AFNetWorkUtils get2racUNJSONWthURL:unJSONUrl] subscribeNext:^(NSData *result) {
                model.subTitle=[[[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding] substringToIndex:10];
                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }];
        }
            break;
            
        default:
            break;
    }
}


- (NSMutableArray *)toolArray {
    if (!_toolArray) {
        _toolArray = [NSMutableArray array];
        NSArray *titleArray = @[@"0、监听网络状态(实时更新)", @"1、错误处理示例（切换为无网络测试）", @"2、get post 请求字典数据", @"3、get post 请求模型数据",@"4、get post 请求非字典数据",@"5、顶层封装，在[AFNetWorkUtils handleResultWithSubscriber]处自定义（含示例代码）"];
        for (int i = 0; i < titleArray.count; ++i) {
            TemplateModel *tool=[TemplateModel new];
            tool.title=titleArray[i];
            [_toolArray addObject:tool];
        }
    }
    return _toolArray;
}


@end
