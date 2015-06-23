//
//  INDataController.m
//  iNews
//
//  Created by xiao wen on 13-12-19.
//  Copyright (c) 2014年 zwd. All rights reserved.
//

#import "DataController.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPRequestOperation.h"
#import "JSONModel.h"
#import "NetWorkManage.h"
#import "UICommonFunc.h"


#import "SDDataCacheManager.h"
#import "NSString+DCAdditions.h"
#import "NSString+MD5.h"
#import "JSONKit.h"
#import "AESCrypt.h"
#import "Encryption.h"
#import "NSString+Base64.h"
#import "UFUserDefault.h"

@implementation DataController


static NSString* API_URL = @"http://3inews.cn:8080/inrs//mobile/SpreadSrv?app=%@&act=%@";





+ (DataController *)shareDataController
{
    
    static DataController *_sharedDataController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedDataController = [[self alloc] init];
        [[NetWorkManage sharedInstance]startNetWorkeWatch:nil];
    });
    return _sharedDataController;
}

+ (NSString*) packApiUrl:(NSString*)strMethodApp withMethod:(NSString*)strMethodName
{
    NSString* strApiUrl = nil;
    strApiUrl = [NSString stringWithFormat:API_URL,strMethodApp,strMethodName];
    return strApiUrl;
}

- (void)setAppBaseUrl:(NSString*)baseUrl
{
    API_URL = [NSString stringWithFormat:@"http://%@/inrs/mobile/SpreadSrv?%@", baseUrl, @"app=%@&act=%@"];
}

-(void)willReturnYesOrNo:(block_willReturn)block{
    self.blockReturn = block;
}

- (BOOL) requestNewsWithMethodInfo:(id)param methodApp:(NSString*) methodApp methodName:(NSString*) methodName notify:(id)object success:(SEL)onSuccess failure:(SEL)onFailure
{

//    if (![NetWorkManage sharedInstance].netWorkIsEnabled)
//    {
//        [object performSelector:onFailure withObject:nil];
//        [UICommonFunc showNotNewWork];
//        return NO;
//    }



    __block BOOL willReturn;
    [self willReturnYesOrNo:^(BOOL yesOrNo) {
        if (yesOrNo == YES) {
            willReturn = YES;
        }else{
            willReturn = NO;
        }
    }];

    NSString* url = [DataController packApiUrl:methodApp withMethod:methodName];
    NSDictionary* paramDict = [param toDictionary];
    //    NSDictionary* paramDict = [NSDictionary di dictionaryWithObject:params];
    [self sendHttpRequest:url parameters:paramDict notify:object success:onSuccess failure:onFailure ];

    return willReturn;
}

- (void)sendHttpRequest:(NSString*)url parameters:(NSDictionary *)parameters notify:(id)object success:(SEL)onSuccess failure:(SEL)onFailure
{



    BOOL netWorkIsEnabled = [NetWorkManage sharedInstance].netWorkIsEnabled;
    NSLog(@"-------->%d",netWorkIsEnabled);
    NSString * storeKey=[self coverDicToString:parameters withURLString:url];

    //网络不可用，读取本地缓存数据
    if (!netWorkIsEnabled) {
        if (self.blockReturn) {
            self.blockReturn(NO);
        }
        if (storeKey) {
            id storedata=[[SDDataCacheManager sharedManager] dataFromKey:storeKey fromDisk:YES];
            if (storedata) {
                NSDictionary * dic = [self coverDataToDic:storedata];

                //没网络，没数据
                if ([[dic objectForKey:@"data"] count] == 0 || [[dic objectForKey:@"retcode"]integerValue] == 0) {
                    [object performSelector:onFailure withObject:dic];
                    [UICommonFunc showNotNewWork];

                }else{
                    [object performSelector:onSuccess withObject:dic];
                }
//                [UICommonFunc showHideLoadingView:NO];
            }else{
                [object performSelector:onFailure withObject:nil];
                [UICommonFunc showNotNewWork];

//                [UICommonFunc showHideLoadingView:NO];
            }
        }

        
    }else{

        if (self.blockReturn) {
            self.blockReturn(YES);
        }

        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        //    [manager setResponseSerializer:[[AFHTTPResponseSerializer alloc]init]];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:(id)@"text/plain"];//@"text/html"];
    //    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [object performSelector:onSuccess withObject:responseObject];



            //本地缓存
            if (storeKey) {
                if (!responseObject){
                    [[SDDataCacheManager sharedManager] removeDataForKey:storeKey];
                }else{

                    [[SDDataCacheManager sharedManager] storeData:[self coverDicToData:responseObject] forKey:storeKey toDisk:YES];
                }
            }


    //        DLog(@"JSON: %@", responseObject);
            //         DLog(@"JSON: %@", [operation response] );
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [object performSelector:onFailure withObject:error];
            NSLog(@"Error: %@", error);
        }];


    }
}


