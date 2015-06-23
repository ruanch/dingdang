//
//  StringUtil.h
//  iNews
//
//  Created by xiao wen on 13-12-24.
//  Copyright (c) 2013年 xiao wen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ConfirmStringIncludeResult){
    ConfirmStringIncludeResult_HaveNoChar = 0,
    ConfirmStringIncludeResult_HaveNoNum,
    ConfirmStringIncludeResult_NumAndChar,
    ConfirmStringIncludeResult_NumAndCharAndSymbol
};

@interface StringUtil : NSObject

+ (NSString*) unicodeString:(NSString*) urlEncodedString;

+ (NSString*) trimString:(NSString*) value;

+ (int)getNSStringLength:(NSString*)value;

+ (BOOL)isEmptyString:(NSString*)value;

+ (ConfirmStringIncludeResult)checkStringIncludeChar:(NSString*)value;

+ (UIColor *) colorWithHexString: (NSString *) stringToConvert;

+ (CGSize)getTextSize:(UIView *)uv value:(NSString*)value font:(UIFont*)font;

+ (CGSize)getTextSize:(UIView *)uv value:(NSString*)value font:(UIFont*)font maxWidth:(CGFloat) maxWidth;

+ (NSMutableAttributedString*)getNumberStrWithRedColor:(int)number head:(NSString*)head tail:(NSString*)tail;

//获取带缩进的AttributeString
+ (NSMutableAttributedString *)getStringWithSpaceFirstLineHeadIndent:(NSInteger)number string:(NSString *)string;

+ (BOOL)hasLeadingNumberInString:(NSString*) value;

+ (NSString *)URLEncodedString:(NSString *)encodeStr;
+ (NSString*)URLDecodedString:(NSString *)decodeStr;

+(BOOL)checkPhoneNumInput:(NSString *) phone;

@end
