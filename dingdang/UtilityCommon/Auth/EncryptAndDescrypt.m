//
//  HomeViewController.h
//  AiDian
//
//  Created by Oliver Zheng on 14-4-10.
//  Copyright (c) 2014年 JiHeNet. All rights reserved.
//

#import "EncryptAndDescrypt.h"
#import "Encryption.h"
#import "NSData+Base64.h"
#import "NSString+Base64.h"
#import "TimeUtinity.h"
#import "JSONKit.h"
#import "NSString+MD5.h"

#import "NSDictionary+Helper.h"

@implementation EncryptAndDescrypt

+ (NSString *)encryptKey:(NSString *)key dict:(NSDictionary *)dict
{
    NSData *jsonData=[dict tranformToData];
    NSString *aesEncryptdString=[[jsonData AES256EncryptWithKey:key] base64EncodedString];
    return aesEncryptdString;
}

+ (NSDictionary *)decyptyKey:(NSString *)key encryptedString:(NSString *)string
{
    NSData *base64Decode = [string base64DecodedData];
    NSData *encryptData = [base64Decode AES256DecryptWithKey:key];
    NSDictionary *dict=(NSDictionary *)[encryptData objectFromJSONData];
    return dict;
}

+ (NSString *)getCurrentTimeInSeconds
{
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970]*1000.0;
    long long int timeStamp = (long long int)time;
    return [NSString stringWithFormat:@"%lld",timeStamp];
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
//    NSString *timeStampString=[[EncryptAndDescrypt class]getCurrentTimeInSeconds];
//    
//    //get 32 digital random once
//    NSString *once=[[EncryptAndDescrypt class]getOnce];
//    
//    //dict to string (no encrypt) for signature
//    NSString *jsonString=[[EncryptAndDescrypt class]getJsonStringFromDict:dict];
//    
//    //cipherted content
//    NSString *aesEncryptdString=[[EncryptAndDescrypt class]encryptKey:client_secret dict:dict];
//    
//    //signature
//    NSString *string=[NSString stringWithFormat:@"client_id=%@&client_secret=%@&timestamp=%@&once=%@&parameters=%@",client_id,client_secret,timeStampString,once,jsonString];
//    NSString *signatureString=[[EncryptAndDescrypt class]getMD5String:string];
//    
//    NSMutableDictionary *paramDict= [[NSMutableDictionary alloc]init];
//    [paramDict setValue:client_id forKey:@"client_id"];
//    [paramDict setValue:timeStampString forKey:@"timestamp"];
//    [paramDict setValue:once forKey:@"once"];
//    [paramDict setValue:signatureString forKey:@"signature"];
//    [paramDict setValue:aesEncryptdString forKey:@"ciphertext"];
//   // [paramDict setValue:[OpenUDID value] forKeyPath:@"imei"];
//    
//    return paramDict;
//}

//+ (NSMutableDictionary *)getRequestParamDict:(NSDictionary *)dict
//{
//    //get 32 digital random once
//    NSString *once=[[EncryptAndDescrypt class]getOnce];
//    
//    //current time
//    NSString *timeStampString=[[EncryptAndDescrypt class]getCurrentTimeInSeconds];
//    
//    //dict to string (no encrypt) for signature
//    NSString *jsonString=[[EncryptAndDescrypt class]getJsonStringFromDict:dict];
//    
//    //cipherted content
//    NSString *aesEncryptdString=[[EncryptAndDescrypt class]encryptKey:[User sharedUser].api_secret dict:dict];
//    
//    //signature
//    NSString *string=[NSString stringWithFormat:@"client_id=%@&api_secret=%@&timestamp=%@&once=%@&api_token=%@&parameters=%@",client_id,[User sharedUser].api_secret,timeStampString,once,[User sharedUser].api_token,jsonString];
//    NSString *signatureString=[[EncryptAndDescrypt class]getMD5String:string];
//    
//    NSMutableDictionary *paramDict= [[NSMutableDictionary alloc]init];
//    [paramDict setValue:client_id forKey:@"client_id"];
//    [paramDict setValue:timeStampString forKey:@"timestamp"];
//    [paramDict setValue:[User sharedUser].api_token forKey:@"api_token"];
//    [paramDict setValue:signatureString forKey:@"signature"];
//    [paramDict setValue:aesEncryptdString forKey:@"ciphertext"];
//    [paramDict setValue:once forKey:@"once"];
//    return paramDict;
//}

@end
