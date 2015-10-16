//
//  UUIDManager.h
//  WheelManager
//
//  Created by 刘献亭 on 15/10/12.
//  Copyright © 2015年 刘献亭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UUIDManager : NSObject

+ (OSStatus) deleteUUID;

+ (OSStatus)updateUUID:(NSString *)newUUID;

+ (NSString *) getUUID;

@end

/*通过UUID和KeyChain来代替Mac地址实现iOS设备的唯一标示
 NSString *uuid = [MyUUIDManager getUUID];
 NSLog(@"uuid: %@",uuid);
 
 [MyUUIDManager updateUUID:@"test"];
 
 uuid = [MyUUIDManager getUUID];
 NSLog(@"uuid: %@",uuid);
 
 [MyUUIDManager deleteUUID];
 
 uuid = [MyUUIDManager getUUID];
 NSLog(@"uuid: %@",uuid);
 */
