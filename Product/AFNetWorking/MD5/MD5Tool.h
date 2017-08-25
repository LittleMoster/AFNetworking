//
//  MD5Tool.h
//  数据加密
//
//  Created by cguo on 2017/5/5.
//  Copyright © 2017年 YX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MD5Tool : NSObject
+(NSString *)MD5FromString:(NSString*)str;

+(NSString *)StringMD5FromData:(NSData*)data;

+(NSString *)fileMD5FromPath:(NSString*)path;


@end
