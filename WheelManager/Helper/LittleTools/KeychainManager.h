//
//  CHKeychain.h
//  WheelManager
//
//  Created by 刘献亭 on 15/10/12.
//  Copyright © 2015年 刘献亭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>

@interface KeychainManager : NSObject

+ (OSStatus) add:(NSString *)service data:(id)data;

+ (OSStatus) delete:(NSString *)service;

+ (OSStatus) update:(NSString *)service data:(id)data;

+ (id) get:(NSString *)service;

@end