-(NSString *)coverDicToString:(NSDictionary *)dic withURLString:(NSString *)urlString{
    NSString * resultString = nil;
    if ([NSJSONSerialization isValidJSONObject:dic]) {
        NSError *error;
        NSData *registerData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
        NSString * tempString = [[NSString alloc] initWithData:registerData encoding:NSUTF8StringEncoding];
        resultString = [[tempString stringByAppendingString:tempString] md5];
    }
    return resultString;
}

-(NSData *)coverDicToData:(NSDictionary *)dic{
    NSData * resultData = nil;
    if ([NSJSONSerialization isValidJSONObject:dic]) {
        NSError *error;
        resultData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    }
    return resultData;
}

-(NSDictionary *)coverDataToDic:(NSData *)data{
    NSError *error;
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (error) {
        return nil;
    }
    return dic;

}


+(void)sendHttpRequestBlock_strMethodApp:(NSString*)strMethodApp strMethodName:(NSString *)strMethodName parameters:(NSDictionary *)parameters useCache:(BOOL)cache success:(networkOnSuccess)onSuccess failure:(networkOnFailure)onFailure{

    NSString * url = [DataController packApiUrl:strMethodApp withMethod:strMethodName];

    [[DataController shareDataController] sendHttpRequestBlock:url parameters:parameters useCache:cache success:onSuccess failure:onFailure];

}


