//
//  HomeViewController.h
//  AiDian
//
//  Created by Oliver Zheng on 14-4-10.
//  Copyright (c) 2014年 JiHeNet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EncryptAndDescrypt : NSObject

+ (NSString *)encryptKey:(NSString *)key dict:(NSDictionary *)dict;

+ (NSDictionary *)decyptyKey:(NSString *)key encryptedString:(NSString *)string;

+ (NSString *)getCurrentTimeInSeconds;

+ (NSString *)getOnce;

+ (NSString *)getJsonStringFromDict:(NSDictionary *)dic;

+ (NSString *)getMD5String:(NSString *)string;

+ (NSMutableDictionary *)getLoginParamDict:(NSDictionary *)dict;

+ (NSMutableDictionary *)getRequestParamDict:(NSDictionary *)dict;

@end
