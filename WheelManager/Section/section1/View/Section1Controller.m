//
//  Section1Controller.m
//  WheelManager

//   最常用的模块  UITableView（UICollectionView,动态高度）
//   SDWebImage 数据库 友盟分享 base UIWebView 进度条 自定义view 工具类 TMCache MJExtension
//   ReactiveCocoa PureLayout FMDB MJRefresh
//  1,工具类 2 自定义view 3 UITableView 4,第三方库

//  Created by 刘献亭 on 15/10/11.
//  Copyright © 2015年 刘献亭. All rights reserved.
//

#import "Section1Controller.h"
#import "AFNetWorkUtilController.h"
#import "CacheController.h"
#import "OtherToolsController.h"
#import "BindingHelperController.h"

@interface Section1Controller ()

@end

@implementation Section1Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.helper=[CETableViewBindingHelper bindingHelperForTableView:self.tableView sourceSignal:RACObserve(self, toolArray)];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
}

- (NSMutableArray *)toolArray {
    if (!_toolArray) {
        _toolArray = [NSMutableArray array];
        NSArray *titleArray = @[@"1、AFNetWorkUtils的使用", @"2、数据持久化",@"3、BindingHelper",@"4、小工具类",@"5、常用软件",@"6、小技巧",@"7、常用网站",@"8、书籍"];
        NSArray *detailTitleArray=@[@"网络监听，网络数据获取，（NSError）错误解析，顶层接口数据封装", @"NSUserDefaults加密，类对象缓存，数据库缓存", @"支持TableView,CollectionView、支持动态高度、插入删除",@"BLImageSize,CommonUtils,UITableViewCell+TableView,UIWebView+RAC",@"插件，IDE,工具",@"snippets,LLDB,宏，类目",@"CocoaChina,简书,stackoverflow,nshipster",@"重构改善既有代码的设计,iOS设计模式解,析测试驱动的iOS开发",];
        NSArray *targetVCArray=@[AFNetWorkUtilController.class, CacheController.class,
                                 BindingHelperController.class,OtherToolsController.class,OtherToolsController.class,OtherToolsController.class,OtherToolsController.class,OtherToolsController.class,];
        for (int i = 0; i < titleArray.count; ++i) {
            TemplateModel *tool=[TemplateModel new];
            tool.title=titleArray[i];
            tool.subTitle=detailTitleArray[i];
            tool.targetController=targetVCArray[i];
            tool.accessoryType=YES;
            [_toolArray addObject:tool];
        }
    }
    return _toolArray;
}



@end
