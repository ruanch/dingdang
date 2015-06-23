//
//  UFUserDefault.m
//  universityFace
//
//  Created by 阮 沧晖 on 14-9-25.
//  Copyright (c) 2014年 阮 沧晖. All rights reserved.
//

#import "UFUserDefault.h"



static UFUserDefault *ufUserDefault;
@implementation UFUserDefault

+ (id)shared
{
    if (ufUserDefault == nil){
        @synchronized(self){
            ufUserDefault = [[UFUserDefault alloc]init];
        }
    }
    return ufUserDefault;
}

- (void)updateUserDefaults:(id)value forKey:(NSString *)key
{
    [userDefaults setObject:value forKey:key];
}

- (void)updateUserDefaultsIntValue:(NSInteger)value forKey:(NSString *)key
{
    [userDefaults setInteger:value forKey:key];
}

- (void)updateUserDefaultsBoolValue:(BOOL)value forKey:(NSString *)key
{
    [userDefaults setBool:value forKey:key];
}

- (NSInteger)intValueForKey:(NSString *)key
{
    return [userDefaults integerForKey:key];
}

- (id)userDefaultValueForKey:(NSString *)key
{
    return [userDefaults objectForKey:key];
}

- (void)updateLoginInfosForUsername:(NSString *)usernme forPassword:(NSString *)password
{
    [ufUserDefault updateUserDefaults:usernme forKey:kUsername];
    [ufUserDefault updateUserDefaults:password forKey:kPassword];
}

- (void)resetLoginInfos{
    
    [ufUserDefault updateUserDefaults:@"" forKey:kUsername];
    [ufUserDefault updateUserDefaults:@"" forKey:kPassword];
}
@end