- (void)sendHttpRequestBlock:(NSString*)url parameters:(NSDictionary *)parameters useCache:(BOOL)useCache success:(networkOnSuccess)onSuccess failure:(networkOnFailure)onFailure{

    BOOL netWorkIsEnabled = [NetWorkManage sharedInstance].netWorkIsEnabled;

    NSString * storeKey=[self coverDicToString:parameters withURLString:url];

    //网络不可用，读取本地缓存数据
    if (!netWorkIsEnabled) {
        if (storeKey) {
            id storedata=[[SDDataCacheManager sharedManager] dataFromKey:storeKey fromDisk:YES];
            if (storedata) {
                NSDictionary * dic = [self coverDataToDic:storedata];
                if ([[dic objectForKey:@"data"] count] == 0 || [[dic objectForKey:@"retcode"]integerValue] == 0) {
                    //没网络，之前请求正常，但没数据
                    if (onFailure) {
                        [UICommonFunc showNotNewWork];
                        onFailure(nil,nil,YES);
                    }
                }else{
                    //没网络，有数据
                    if (onSuccess) {
                        onSuccess(nil,dic,YES);
                    }
                }
            }else{
                if (onFailure) {
                    [UICommonFunc showNotNewWork];
                    onFailure(nil,nil,YES);
                }
            }
        }


    }else{

        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:(id)@"application/json"];//@"text/html"];
#if 0
        [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {

//            NSString * timestamp = [NSString stringWithFormat:@"%lld",(long long)[[NSDate date] timeIntervalSince1970]];
//            NSString * onceTemp = [NSString stringWithFormat:@"%@",[[NSUUID UUID] UUIDString]];
//            NSString * once = [onceTemp stringByReplacingOccurrencesOfString:@"-" withString:@""];
//
//            NSString * imeiTemp = [NSString stringWithFormat:@"%@",[[NSUUID UUID] UUIDString]];
//            NSString * imei = [imeiTemp stringByReplacingOccurrencesOfString:@"-" withString:@""];

//            [formData appendPartWithFormData:[NSData data] name:@"client_id"];
//            [formData appendPartWithFormData:[timestamp dataUsingEncoding:NSUTF8StringEncoding] name:@"timestamp"];
//            [formData appendPartWithFormData:[once dataUsingEncoding:NSUTF8StringEncoding] name:@"once"];
//            [formData appendPartWithFormData:[imei dataUsingEncoding:NSUTF8StringEncoding] name:@"imei"];
//            [formData appendPartWithFormData:[NSData data] name:@"api_token"];
//            [formData appendPartWithFormData:[NSData data] name:@"signature"];
//            [formData appendPartWithFormData:[NSData data] name:@"ciphertext"];

        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (onSuccess) {
                onSuccess(operation,responseObject,NO);
            }

            //本地缓存
            if (useCache && storeKey) {
                if (!responseObject){
                    [[SDDataCacheManager sharedManager] removeDataForKey:storeKey];
                }else{

                    [[SDDataCacheManager sharedManager] storeData:[self coverDicToData:responseObject] forKey:storeKey toDisk:YES];
                }
            }

        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (onFailure) {
                onFailure(operation,error,NO);
            }

        }];
#else
        [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (onSuccess) {
                onSuccess(operation,responseObject,NO);
            }

            //本地缓存
            if (useCache && storeKey) {
                if (!responseObject){
                    [[SDDataCacheManager sharedManager] removeDataForKey:storeKey];
                }else{

                    [[SDDataCacheManager sharedManager] storeData:[self coverDicToData:responseObject] forKey:storeKey toDisk:YES];
                }
            }

        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (onFailure) {
                onFailure(operation,error,NO);
            }
            
        }] ;
#endif

        
    }
}



/**
 *  上传图片，用流的方式
 *
 *  @param param      POST参数（JsonModel）
 *  @param methodApp  <#methodApp description#>
 *  @param methodName <#methodName description#>
 *  @param dataArray  图片数组（image的data）
 *  @param object     实现成功跟失败方法的实例
 *  @param onSuccess  成功方法
 *  @param onFailure  失败方法
 *
 *  @return 请求成功或者失败
 */
- (BOOL) requestNewsWithMethodInfo:(id)param methodApp:(NSString*) methodApp methodName:(NSString*) methodName imageDataArray:(NSArray *)dataArray notify:(id)object success:(SEL)onSuccess failure:(SEL)onFailure{


    if (![NetWorkManage sharedInstance].netWorkIsEnabled)
    {
        [object performSelector:onFailure withObject:nil];
        [UICommonFunc showNotNewWork];
        return NO;
    }



    NSString* url = [DataController packApiUrl:methodApp withMethod:methodName];
    NSDictionary* paramDict = [param toDictionary];
    [self sendHttpRequest:url parameters:paramDict imageDataArray:(NSArray *)dataArray notify:object success:onSuccess failure:onFailure ];
    return YES;

}

- (void)sendHttpRequest:(NSString*)url parameters:(NSDictionary *)parameters imageDataArray:(NSArray *)dataArray notify:(id)object success:(SEL)onSuccess failure:(SEL)onFailure
{


    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:(id)@"text/plain"];//@"text/html"];

    [[manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {

        int currentPage = 0;
        for (NSData * imageData in dataArray) {
            [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"%d",currentPage] fileName:[NSString stringWithFormat:@"%d.jpg",currentPage]  mimeType:@"image/jpeg"];
            currentPage++;
        }

    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [object performSelector:onSuccess withObject:responseObject];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [object performSelector:onFailure withObject:error];

    }] setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
         NSLog(@"Sent %lld of %lld bytes", totalBytesWritten, totalBytesExpectedToWrite);
    }];

}

