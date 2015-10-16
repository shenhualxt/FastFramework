//
//  BindingHelperController.m
//  WheelManager
//
//  Created by 刘献亭 on 15/10/12.
//  Copyright © 2015年 刘献亭. All rights reserved.
//

#import "BindingHelperController.h"
#import "TableViewController.h"
#import "DynamicHeightTableViewController.h"
#import "CollectionViewController.h"

@interface BindingHelperController ()

@end

@implementation BindingHelperController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"BindingHelper的使用";
}

- (NSMutableArray *)toolArray {
    NSMutableArray *toolArray = [NSMutableArray array];
    NSArray *titleArray = @[@"1、固定高度", @"2、动态高度",@"3、UICollectionView",@"4、cell动态高度+网络图片动态高度"];
    NSArray *detailTitleArray=@[@"固定高度为自定义cell的高度", @"在固定高度的基础上，设置好四周约束，添加一句代码即可",@"自定义cell宽度",@"思路：提前获得网络图片大小，设置UIImageView intrinsicContentSize,使自动计算cell高度正确"];
    NSArray *targetVCArray=@[TableViewController.class,DynamicHeightTableViewController.class,CollectionViewController.class];
    for (int i = 0; i < titleArray.count; ++i) {
        TemplateModel *tool=[TemplateModel new];
        tool.title=titleArray[i];
        tool.subTitle=detailTitleArray[i];
        if(i!=titleArray.count-1){
          tool.accessoryType=YES;
          tool.targetController=targetVCArray[i];
        }
        [toolArray addObject:tool];
    }
    return toolArray;
}

@end
