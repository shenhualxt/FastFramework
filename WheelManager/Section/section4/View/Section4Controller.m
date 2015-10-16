//
//  Section4Controller.m
//  WheelManager
//
//  Created by 刘献亭 on 15/10/11.
//  Copyright © 2015年 刘献亭. All rights reserved.
//

#import "Section4Controller.h"

@interface Section4Controller ()

@end

@implementation Section4Controller

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSMutableArray *)toolArray {
    NSMutableArray *toolArray = [NSMutableArray array];
    NSArray *titleArray = @[@"1、函数响应式编程", @"2、MVVM（优于MVC）", @"3、测试驱动开发", @"4、设计模式"];
    NSArray *detailTitleArray=@[@"借助ReactiveCocoa实现", @"实现低耦合，高复用性，可测试的开发模式", @"先写测试代码，后写实现代码", @"常用：单例，工厂模式，观察者模式，构建者模式，中介者模式，代理模式"];
    for (int i = 0; i < titleArray.count; ++i) {
        TemplateModel *tool=[TemplateModel new];
        tool.title=titleArray[i];
        tool.subTitle=detailTitleArray[i];
        [toolArray addObject:tool];
    }
    return toolArray;
}

@end
