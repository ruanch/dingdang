//
//  UFNetWorkAPIClient.m
//  universityFace
//
//  Created by 阮 沧晖 on 14-9-26.
//  Copyright (c) 2014年 阮 沧晖. All rights reserved.
//

#import "DDNetWorkAPIClient.h"
#import "DataController.h"

@implementation UFNetWorkAPIClient
- (id)init
{
    if ([super init]) {
    }
    return self;
}

//#pragma mark AUTH:认证接口
//-(void)userLogin:(NSDictionary *)userDictionary CompletionBlock:(void (^)(BOOL isSuccess, NSString *message, NSString *status))completionBlock
//{
//    DataController *data = [DataController shareDataController];
//    NSMutableDictionary *paramDict= [DataController getLoginParamDict:userDictionary];
//    NSString *urlWithString = [[UFAPI shared] urlStringWithModuleLoginTag:kUFLogin];
//    [data sendHttpRequestBlock:urlWithString parameters:paramDict useCache:NO success:^(AFHTTPRequestOperation *operation, id responseObject, BOOL dataIsFromDisk) {
//        NSDictionary *JSON = responseObject;
//        //[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSString *message=@"";
//        NSString *status=@"";
//        if (JSON != [NSNull class]){
//            
//            status=[[JSON objectForKey:@"status"] stringValue];
//            message = [self requestStatusRusultMessage:[status intValue]];
//            if ([[JSON objectForKey:@"success"]intValue]==1) {
//                
//                NSDictionary *dataDict = [DataController decyptyKey:client_secret encryptedString:[JSON objectForKey:@"data"]];
//                
//                UFUserDefault *userDefault = [UFUserDefault shared];
//                userDefault.apiSecret = [dataDict objectForKey:@"api_secret"];
//                userDefault.apiToken = [dataDict objectForKey:@"api_token"];
//                userDefault.serverUrl = [dataDict objectForKey:@"serverurl"];
//                userDefault.userId = [dataDict objectForKey:@"userid"];
//                userDefault.usertype = [dataDict objectForKey:@"usertype"];
//                
//            }else{
//                NSLog(@"========%@=======",status);
//            }
//        }
//        completionBlock(YES,message, status);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error, BOOL dataIsFromDisk) {
//        //Dlog(@"call userLogin failed %ld", (long)operation.response.statusCode);
//        NSLog(@"%@",error.userInfo);
//        completionBlock(NO, nil, nil);
//    }];
//}
//
//-(void)userLoginOut:(NSDictionary *)userDictionary CompletionBlock:(void (^)(BOOL isSuccess, NSString *message, NSString *status))completionBlock
//{
//    DataController *data = [DataController shareDataController];
//    NSMutableDictionary *paramDict= [DataController getRequestParamDict:userDictionary];
//    NSString *urlWithString = [[UFAPI shared] urlStringWithModuleLoginTag:kUFLoginOut];
//    [data sendHttpRequestBlock:urlWithString parameters:paramDict useCache:NO success:^(AFHTTPRequestOperation *operation, id responseObject, BOOL dataIsFromDisk) {
//        NSDictionary *JSON = responseObject;
//        NSString *message=@"";
//        NSString *status=@"";
//        if (JSON != [NSNull class]){
//            status=[[JSON objectForKey:@"status"] stringValue];
//            message = [self requestStatusRusultMessage:[status intValue]];
//            if ([[JSON objectForKey:@"success"]intValue]==1) {
//                
//                //NSString *result = [JSON objectForKey:@"result"];
//                message = @"注销成功";
//                status = @"1";
//            }
//        }
//        completionBlock(YES,message, status);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error, BOOL dataIsFromDisk) {
//        //Dlog(@"call userLogin failed %ld", (long)operation.response.statusCode);
//        NSLog(@"%@",error.userInfo);
//        completionBlock(NO, nil, nil);
//    }];
//}
//
//-(void)userUpdatePassword:(NSString *)newPassword withOldPassword:(NSString *)oldPassword CompletionBlock:(void (^)(BOOL isSuccess, NSString *message, NSString *status))completionBlock
//{
//    DataController *data = [DataController shareDataController];
//    
//    NSString *aesNewPassword = [DataController encryptKey:client_secret dict:[NSDictionary dictionaryWithObjectsAndKeys:newPassword,@"newpassword", nil]];
//    NSString *aesOldPassword = [DataController encryptKey:client_secret dict:[NSDictionary dictionaryWithObjectsAndKeys:oldPassword,@"oldpassword", nil]];
//    NSDictionary *userDictionary = [NSDictionary dictionaryWithObjectsAndKeys:aesNewPassword,@"newpassword",aesOldPassword,@"oldpassword", nil];
//    
//    
//    NSMutableDictionary *paramDict= [DataController getRequestParamDict:userDictionary];
//    NSString *urlWithString = [[UFAPI shared] urlStringWithModuleLoginTag:kUFUpdatePassWord];
//    [data sendHttpRequestBlock:urlWithString parameters:paramDict useCache:NO success:^(AFHTTPRequestOperation *operation, id responseObject, BOOL dataIsFromDisk) {
//        NSDictionary *JSON = responseObject;
//        NSString *message=@"";
//        NSString *status=@"";
//        if (JSON != [NSNull class]){
//            status=[[JSON objectForKey:@"status"] stringValue];
//            message = [self requestStatusRusultMessage:[status intValue]];
//            if ([[JSON objectForKey:@"success"]intValue]==1) {
//                
//            }
//            else
//            {
//                
//            }
//        }
//        completionBlock(YES,message, status);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error, BOOL dataIsFromDisk) {
//        //Dlog(@"call userLogin failed %ld", (long)operation.response.statusCode);
//        NSLog(@"%@",error.userInfo);
//        completionBlock(NO, nil, nil);
//    }];
//}
////sned smsCode
//-(void)userSendSmsCode:(NSString *)userName CompletionBlock:(void (^)(BOOL isSuccess, NSString *message, NSString *status))completionBlock
//{
//    DataController *data = [DataController shareDataController];
//    NSDictionary *userDictionary = [NSDictionary dictionaryWithObjectsAndKeys:userName,@"username", nil];
//    NSMutableDictionary *paramDict= [DataController getRequestParamDict:userDictionary];
//    NSString *urlWithString = [[UFAPI shared] urlStringWithModuleLoginTag:kUFSendSms];
//    [data sendHttpRequestBlock:urlWithString parameters:paramDict useCache:NO success:^(AFHTTPRequestOperation *operation, id responseObject, BOOL dataIsFromDisk) {
//        NSDictionary *JSON = responseObject;
//        NSString *message=@"";
//        NSString *status=@"";
//        if (JSON != [NSNull class]){
//            status=[[JSON objectForKey:@"status"] stringValue];
//            message = [self requestStatusRusultMessage:[status intValue]];
//            if ([[JSON objectForKey:@"success"]intValue]==1) {
//        
//                UFUserDefault *userDefault = [UFUserDefault shared];
//                NSDictionary *dataDict = [DataController decyptyKey:userDefault.apiSecret encryptedString:[JSON objectForKey:@"data"]];
//                message = [dataDict objectForKey:@"sequence"];
//                completionBlock(YES,message, status);
//            }
//        }
//        completionBlock(YES,message, status);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error, BOOL dataIsFromDisk) {
//        //Dlog(@"call userLogin failed %ld", (long)operation.response.statusCode);
//        NSLog(@"%@",error.userInfo);
//        completionBlock(NO, nil, nil);
//    }];
//}
//-(void)userValidateSmsCode:(NSString *)smsCode withAccountName:(NSString *)accountName  CompletionBlock:(void (^)(BOOL isSuccess, NSString *message, NSString *status))completionBlock
//{
//    DataController *data = [DataController shareDataController];
//    NSDictionary *userDictionary = [NSDictionary dictionaryWithObjectsAndKeys:accountName,@"username",smsCode,@"smscode", nil];
//    NSMutableDictionary *paramDict= [DataController getRequestParamDict:userDictionary];
//    NSString *urlWithString = [[UFAPI shared] urlStringWithModuleLoginTag:kUFValidateSms];
//    [data sendHttpRequestBlock:urlWithString parameters:paramDict useCache:NO success:^(AFHTTPRequestOperation *operation, id responseObject, BOOL dataIsFromDisk) {
//        NSDictionary *JSON = responseObject;
//        NSString *message=@"";
//        NSString *status=@"";
//        if (JSON != [NSNull class]){
//            status=[[JSON objectForKey:@"status"] stringValue];
//            message = [self requestStatusRusultMessage:[status intValue]];
//            if ([[JSON objectForKey:@"success"]intValue]==1) {
//                
//                UFUserDefault *userDefault = [UFUserDefault shared];
//                NSDictionary *dataDict = [DataController decyptyKey:userDefault.apiSecret encryptedString:[JSON objectForKey:@"data"]];
//                status = [dataDict objectForKey:@"status"];
//            }
//        }
//        completionBlock(YES,message, status);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error, BOOL dataIsFromDisk) {
//        //Dlog(@"call userLogin failed %ld", (long)operation.response.statusCode);
//        NSLog(@"%@",error.userInfo);
//        completionBlock(NO, nil, nil);
//    }];
//    
//}
//
//
//-(void)userNoLoginUpdatePassword:(NSString *)newPassword  withAccountUserName:(NSString *)accountName CompletionBlock:(void (^)(BOOL isSuccess, NSString *message, NSString *status))completionBlock
//{
//    DataController *data = [DataController shareDataController];
//    
//    NSString *aesNewPassword = [DataController encryptKey:client_secret dict:[NSDictionary dictionaryWithObjectsAndKeys:newPassword,@"newpassword", nil]];
//    NSDictionary *userDictionary = [NSDictionary dictionaryWithObjectsAndKeys:aesNewPassword,@"newpassword",accountName,@"username", nil];
//    
//    
//    NSMutableDictionary *paramDict= [DataController getRequestParamDict:userDictionary];
//    NSString *urlWithString = [[UFAPI shared] urlStringWithModuleLoginTag:kUFNoLoginUpdatePassWord];
//    [data sendHttpRequestBlock:urlWithString parameters:paramDict useCache:NO success:^(AFHTTPRequestOperation *operation, id responseObject, BOOL dataIsFromDisk) {
//        NSDictionary *JSON = responseObject;
//        NSString *message=@"";
//        NSString *status=@"";
//        if (JSON != [NSNull class]){
//            status=[[JSON objectForKey:@"status"] stringValue];
//            message = [self requestStatusRusultMessage:[status intValue]];
//            if ([[JSON objectForKey:@"success"]intValue]==1) {
//                
//                UFUserDefault *userDefault = [UFUserDefault shared];
//                NSDictionary *dataDict = [DataController decyptyKey:userDefault.apiSecret encryptedString:[JSON objectForKey:@"data"]];
//                message = [dataDict objectForKey:@"content"];
//            }
//        }
//        completionBlock(YES,message, status);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error, BOOL dataIsFromDisk) {
//        //Dlog(@"call userLogin failed %ld", (long)operation.response.statusCode);
//        NSLog(@"%@",error.userInfo);
//        completionBlock(NO, nil, nil);
//    }];
//
//}
//
//-(void)userSysTime:(void (^)(BOOL isSuccess, NSString *message, NSString *status))completionBlock
//{
//    DataController *data = [DataController shareDataController];
//    
//    NSDictionary *userDictionary = [[NSDictionary alloc] init];
//    
//    NSMutableDictionary *paramDict= [DataController getRequestParamDict:userDictionary];
//    NSString *urlWithString = [[UFAPI shared] urlStringWithModuleLoginTag:kUFSysTime];
//    [data sendHttpRequestBlock:urlWithString parameters:paramDict useCache:NO success:^(AFHTTPRequestOperation *operation, id responseObject, BOOL dataIsFromDisk) {
//        NSDictionary *JSON = responseObject;
//        NSString *message=@"";
//        NSString *status=@"";
//        if (JSON != [NSNull class]){
//            status=[[JSON objectForKey:@"status"] stringValue];
//            message = [self requestStatusRusultMessage:[status intValue]];
//            if ([[JSON objectForKey:@"success"]intValue]==1) {
//                
//                UFUserDefault *userDefault = [UFUserDefault shared];
//                NSDictionary *dataDict = [DataController decyptyKey:userDefault.apiSecret encryptedString:[JSON objectForKey:@"data"]];
//                
//                message = [dataDict objectForKey:@"systemtime"];
//                
//            }
//        }
//        completionBlock(YES,message, status);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error, BOOL dataIsFromDisk) {
//        //Dlog(@"call userLogin failed %ld", (long)operation.response.statusCode);
//        NSLog(@"%@",error.userInfo);
//        completionBlock(NO, nil, nil);
//    }];
//}
//
//-(NSString *) requestStatusRusultMessage:(int) status
//{
//    NSString *message=@"";
//    switch (status) {
//        case KLoginNameOrPasswordError:
//            message = NSLocalizedString(@"KLoginNameOrPasswordError",nil);
//            break;
//        case KModifyPasswordFail:
//            message = NSLocalizedString(@"KModifyPasswordFail",nil);
//            break;
//        case KRetrievePasswordFail:
//            message = NSLocalizedString(@"KRetrievePasswordFail",nil);
//            break;
//        case KTokenFailOrExprired:
//            message = NSLocalizedString(@"KTokenFailOrExprired",nil);
//            break;
//        case KOtherUndefinedError:
//            message = NSLocalizedString(@"KOtherUndefinedError",nil);
//            break;
//            
//        default:
//            break;
//    }
//    
//    return message;
//}
//
//#pragma mark SCHOOL_API:平台接口
//
//-(void) userInfo:(void (^)(BOOL isSuccess, NSString *message, NSString *status))completionBlock
//{
//    DataController *data = [DataController shareDataController];
//    NSString *urlWithUserInfoString = [[UFAPI shared] urlStringWithModuleHomeTag:kUFGetUserInfo];
//    NSMutableDictionary *paramDict= [DataController getRequestParamDict:[[NSDictionary alloc] init]];
//    [data sendHttpRequestBlock:urlWithUserInfoString parameters:paramDict useCache:NO success:^(AFHTTPRequestOperation *operation, id responseObject, BOOL dataIsFromDisk) {
//        NSDictionary *JSON = responseObject;
//        NSString *message=@"";
//        NSString *status=@"";
//        if (JSON != [NSNull class]){
//            
//            status=[[JSON objectForKey:@"status"] stringValue];
//            message = [self requestStatusRusultMessage:[status intValue]];
//            if ([[JSON objectForKey:@"success"]intValue]==1) {
//                
//                UFUserDefault *userDefault = [UFUserDefault shared];
//                NSDictionary *dataDict = [DataController decyptyKey:userDefault.apiSecret encryptedString:[JSON objectForKey:@"data"]];
//                UFUserInfo *user = [[UFUserInfo alloc] init];
//                user.classid = [[dataDict objectForKey:@"classid"] intValue];
//                user.className = [dataDict objectForKey:@"classid"];
//                user.phone = [dataDict objectForKey:@"phone"];
//                user.age = [dataDict objectForKey:@"age"];
//                user.photo = [dataDict objectForKey:@"photo"];
//                user.position = [dataDict objectForKey:@"position"];
//                user.schoolname = [dataDict objectForKey:@"schoolname"];
//                user.sex = [[dataDict objectForKey:@"sex"] intValue];
//                user.userName = [dataDict objectForKey:@"username"];
//                user.userType = [[dataDict objectForKey:@"usertype"] intValue];
//                
//                userDefault.userInfo = user;
//                
//            }
//        }
//        completionBlock(YES,message, status);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error, BOOL dataIsFromDisk) {
//        //Dlog(@"call userLogin failed %ld", (long)operation.response.statusCode);
//        completionBlock(NO, nil, nil);
//        NSLog(@"%@",error.userInfo);
//    }];
//}
//
//-(void) requestSchoolNotice:(NSDictionary *)requestDictionary CompletionBlock:(void (^)(BOOL isSuccess, NSString *message, NSString *status,NSArray *resultArray))completionBlock
//{
//    DataController *data = [DataController shareDataController];
//    NSString *urlWithUserInfoString = [[UFAPI shared] urlStringWithModuleHomeTag:kUFGetHomePageNews];
//    NSMutableDictionary *paramDict= [DataController getRequestParamDict:requestDictionary];
//    [data sendHttpRequestBlock:urlWithUserInfoString parameters:paramDict useCache:NO success:^(AFHTTPRequestOperation *operation, id responseObject, BOOL dataIsFromDisk) {
//        NSDictionary *JSON = responseObject;
//        NSString *message=@"";
//        NSString *status=@"";
//        NSArray *resultArray = [[NSArray alloc] init];
//        if (JSON != [NSNull class]){
//            
//            status=[[JSON objectForKey:@"status"] stringValue];
//            message = [self requestStatusRusultMessage:[status intValue]];
//            if ([[JSON objectForKey:@"success"]intValue]==1) {
//                
//                NSData *dataDict = [DataController decyptyKeyWithData:[[UFUserDefault shared] apiSecret] encryptedString:[JSON objectForKey:@"data"]];
//                NSString * resultString = [[NSString alloc]initWithData:dataDict encoding:NSUTF8StringEncoding];
//                DLog(@"%@",resultString);
//                UFHomeNewsDataModel * dataModel = [[UFHomeNewsDataModel alloc]initWithString:resultString error:nil];
//                resultArray = dataModel.news_list;
//            }
//        }
//        completionBlock(YES,message, status,resultArray);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error, BOOL dataIsFromDisk) {
//        //Dlog(@"call userLogin failed %ld", (long)operation.response.statusCode);
//        completionBlock(NO, nil, nil,nil);
//        NSLog(@"%@",error.userInfo);
//    }];
//}
//
//
//-(void)updateUserMobilePhone:(NSDictionary *)paramDictionary CompletionBlock:(void (^)(BOOL isSuccess, NSString *message, NSString *status))completionBlock
//{
//    DataController *data = [DataController shareDataController];
//    NSMutableDictionary *paramDict= [DataController getRequestParamDict:paramDictionary];
//    NSString *urlWithUpdateMobilePhoneString = [[UFAPI shared] urlStringWithModuleHomeTag:kUFUpdateMobilePhone];
//    [data sendHttpRequestBlock:urlWithUpdateMobilePhoneString parameters:paramDict useCache:NO success:^(AFHTTPRequestOperation *operation, id responseObject, BOOL dataIsFromDisk) {
//        NSDictionary *JSON = responseObject;
//        NSString *message=@"";
//        NSString *status=@"";
//        if (JSON != [NSNull class]){
//            status=[[JSON objectForKey:@"status"] stringValue];
//            message = [self requestStatusRusultMessage:[status intValue]];
//            if ([[JSON objectForKey:@"success"]intValue]==1) {
//            
//                //NSString *result = [JSON objectForKey:@"result"];
//            }
//        }
//        completionBlock(YES,message, status);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error, BOOL dataIsFromDisk) {
//        //Dlog(@"call userLogin failed %ld", (long)operation.response.statusCode);
//        NSLog(@"%@",error.userInfo);
//        completionBlock(NO, nil, nil);
//    }];
//}
//
//-(void)updateVersion:(void (^)(BOOL isSuccess, NSString *message, NSString *status,NSDictionary *resultDic))completionBlock
//{
//    DataController *data = [DataController shareDataController];
//    NSMutableDictionary *paramDict= [DataController getRequestParamDict:@{}];
//    NSString *urlWithUpdateMobilePhoneString = [[UFAPI shared] urlStringWithModuleHomeTag:KUFGetVersion];
//    [data sendHttpRequestBlock:urlWithUpdateMobilePhoneString parameters:paramDict useCache:NO success:^(AFHTTPRequestOperation *operation, id responseObject, BOOL dataIsFromDisk) {
//        NSDictionary *JSON = responseObject;
//        NSString *message=@"";
//        NSString *status=@"";
//        NSDictionary *dataDict;
//        if (JSON != [NSNull class]){
//            status=[[JSON objectForKey:@"status"] stringValue];
//            message = [self requestStatusRusultMessage:[status intValue]];
//            if ([[JSON objectForKey:@"success"]intValue]==1) {
//                UFUserDefault *userDefault = [UFUserDefault shared];
//                dataDict = [DataController decyptyKey:userDefault.apiSecret encryptedString:[JSON objectForKey:@"data"]];
//            }
//        }
//        completionBlock(YES,message, status,dataDict);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error, BOOL dataIsFromDisk) {
//        //Dlog(@"call userLogin failed %ld", (long)operation.response.statusCode);
//        NSLog(@"%@",error.userInfo);
//        completionBlock(NO, nil, nil,nil);
//    }];
//}
//
//-(void)submitFeedBack:(NSDictionary *)paramDictionary CompletionBlock:(void (^)(BOOL isSuccess, NSString *message, NSString *status))completionBlock
//{
//    DataController *data = [DataController shareDataController];
//    NSMutableDictionary *paramDict= [DataController getRequestParamDict:paramDictionary];
//    NSString *urlWithUpdateMobilePhoneString = [[UFAPI shared] urlStringWithModuleHomeTag:KUFSubmitFeedBack];
//    [data sendHttpRequestBlock:urlWithUpdateMobilePhoneString parameters:paramDict useCache:NO success:^(AFHTTPRequestOperation *operation, id responseObject, BOOL dataIsFromDisk) {
//        NSDictionary *JSON = responseObject;
//        NSString *message=@"";
//        NSString *status=@"";
//        if (JSON != [NSNull class]){
//            status=[[JSON objectForKey:@"status"] stringValue];
//            message = [self requestStatusRusultMessage:[status intValue]];
//            if ([[JSON objectForKey:@"success"]intValue]==1) {
//                
//                
//            }
//        }
//        completionBlock(YES,message, status);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error, BOOL dataIsFromDisk) {
//        //Dlog(@"call userLogin failed %ld", (long)operation.response.statusCode);
//        NSLog(@"%@",error.userInfo);
//        completionBlock(NO, nil, nil);
//    }];
//
//}
//
//
////get teachInfo
//-(void) homePageTeacherInfo:(void (^)(BOOL isSuccess, NSString *message, NSString *status, UFHomeTeachDataModel *dataModel))completionBlock
//{
//    DataController *data = [DataController shareDataController];
//    NSMutableDictionary *paramDict= [DataController getRequestParamDict:@{}];
//    NSString *urlWithTeacherString = [[UFAPI shared] urlStringWithModuleHomeTag:KUFGetHomePageTeacherData];
//    [data sendHttpRequestBlock:urlWithTeacherString parameters:paramDict useCache:NO success:^(AFHTTPRequestOperation *operation, id responseObject, BOOL dataIsFromDisk) {
//        NSDictionary *JSON = responseObject;
//        NSString *message=@"";
//        NSString *status=@"";
//        UFHomeTeachDataModel *dataModel;
//        if (JSON != [NSNull class]){
//            status=[[JSON objectForKey:@"status"] stringValue];
//            message = [self requestStatusRusultMessage:[status intValue]];
//            if ([[JSON objectForKey:@"success"]intValue]==1) {
//                NSData *dataDict = [DataController decyptyKeyWithData:[[UFUserDefault shared] apiSecret] encryptedString:[JSON objectForKey:@"data"]];
//                NSString * resultString = [[NSString alloc]initWithData:dataDict encoding:NSUTF8StringEncoding];
//                DLog(@"%@",resultString);
//                
//                 dataModel = [[UFHomeTeachDataModel alloc]initWithString:resultString error:nil];
//                
//            }
//        }
//        completionBlock(YES,message, status,dataModel);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error, BOOL dataIsFromDisk) {
//        //Dlog(@"call userLogin failed %ld", (long)operation.response.statusCode);
//        NSLog(@"%@",error.userInfo);
//        completionBlock(NO, nil, nil,nil);
//    }];
//}
////get studentInfo
//-(void) homePageStudentInfo:(void (^)(BOOL isSuccess, NSString *message, NSString *status,UFHomeStudentDataModel * dataModel))completionBlock
//{
//    DataController *data = [DataController shareDataController];
//    NSMutableDictionary *paramDict= [DataController getRequestParamDict:@{}];
//    NSString *urlWithStudentInfoString = [[UFAPI shared] urlStringWithModuleHomeTag:KUFGetHomePageStudentData];
//    [data sendHttpRequestBlock:urlWithStudentInfoString parameters:paramDict useCache:NO success:^(AFHTTPRequestOperation *operation, id responseObject, BOOL dataIsFromDisk) {
//        NSDictionary *JSON = responseObject;
//        NSString *message=@"";
//        NSString *status=@"";
//        UFHomeStudentDataModel * dataModel;
//        if (JSON != [NSNull class]){
//            status=[[JSON objectForKey:@"status"] stringValue];
//            message = [self requestStatusRusultMessage:[status intValue]];
//            if ([[JSON objectForKey:@"success"]intValue]==1) {
//                
//                NSData *dataDict = [DataController decyptyKeyWithData:[[UFUserDefault shared] apiSecret] encryptedString:[JSON objectForKey:@"data"]];
//                NSString * resultString = [[NSString alloc]initWithData:dataDict encoding:NSUTF8StringEncoding];
//                DLog(@"%@",resultString);
//                dataModel = [[UFHomeStudentDataModel alloc]initWithString:resultString error:nil];
//            }
//        }
//        completionBlock(YES,message, status,dataModel);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error, BOOL dataIsFromDisk) {
//        //Dlog(@"call userLogin failed %ld", (long)operation.response.statusCode);
//        NSLog(@"%@",error.userInfo);
//        completionBlock(NO, nil, nil,nil);
//    }];
//}
//
//-(void) homeGetNews:(NSDictionary *)paramDictionary CompletionBlock:(void (^)(BOOL isSuccess, NSString *message, NSString *status,NSArray *resultArray))completionBlock
//{
//    DataController *data = [DataController shareDataController];
//    NSString *urlWithUserInfoString = [[UFAPI shared] urlStringWithModuleHomeTag:kUFGetNews];
//    NSMutableDictionary *paramDict= [DataController getRequestParamDict:paramDictionary];
//    [data sendHttpRequestBlock:urlWithUserInfoString parameters:paramDict useCache:NO success:^(AFHTTPRequestOperation *operation, id responseObject, BOOL dataIsFromDisk) {
//        NSDictionary *JSON = responseObject;
//        NSString *message=@"";
//        NSString *status=@"";
//        NSArray *resultArray = [[NSArray alloc] init];
//        if (JSON != [NSNull class]){
//            
//            status=[[JSON objectForKey:@"status"] stringValue];
//            message = [self requestStatusRusultMessage:[status intValue]];
//            if ([[JSON objectForKey:@"success"]intValue]==1) {
//                
//                NSData *dataDict = [DataController decyptyKeyWithData:[[UFUserDefault shared] apiSecret] encryptedString:[JSON objectForKey:@"data"]];
//                NSString * resultString = [[NSString alloc]initWithData:dataDict encoding:NSUTF8StringEncoding];
//                DLog(@"%@",resultString);
//                UFHomeNewsDataModel * dataModel = [[UFHomeNewsDataModel alloc]initWithString:resultString error:nil];
//                resultArray = dataModel.news_list;
//            }
//        }
//        completionBlock(YES,message, status,resultArray);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error, BOOL dataIsFromDisk) {
//        //Dlog(@"call userLogin failed %ld", (long)operation.response.statusCode);
//        completionBlock(NO, nil, nil,nil);
//        NSLog(@"%@",error.userInfo);
//    }];
//}
@end
