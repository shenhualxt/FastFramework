//
//  SQLiteController.m
//  WheelManager
//
//  Created by 刘献亭 on 15/10/12.
//  Copyright © 2015年 刘献亭. All rights reserved.
//

#import "SQLiteController.h"
#import "CacheTools.h"

@interface SQLiteController ()

@property(nonatomic, strong) NSMutableArray *cacheArray;


@property(nonatomic, strong) CETableViewBindingHelper *helper;

@end

@implementation SQLiteController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"数据库缓存工具类的使用";
    //1、保存到数据库（使用简单）
    [[CacheTools sharedCacheTools] save:self.cacheArray sortArgument:@"id"];
    
    /*
     2、获得存入数据的结果
    [[[CacheTools sharedCacheTools] racSave:self.cacheArray sortArgument:@"id"] subscribeNext:^(NSArray *savedArray) {
        //savedArray:本次存入到数据库的数据（包含数据库中已有的，虽然不会重复保存的数据库）
    } error:^(NSError *error) {
        //存入失败的原因
    }];
     */
    
    //3、从数据库取出（全部取出)
//    RACSignal *soureSignal=[[CacheTools sharedCacheTools] read:TemplateModel.class];
    
    //4、支持分页，默认一页20条数据
    //数据库中一共44条数据 ，按降序取出，（1）第一页 即43-24 第二页 23-4 第三页 4-0 （2）页数过大，返回空  （3）最后一页 返回余数
    RACSignal *soureSignal=[[CacheTools sharedCacheTools] read:TemplateModel.class page:2];
    
    //加载
    self.helper= [CETableViewBindingHelper bindingHelperForTableView:self.tableView sourceSignal:soureSignal];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
}

-(NSMutableArray *)cacheArray{
    if (!_cacheArray) {
        _cacheArray=[NSMutableArray array];
        for (int i=0; i<44; i++) {
            TemplateModel *model=[TemplateModel new];
            model.id=i;
            model.title=[NSString stringWithFormat:@"title%d",i];
            model.subTitle=[NSString stringWithFormat:@"subTitle%d",i];
            [_cacheArray addObject:model];
        }
    }
    return _cacheArray;
}

@end
