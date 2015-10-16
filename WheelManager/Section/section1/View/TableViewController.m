//
//  TableViewController.m
//  WheelManager
//
//  Created by 刘献亭 on 15/10/12.
//  Copyright © 2015年 刘献亭. All rights reserved.
//

#import "TableViewController.h"

static NSString *const url=@"http://jandan.net/?oxwlxojflwblxbsapi=get_recent_posts&include=url,date,tags,author,title,comment_count,custom_fields&custom_fields=thumb_c,views&dev=1&page=1";

@implementation CusmtomModel

+ (NSDictionary*)replacedKeyFromPropertyName
{
    return @{ @"thumb_c" : @"custom_fields.thumb_c[0]" };
}

@end

#pragma mark -cell
@interface CusmtomCell : UITableViewCell<CEReactiveView>

@end

@implementation CusmtomCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    return [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
}

-(void)bindViewModel:(CusmtomModel *)model forIndexPath:(NSIndexPath *)indexPath{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.thumb_c] placeholderImage:[UIImage imageNamed:@"ic_loading_small"]];
    self.textLabel.text=model.title;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    //解决 因为网络图片较大，点击cell后，图片变宽的问题
    CGRect frame=self.imageView.frame;
    frame.size.width=frame.size.height;
    self.imageView.frame=frame;
}

@end


@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"固定高度";
    
    //从网络获得数据
    RACSignal *sourceSignal=[[AFNetWorkUtils racGETWithURL:url class:[CusmtomModel class]] doError:^(NSError *error) {
        [[ToastHelper sharedToastHelper] toast:[AFNetWorkUtils handleErrorMessage:error]];
    }];

    //加载到tableView
    self.helper=[CETableViewBindingHelper bindingHelperForTableView:self.tableView sourceSignal:sourceSignal selectionCommand:nil templateCellClass:[CusmtomCell class]];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
}

@end
