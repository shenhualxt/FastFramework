//
//  Section3Controller.m
//  WheelManager
//
//  Created by 刘献亭 on 15/10/11.
//  Copyright © 2015年 刘献亭. All rights reserved.
//

#import "Section3Controller.h"

@interface Section3Controller ()

@end

@implementation Section3Controller

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (NSMutableArray *)toolArray {
    NSMutableArray *toolArray = [NSMutableArray array];
    NSArray *titleArray = @[@"1、ReactiveCocoa", @"2、SDWebImage", @"3、PureLayout",@"4、MJExtension",@"5、Kiwi",@"pop"];
    NSArray *detailTitleArray=@[@"用了之后，才会发现编程之美", @"图片下载", @"代码创建自动布局",@"字典转模型",@"测试框架",@"动画库"];
    for (int i = 0; i < titleArray.count; ++i) {
        TemplateModel *tool=[TemplateModel new];
        tool.title=titleArray[i];
        tool.subTitle=detailTitleArray[i];
        [toolArray addObject:tool];
    }
    return toolArray;
}

@end
