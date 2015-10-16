//
//  CacheController.m
//  WheelManager
//
//  Created by 刘献亭 on 15/10/12.
//  Copyright © 2015年 刘献亭. All rights reserved.
//

#import "CacheController.h"
#import "AESCrypt.h"
#import "KeychainManager.h"
#import "UUIDManager.h"
#import "NSCodingTools.h"
#import "SQLiteController.h"
#import "CEObservableMutableArray.h"

NSString *const PASSWORD=@"lunz1qaz2wsx";

NSString * const KEY_USERNAME_PASSWORD = @"com.company.app.usernamepassword";
NSString * const KEY_USERNAME = @"com.company.app.username";
NSString * const KEY_PASSWORD = @"com.company.app.password";

NSString *const KEY_CACHEMODEL=@"CacheModel";


@interface CacheController ()<UITableViewDelegate>

@property(nonatomic, strong) CEObservableMutableArray *toolArray;

@property(nonatomic,strong) CETableViewBindingHelper *helper;

@end

@implementation CacheController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"数据缓存";
    self.helper= [CETableViewBindingHelper bindingHelperForTableView:self.tableView sourceSignal:RACObserve(self, toolArray)];
    self.helper.delegate=self;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //当前行对应的模型数据
    TemplateModel *model=self.helper.data[indexPath.row];
    NSInteger tag=indexPath.row+1;
    switch (indexPath.row) {
        case 0:{
            //0、NSString加密(AESCrypt)
            if (tableView.tag ==tag) {
                //解密
                model.subTitle=[AESCrypt decrypt:model.subTitle password:PASSWORD];
                 tableView.tag=tag*10;
            }else{
                //加密
                model.subTitle=[AESCrypt encrypt:model.subTitle password:PASSWORD];
                tableView.tag=tag;
            }
        }
            break;
        case 1:
            //账号密码的保存(KeychainManager)
            if (tableView.tag==tag) {
                //解密
                NSMutableDictionary *usernamepasswordKVPairs = (NSMutableDictionary *)[KeychainManager get:KEY_USERNAME_PASSWORD];
                NSString *userName = [usernamepasswordKVPairs objectForKey:KEY_USERNAME];
                NSString *pwd = [usernamepasswordKVPairs objectForKey:KEY_PASSWORD];
                model.subTitle=[NSString stringWithFormat:@"用户名：%@ 密码:%@（点击保存）",userName,pwd];
                tableView.tag=tag*10;
                //如果已存在 更新
                //[KeychainManager update:KEY_USERNAME_PASSWORD data:usernamepasswordKVPairs];
                //删除
                //[KeychainManager delete:KEY_USERNAME_PASSWORD];
            }else{
                //加密
                NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
                [usernamepasswordKVPairs setObject:@"shenhualxt" forKey:KEY_USERNAME];
                [usernamepasswordKVPairs setObject:@"123456" forKey:KEY_PASSWORD];
                OSStatus status = [KeychainManager add:KEY_USERNAME_PASSWORD data:usernamepasswordKVPairs];
                if (status==0) {
                    model.subTitle=@"保存到keyChain成功(点击查看原始数据）";
                }
                tableView.tag=tag;
            }
            break;
        case 2:{
            //@"2、iOS设备唯一标示"
            if ([model.subTitle hasPrefix:@"卸载"]) {
                NSMutableString *uuid=[NSMutableString stringWithString:[UUIDManager getUUID]];
                [uuid appendFormat:@"\n%@",model.subTitle];
                model.subTitle=uuid;
            }
        }
            break;
        case 3:{
            //3、类对象缓存(必须要实现<NSCoding>协议中的encodeWithCoder和initWithCoder方法)"
            if (tableView.tag==indexPath.row) {
                //(1)使用NSUserDefault保存
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
                [[NSUserDefaults standardUserDefaults] setValue:data forKey:KEY_CACHEMODEL];
            
                NSData *cacheData=[[NSUserDefaults standardUserDefaults] objectForKey:KEY_CACHEMODEL];
                TemplateModel *cacheModel=[NSKeyedUnarchiver unarchiveObjectWithData:cacheData];
                
                if(cacheModel.title){
                    model.subTitle=@"使用NSUserDefault保存成功";
                }
                tableView.tag=indexPath.row*10;
            }else{
                //(2）使用NSKeyedArchiver归档到Documents
                [NSCodingTools saveSinle:model];
                
                TemplateModel *cacheModel=[NSCodingTools readSinle:TemplateModel.class];
                
                if(cacheModel.title){
                    model.subTitle=@"使用NSKeyedArchiver归档至Documents成功";
                }
                 tableView.tag=indexPath.row;
            }
        }
            break;
        case 4:
            //4、数据库缓存（sqlite）
            [self.navigationController pushViewController:[SQLiteController new] animated:YES];
            break;
        default:
            break;
    }
    [self.helper.data replaceObjectAtIndex:indexPath.row withObject:model];
}


- (CEObservableMutableArray *)toolArray {
    if (!_toolArray) {
        _toolArray = [[CEObservableMutableArray alloc] init];
        NSArray *titleArray = @[@"0、NSString加密(AESCrypt)",@"1、账号密码的保存(Keychain)",@"2、iOS设备唯一标示(点击查看标示)", @"3、类对象缓存（两种方式）", @"4、数据库缓存（FMDB）"];
        NSArray *detailTitleArray=@[@"原始数据(点击加密)", @"用户名：shenhualxt 密码:123456(点击保存)", @"卸载也不会改变(UUID+KeyChain)", @"点击使用NSUserDefault方式保存",@"支持分页，多线程"];
        for (int i = 0; i < titleArray.count; ++i) {
            TemplateModel *tool=[TemplateModel new];
            tool.title=titleArray[i];
            tool.subTitle=detailTitleArray[i];
            if (i==titleArray.count-1) {
                tool.accessoryType=YES;
            }
            [_toolArray addObject:tool];
        }
    }
    return _toolArray;
}

@end
