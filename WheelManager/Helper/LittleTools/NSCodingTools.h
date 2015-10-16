//
//  NSCodingTools.h
//  CarManager
//
//  Created by 刘献亭 on 15/4/27.
//  Copyright (c) 2015年 David. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSCodingTools : NSObject

/**
 *  通过类名作为key，使用简单，不是同一类对象保存多次
 *
 *  @param aClass 通过类名作为key
 */
+ (void)saveSinle:(id)object;

+(id)readSinle:(Class)aClass;

+(void)deleteSingle:(Class)aClass;


/**
 *  通过自定义key 保存，使用相对复杂，适用性广
 *
 *  @param key 自定义key
 */
+ (void)save:(id)object forKey:(NSString *)key;

+(id)read:(NSString *)key;

+(void)delete:(NSString *)key;

@end
