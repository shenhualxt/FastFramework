//
//  UUIDManager.m
//  WheelManager
//
//  Created by 刘献亭 on 15/10/12.
//  Copyright © 2015年 刘献亭. All rights reserved.
//

#import "UUIDManager.h"
#import "KeychainManager.h"


@implementation UUIDManager

static NSString * const kUUIDServiceInKeychain = @"com.myuuid.uuid";


+ (OSStatus) addUUID:(NSString *)uuid{
    OSStatus status = noErr;
    
    if (uuid && uuid.length > 0) {
        status = [KeychainManager add:kUUIDServiceInKeychain data:uuid];
    } else {
        status = 1;
    }
    
    return status;
}


+ (NSString *) getUUID {
    NSString *uuid = (NSString *)[KeychainManager get:kUUIDServiceInKeychain];
    
    if (!uuid || uuid.length == 0) {
        NSLog(@"add uuid to keychain first time.");
        CFUUIDRef puuid = CFUUIDCreate( nil );
        
        CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
        
        uuid = [NSString stringWithFormat:@"%@", uuidString];
        
        [self addUUID:uuid];
        
        CFRelease(puuid);
        
        CFRelease(uuidString);
    }
    
    return uuid;
}

+ (OSStatus) deleteUUID {
    OSStatus status = noErr;
    
    status = [KeychainManager delete:kUUIDServiceInKeychain];
    
    return status;
}

+ (OSStatus)updateUUID:(NSString *)newUUID {
    OSStatus status = noErr;
    
    status = [KeychainManager update:kUUIDServiceInKeychain data:newUUID];
    
    return status;
}


@end
