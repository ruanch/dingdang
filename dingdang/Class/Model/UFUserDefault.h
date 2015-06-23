//
//  UFUserDefault.h
//  universityFace
//
//  Created by 阮 沧晖 on 14-9-25.
//  Copyright (c) 2014年 阮 沧晖. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UFUserInfo.h"

#define KApiToken @"KApiToken"
#define KapiSecret @"KapiSecret"
#define kUsername  @"kUsername"
#define kPassword  @"kPassword"
#define KAutoLogin = @"kAutoLogin"
#define KUsertype = @"kUsertype"

@interface UFUserDefault : NSObject
{
    NSUserDefaults *userDefaults;
}

@property (nonatomic, strong) NSString *apiSecret;
@property (nonatomic, strong) NSString *apiToken;
@property (nonatomic, strong) NSString *serverUrl;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *accountName;
@property (nonatomic, strong) NSString *usertype;
@property (nonatomic, strong) UFUserInfo *userInfo;

+ (id)shared;

- (void)updateUserDefaults:(id)value forKey:(NSString *)key;
- (void)updateUserDefaultsIntValue:(NSInteger)value forKey:(NSString *)key;
- (void)updateUserDefaultsBoolValue:(BOOL)value forKey:(NSString *)key;
- (NSInteger)intValueForKey:(NSString *)key;
- (id)userDefaultValueForKey:(NSString *)key;
- (void)updateLoginInfosForUsername:(NSString *)usernme forPassword:(NSString *)password;
- (void)resetLoginInfos;
@end
