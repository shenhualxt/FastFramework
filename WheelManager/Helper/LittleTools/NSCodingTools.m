//
//  NSCodingTools.m
//  CarManager
//
//  Created by 刘献亭 on 15/4/27.
//  Copyright (c) 2015年 David. All rights reserved.
//

#import "NSCodingTools.h"

@implementation NSCodingTools

+ (void)save:(id)object forKey:(NSString *)key
{
    // 2.1.获得Documents的全路径
    NSString* doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 2.2.获得文件的全路径
    NSString *path=[NSString stringWithFormat:@"%@.data", [object class]];
    if (key) {
        key=[NSString stringWithFormat:@"%@.data", key];
    }
    NSString* uniquePath = [doc stringByAppendingPathComponent:path];
    // 2.3.将对象归档
    [NSKeyedArchiver archiveRootObject:object toFile:uniquePath];
}

+ (void)saveSinle:(id)object{
    [self save:object forKey:nil];
}


+(id)readSinle:(Class)aClass{
    return [self read:aClass forKey:nil];
}

+(id)read:(NSString *)key{
    return [self read:nil forKey:key];
}

+ (id)read:(Class)aClass forKey:(NSString *)key
{
    // 1.获得Documents的全路径
    NSString* doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 2.获得文件的全路径
    NSString *path=[NSString stringWithFormat:@"%@.data", aClass];
    if (key) {
        key=[NSString stringWithFormat:@"%@.data", key];
    }
    NSString* uniquePath = [doc stringByAppendingPathComponent:path];
    // 3.从文件中读取对象
    return [NSKeyedUnarchiver unarchiveObjectWithFile:uniquePath];
}

+(void)delete:(NSString *)key{
    [self delete:nil forKey:key];
}

+(void)deleteSingle:(Class)aClass{
    [self delete:aClass forKey:nil];
}

+ (void)delete:(Class)aClass forKey:(NSString *)key{
  NSFileManager* fileManager=[NSFileManager defaultManager];
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
  
  //文件名
    NSString *path=[NSString stringWithFormat:@"%@.data", aClass];
    if (key) {
        key=[NSString stringWithFormat:@"%@.data", key];
    }
  NSString *uniquePath=[[paths objectAtIndex:0] stringByAppendingPathComponent:path];
  BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:uniquePath];
  if (!blHave) {
    return ;
  }else {
    [fileManager removeItemAtPath:uniquePath error:nil];
  }
}



@end
