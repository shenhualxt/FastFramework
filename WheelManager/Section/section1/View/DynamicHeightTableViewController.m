//
//  DynamicHeightTableViewController.m
//  WheelManager
//
//  Created by 刘献亭 on 15/10/13.
//  Copyright © 2015年 刘献亭. All rights reserved.
//

#import "DynamicHeightTableViewController.h"
#import "DynamicHeightTableViewCell.h"
#import "TableViewController.h"

@interface DynamicHeightTableViewController ()

@property(strong,nonatomic) CETableViewBindingHelper *helper;

@end

@implementation DynamicHeightTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"动态高度";
    NSString *url = @"http://jandan.net/?oxwlxojflwblxbsapi=get_recent_posts&include=url,date,tags,author,title,comment_count,custom_fields&custom_fields=thumb_c,views&dev=1&page=1";
    RACSignal *sourceSignal=[[AFNetWorkUtils racGETWithURL:url class:[CusmtomModel class]] doError:^(NSError *error) {
        [[ToastHelper sharedToastHelper] toast:[AFNetWorkUtils handleErrorMessage:error]];
    }];
    
    self.helper=[CETableViewBindingHelper bindingHelperForTableView:self.tableView sourceSignal:sourceSignal selectionCommand:nil customCellClass:[DynamicHeightTableViewCell class]];
    self.helper.isDynamicHeight=YES;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
}

@end
