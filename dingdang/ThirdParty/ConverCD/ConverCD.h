//
//  ConverCD.h
//  BeautySalon
//
//  Created by WuQiang on 13-3-20.  
//  Copyright (c) 2013年 ecc. All rights reserved.
/* ----------------------------------------------
    日期：2013年3月20日
    功能描述：主要用于字符串长度与高度的计算
   ----------------------------------------------*/

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ConverCD : NSObject

+(int) getWHint:(int)value;

+(float) getContentMaxWidth:(NSString *)content FontSize:(int)fontsize;
+(float) getContentHeight:(NSString *)content Width:(float)width FontSize:(int)fontsize;

+ (UIImage *)resizeImageWithCapInsets:(UIEdgeInsets)capInsets with:(UIImage*)gImage;    //将图片转化为可以拉伸

+ (BOOL)checkIsTel:(NSString *)str;     //判断是否为电话号码

+ (NSString *)md5HexDigest:(NSString*)password;      //md5加密

+(NSUInteger) unicodeLengthOfString: (NSString *) text;

+(BOOL)checkNickNamEqualified:(NSString *)str;

+(BOOL)isVersion:(NSString*)versionA biggerThanVersion:(NSString*)versionB;

+(UIImage*)creactLoadingImage:(CGSize)imagesize FillColor:(UIColor*)fillcolor;  //生成默认图片
+(UIImage*)creactSmallLoadingImage:(CGSize)imagesize FillColor:(UIColor*)fillcolor; //生成小张的默认图片
+(NSString *)hidePartOfPhoneNumber:(NSString *)phonenum;    //加密部分电话号码

+(NSString *)changeNormalToBankCardFormat:(NSString *)normalstr;    //银行卡号格式化
+(NSString *)changeBankCardFormatToNormal:(NSString *)formatstr;    //银行卡号正常化
@end
