//
//  INDataController.h
//  iNews
//
//  Created by zwd on 14-7-7.
//  Copyright (c) 2014年 zwd. All rights reserved.
//

@class AFHTTPRequestOperation;

typedef void(^networkOnSuccess)(AFHTTPRequestOperation *operation, id responseObject, BOOL dataIsFromDisk);
typedef void(^networkOnFailure)(AFHTTPRequestOperation *operation, NSError *error,BOOL dataIsFromDisk);



typedef void(^block_willReturn)(BOOL yesOrNo);


@interface DataController : NSObject


@property(nonatomic,copy)block_willReturn blockReturn;

-(void)willReturnYesOrNo:(block_willReturn)block;

+ (DataController*)shareDataController;


- (BOOL) requestNewsWithMethodInfo:(id)param methodApp:(NSString*) methodApp methodName:(NSString*) methodName notify:(id)object success:(SEL)onSuccess failure:(SEL)onFailure;


+(void)sendHttpRequestBlock_strMethodApp:(NSString*)strMethodApp strMethodName:(NSString *)strMethodName parameters:(NSDictionary *)parameters useCache:(BOOL)cache success:(networkOnSuccess)onSuccess failure:(networkOnFailure)onFailure;

- (void)sendHttpRequestBlock:(NSString*)url parameters:(NSDictionary *)parameters useCache:(BOOL)useCache success:(networkOnSuccess)onSuccess failure:(networkOnFailure)onFailure;

- (void)setAppBaseUrl:(NSString*)baseUrl;

//获取不带参数的url
-(NSString *)getCurrentURLWithoutParamterMethodApp:(NSString *)methodApp MethodName:(NSString *)methodName;



/**
 *  上传图片，用流的方式
 *
 *  @param param      POST参数（JsonModel）
 *  @param methodApp  methodApp
 *  @param methodName methodName
 *  @param dataArray  图片数组（image的data）
 *  @param object     实现成功跟失败方法的实例
 *  @param onSuccess  成功方法
 *  @param onFailure  失败方法
 *
 *  @return 请求成功或者失败
 */
- (BOOL) requestNewsWithMethodInfo:(id)param methodApp:(NSString*) methodApp methodName:(NSString*) methodName imageDataArray:(NSArray *)dataArray notify:(id)object success:(SEL)onSuccess failure:(SEL)onFailure;



/**
 *  普通接口拼接参数
 *
 *  @param dict    ciphertext 参数
 *
 *  @return 处理过的字典
 */
+ (NSMutableDictionary *)getRequestParamDict:(NSDictionary *)dict;

/**
 *  登录时参数   暂时只有返回6个字段，具体接口出来需要调整
 *
 *  @param dict 登录时的用户名密码
 *
 *  @return 登录接口用参数
 */
+ (NSMutableDictionary *)getLoginParamDict:(NSDictionary *)dict;

+ (NSDictionary *)decyptyKey:(NSString *)key encryptedString:(NSString *)string;
+ (NSString *)encryptKey:(NSString *)key dict:(NSDictionary *)dict;
+ (NSData *)decyptyKeyWithData:(NSString *)key encryptedString:(NSString *)string;

@end
