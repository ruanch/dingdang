//
//  UFNetWorkAPIClient.h
//  universityFace
//
//  Created by 阮 沧晖 on 14-9-26.
//  Copyright (c) 2014年 阮 沧晖. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface UFNetWorkAPIClient : NSObject

///*
// 认证接口
// */
////user login
//-(void)userLogin:(NSDictionary *)userDictionary CompletionBlock:(void (^)(BOOL isSuccess, NSString *message, NSString *status))completionBlock;
////user loginOut
//-(void)userLoginOut:(NSDictionary *)userDictionary CompletionBlock:(void (^)(BOOL isSuccess, NSString *message, NSString *status))completionBlock;
////user modify userPassword
//-(void)userUpdatePassword:(NSString *)newPassword withOldPassword:(NSString *)oldPassword CompletionBlock:(void (^)(BOOL isSuccess, NSString *message, NSString *status))completionBlock;
////sned smsCode
//-(void)userSendSmsCode:(NSString *)userName CompletionBlock:(void (^)(BOOL isSuccess, NSString *message, NSString *status))completionBlock;
////validate smsCode
//-(void)userValidateSmsCode:(NSString *)smsCode withAccountName:(NSString *)accountName  CompletionBlock:(void (^)(BOOL isSuccess, NSString *message, NSString *status))completionBlock;
////no login modify userPassword
//-(void)userNoLoginUpdatePassword:(NSString *)newPassword withAccountUserName:(NSString *)accountName CompletionBlock:(void (^)(BOOL isSuccess, NSString *message, NSString *status))completionBlock;
////return sysTime
//-(void)userSysTime:(void (^)(BOOL isSuccess, NSString *message, NSString *status))completionBlock;
//
///*
// 平台接口
// */
////get userInfo
//-(void) userInfo:(void (^)(BOOL isSuccess, NSString *message, NSString *status))completionBlock;
//;
////get Notice
//-(void) requestSchoolNotice:(NSDictionary *)requestDictionary CompletionBlock:(void (^)(BOOL isSuccess, NSString *message, NSString *status,NSArray *resultArray))completionBlock;
////update user MobilePhone
//-(void)updateUserMobilePhone:(NSDictionary *)paramDictionary CompletionBlock:(void (^)(BOOL isSuccess, NSString *message, NSString *status))completionBlock;
////update versions
//-(void)updateVersion:(void (^)(BOOL isSuccess, NSString *message, NSString *status,NSDictionary *resultDic))completionBlock;
////submit feedback
//-(void)submitFeedBack:(NSDictionary *)paramDictionary CompletionBlock:(void (^)(BOOL isSuccess, NSString *message, NSString *status))completionBlock;
////get teachInfo
//-(void) homePageTeacherInfo:(void (^)(BOOL isSuccess, NSString *message, NSString *status, UFHomeTeachDataModel *dataModel))completionBlock;
////get studentInfo
//-(void) homePageStudentInfo:(void (^)(BOOL isSuccess, NSString *message, NSString *status,UFHomeStudentDataModel * dataModel))completionBlock;
////get news List
//-(void) homeGetNews:(NSDictionary *)paramDictionary CompletionBlock:(void (^)(BOOL isSuccess, NSString *message, NSString *status,NSArray *resultArray))completionBlock;


@end