-(NSString *)getCurrentURLWithoutParamterMethodApp:(NSString *)methodApp MethodName:(NSString *)methodName{
    return [DataController packApiUrl:methodApp withMethod:methodName];
}


#pragma mark - aiDian

+ (NSString *)encryptKey:(NSString *)key dict:(NSDictionary *)dict
{
    NSData *jsonData=[dict JSONData];
    NSString *aesEncryptdString=[[jsonData AES256EncryptWithKey:key] base64EncodedStringWithOptions:0];
    return aesEncryptdString;
}


+ (NSDictionary *)decyptyKey:(NSString *)key encryptedString:(NSString *)string
{
    NSData *base64Decode = [string base64DecodedData];
    NSData *encryptData = [base64Decode AES256DecryptWithKey:key];
    NSDictionary *dict=(NSDictionary *)[encryptData objectFromJSONData];
    return dict;
}

+ (NSData *)decyptyKeyWithData:(NSString *)key encryptedString:(NSString *)string
{
    NSData *base64Decode = [string base64DecodedData];
    NSData *encryptData = [base64Decode AES256DecryptWithKey:key];
    return encryptData;
}


+ (NSString *)getOnce
{
    NSString *string=@"";
    for (int i=0; i<32; i++) {
        NSNumber *randomNumber = [NSNumber numberWithInt:arc4random() % 10];
        string=[NSString stringWithFormat:@"%@%@",string,[randomNumber stringValue]];
    }
    return string;
}
+ (NSString *)getCurrentTimeInSeconds
{
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970]*1000.0;
    long long int timeStamp = (long long int)time;
    return [NSString stringWithFormat:@"%lld",timeStamp];
}
+ (NSString *)getJsonStringFromDict:(NSDictionary *)dict
{
    return [dict JSONString];
}

+ (NSString *)getMD5String:(NSString *)string
{
    return [string MD5];
}


//+ (NSMutableDictionary *)getLoginParamDict:(NSDictionary *)dict
//{
//    //current time
//    NSString *timeStampString=[DataController getCurrentTimeInSeconds];
//    
//    //get 32 digital random once
//    NSString *once=[DataController getOnce];
//    
//    //dict to string (no encrypt) for signature
//    NSString *jsonString=[DataController getJsonStringFromDict:dict];
//    
//    //cipherted content
//    NSString *aesEncryptdString=[DataController encryptKey:client_secret dict:dict];
//    
//    
//    
//    //imei
//    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"imei"] == nil) {
//        NSString * tempString = [[NSUUID UUID] UUIDString];
//        NSString * imeiString = [tempString stringByReplacingOccurrencesOfString:@"-" withString:@""];
//        [[NSUserDefaults standardUserDefaults]setObject:imeiString forKey:@"imei"];
//        [[NSUserDefaults standardUserDefaults]synchronize];
//    }
//    
//    //signature
//    NSString *string=[NSString stringWithFormat:@"client_id=%@&client_secret=%@&timestamp=%@&once=%@&parameters=%@&imei=%@",client_id,client_secret,timeStampString,once,jsonString,[[NSUserDefaults standardUserDefaults] objectForKey:@"imei"]];
//    NSString *signatureString=[DataController getMD5String:string];
//    
//    NSMutableDictionary *paramDict= [[NSMutableDictionary alloc]init];
//    [paramDict setValue:client_id forKey:@"client_id"];
//    [paramDict setValue:timeStampString forKey:@"timestamp"];
//    [paramDict setValue:once forKey:@"once"];
//    [paramDict setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"imei"] forKey:@"imei"];
//    
//    [paramDict setValue:signatureString forKey:@"signature"];
//    [paramDict setValue:aesEncryptdString forKey:@"ciphertext"];
//    
//    return paramDict;
//}



