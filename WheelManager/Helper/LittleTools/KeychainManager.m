//
//  CHKeychain.m
//  WheelManager
//
//  Created by 刘献亭 on 15/10/12.
//  Copyright © 2015年 刘献亭. All rights reserved.
//

#import "KeychainManager.h"

@implementation KeychainManager

+ (NSMutableDictionary *) getKeyChainItemDictionary:(NSString *) service {
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                (__bridge_transfer id)kSecClassGenericPassword,(__bridge_transfer id)kSecClass,
                                service, (__bridge_transfer id)kSecAttrService,
                                service, (__bridge_transfer id)kSecAttrAccount,
                                nil];
    
    return dic;
}

+ (OSStatus) add:(NSString *)service data:(id)data {
    OSStatus status = noErr;
    
    if ([self get:service]) {
        NSLog(@"Service:%@ in keychain exist, execute update.", service);
        status = [self update:service data:data];
    } else {
        NSMutableDictionary *keychainDic = [self getKeyChainItemDictionary:service];
        
        [keychainDic setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(__bridge_transfer id)kSecValueData];
        
        status = SecItemAdd((__bridge_retained CFDictionaryRef)keychainDic, NULL);
        if (status == 0) {
            NSLog(@"Add service:%@ to keychain success.",service);
        }
    }
    
    return status;
}


+ (OSStatus) delete:(NSString *)service {
    OSStatus status = noErr;
    
    if ([self get:service]) {
        NSMutableDictionary *keychainDic = [self getKeyChainItemDictionary:service];
        status = SecItemDelete((__bridge_retained CFDictionaryRef)keychainDic);
        if (status == 0) {
            NSLog(@"Delete service:%@ to keychain success.",service);
        }
    } else {
        NSLog(@"Service:%@ in keychain does not exist.",service);
    }
    
    return status;
    
}

+ (OSStatus) update:(NSString *)service data:(id)data {
    OSStatus status = noErr;
    
    if ([self get:service]) {
        NSMutableDictionary *keychainDic = [self getKeyChainItemDictionary:service];
        NSDictionary *updateDic = [NSDictionary dictionaryWithObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(__bridge_transfer id)kSecValueData];
        status = SecItemUpdate((__bridge_retained CFDictionaryRef)keychainDic, (__bridge_retained CFDictionaryRef)updateDic);
        if (status ==0 ) {
            NSLog(@"Update service:%@ in keychain success.",service);
            
        }
    } else {
        status = [self add:service data:data];
    }
    
    return status;
}

+ (id) get:(NSString *)service {
    id ret = nil;
    
    NSMutableDictionary *keychainQuery = [self getKeyChainItemDictionary:service];
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(__bridge_transfer id)kSecReturnData];
    [keychainQuery setObject:(__bridge_transfer id)kSecMatchLimitOne forKey:(__bridge_transfer id)kSecMatchLimit];
    
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((__bridge_retained CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge_transfer NSData *)keyData];
        } @catch (NSException *e) {
            
        } @finally {
            
        }
    }
    return ret;
}


@end