//+ (NSMutableDictionary *)getRequestParamDict:(NSDictionary *)dict
//{
//    UFUserDefault *userDefault = [UFUserDefault shared];
//
//#if 1
//    userDefault.apiToken = @"6ede7e9e98903620b0c08e2caaa045b67cfec65b";
//    userDefault.apiSecret = @"huyuCu6NSFHc3WOM";
//    NSString * imei = @"6DFDA4ED00DF4839A0A7B5363D17547F";
//#endif
//
//
//
//
//    //get 32 digital random once
//    NSString *once=[DataController getOnce];
//    
//    //current time
//    NSString *timeStampString=[DataController getCurrentTimeInSeconds];
//    
//    //dict to string (no encrypt) for signature
//    NSString *jsonString=[DataController getJsonStringFromDict:dict];
//    
//    //cipherted content
//    NSString *aesEncryptdString=[DataController encryptKey:userDefault.apiSecret dict:dict];//todo 需要授权验证
//    
//    //imei
//    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"imei"] == nil) {
//        NSString * tempString = [[NSUUID UUID] UUIDString];
//        NSString * imeiString = [tempString stringByReplacingOccurrencesOfString:@"-" withString:@""];
//        [[NSUserDefaults standardUserDefaults]setObject:imeiString forKey:@"imei"];
//        [[NSUserDefaults standardUserDefaults]synchronize];
//    }
//    
//    //signature
//
////    NSString *string=[NSString stringWithFormat:@"client_id=%@&client_secret=%@&timestamp=%@&once=%@&parameters=%@&imei=%@",client_id,userDefault.apiSecret,timeStampString,once,jsonString,[[NSUserDefaults standardUserDefaults] objectForKey:@"imei"]];
//
//
//
//
////    NSString *string=[NSString stringWithFormat:@"client_id=%@&client_secret=%@&timestamp=%@&once=%@&parameters=%@&imei=%@",client_id,userDefault.apiSecret,timeStampString,once,jsonString,[[NSUserDefaults standardUserDefaults] objectForKey:@"imei"]];
//     NSString *string=[NSString stringWithFormat:@"client_id=%@&client_secret=%@&timestamp=%@&once=%@&parameters=%@&imei=%@",client_id,userDefault.apiSecret,timeStampString,once,jsonString,imei];
//
//    NSString *signatureString=[DataController getMD5String:string];
//    
//    NSMutableDictionary *paramDict= [[NSMutableDictionary alloc]init];
//    [paramDict setValue:client_id forKey:@"client_id"];
//    [paramDict setValue:timeStampString forKey:@"timestamp"];
//    [paramDict setValue:userDefault.apiToken forKey:@"api_token"];//todo 需要授权验证
//    [paramDict setValue:imei forKey:@"imei"];
//    [paramDict setValue:signatureString forKey:@"signature"];
//    [paramDict setValue:aesEncryptdString forKey:@"ciphertext"];
//    [paramDict setValue:once forKey:@"once"];
//    return paramDict;
//
//    
//}
//高尔夫请求参数
//+(NSDictionary *)getGolfRequestParamDict:(NSDictionary *)dict method:(NSString *)method
//{
//    NSMutableDictionary *paramDict= [[NSMutableDictionary alloc]init];
//    [paramDict setValue:device_Type forKey:@"device"];
//    [paramDict setValue:@"0.25" forKey:@"version"];
//    [paramDict setValue:method forKey:@"command"];
//    [paramDict setValue:dict  forKey:@"data"];
//    NSString *aesEncryptdString=[DataController encryptKey:@"XcKi0k89" dict:dict];
//
//    return @{@"golf":aesEncryptdString};
//}
@end
