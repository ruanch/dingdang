//
//  StringUtil.m
//  iNews
//
//  Created by xiao wen on 13-12-24.
//  Copyright (c) 2013年 xiao wen. All rights reserved.
//

#import "StringUtil.h"

@implementation StringUtil

+ (NSString*) unicodeString:(NSString*) unicodeStr
{
    // todo: shit code, should be replaced by reg-exp
    if (!unicodeStr) return @"";
    NSString *tempStr0 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr1 = [tempStr0 stringByReplacingOccurrencesOfString:@"%u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* tempStr4 = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    NSString* tempStr5 = [tempStr4 stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
    NSString* returnStr = [tempStr5 stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
//    NSString *returnStr = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
//                                                            (CFStringRef)unicodeStr,
//                                                            CFSTR(""),
//                                                            kCFStringEncodingUTF8));
//    DLog(@"Output = %@", returnStr);

    return returnStr;
}

+ (NSString*) trimString:(NSString*) value
{
    if (!value) return nil;
    return [value stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
}

+ (int)getNSStringLength:(NSString*)value
{
    int strlength = 0;
    char* p = (char*)[value cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i = 0 ; i< [value lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]; i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return strlength;
    
}

+ (BOOL)isEmptyString:(NSString*)value
{
    if (!value) return YES;
    NSString* temp = [self trimString:value];
    if ([temp compare:@""] == NSOrderedSame)
    {
        return YES;
    }
    return  NO;
}

+ (ConfirmStringIncludeResult)checkStringIncludeChar:(NSString*)value
{
    ////数字条件
    NSRegularExpression *tNumRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    //符合数字条件的有几个字符
    int tNumMatchCount = [tNumRegularExpression numberOfMatchesInString:value
                                                                options:NSMatchingReportProgress
                                                                  range:NSMakeRange(0, value.length)];
    
    //英文字条件
    NSRegularExpression *tLetterRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    //符合英文字条件的有几个字符
    int tLetterMatchCount = [tLetterRegularExpression numberOfMatchesInString:value options:NSMatchingReportProgress range:NSMakeRange(0, value.length)];
    
    if (tNumMatchCount == value.length)
    {
        //全部符合数字，表示沒有英文
        return ConfirmStringIncludeResult_HaveNoChar;
    }
    else if (tLetterMatchCount == value.length)
    {
        //全不符合英文，表示沒有数字
        return ConfirmStringIncludeResult_HaveNoNum;
    }
    else if (tNumMatchCount + tLetterMatchCount == value.length)
    {
        //符合英文和符合数字条件的相加等于密码长度
        return ConfirmStringIncludeResult_NumAndChar;
    }
    else
    {
        //可能包含标点符号的情況，或是包含非英文的文字
        return ConfirmStringIncludeResult_NumAndCharAndSymbol;
    }

}

+ (UIColor *) colorWithHexString: (NSString *) stringToConvert
{
    UIColor *defaultColor = [UIColor whiteColor];
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return defaultColor;
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return defaultColor;
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

+ (CGSize)getTextSize:(UIView *)uv value:(NSString*)value font:(UIFont*)font
{
    return [self getTextSize:uv value:value font:font maxWidth:uv.frame.size.width];
}

+ (CGSize)getTextSize:(UIView *)uv value:(NSString*)value font:(UIFont*)font maxWidth:(CGFloat) maxWidth
{
    CGSize size = CGSizeMake(maxWidth, MAXFLOAT);
    CGSize txtsize = [value sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByTruncatingTail];
    txtsize.height = ceilf(txtsize.height);
    return  txtsize;
}

+ (NSMutableAttributedString*)getNumberStrWithRedColor:(int)number head:(NSString*)head tail:(NSString*)tail
{
    NSString *numStr = [NSString stringWithFormat:@"%d", number];
    NSString *headStr = @"";
    NSString *endStr = @"";
    if (head)
        headStr = head;
    if (tail)
        endStr = tail;
        
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@%@", headStr, numStr, endStr]];
    [attribute addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:191.0/255 green:28.0/255 blue:19.0/255 alpha:1.0] range:NSMakeRange(headStr.length, numStr.length)];
    return attribute;
}

+(NSMutableAttributedString *)getStringWithSpaceFirstLineHeadIndent:(NSInteger)number string:(NSString *)string{

    NSString * tempString = [NSString stringWithFormat:@"%@", [StringUtil unicodeString:string]];
    NSMutableAttributedString * desString = [[NSMutableAttributedString alloc]initWithString:tempString];
    NSRange spaceRange;
    spaceRange.location = 0;
    spaceRange.length = tempString.length;

    NSMutableParagraphStyle * style = [[NSMutableParagraphStyle alloc]init];
    [style setFirstLineHeadIndent:number];
    //    style.lineBreakMode = NSLineBreakByTruncatingTail;
    [desString addAttribute:NSParagraphStyleAttributeName value:style range:spaceRange];
    return desString;
}

+ (BOOL)hasLeadingNumberInString:(NSString*) value
{
    if (value)
        return [value length] && isnumber([value characterAtIndex:0]);
    else
        return NO;
}

+ (NSString *)URLEncodedString:(NSString *)encodeStr
{
    NSString *result = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            (CFStringRef)encodeStr,
                                            NULL,
                                            CFSTR("!*'();:@&amp;=+$,/?%#[] "),
                                            kCFStringEncodingUTF8));
    return result;
}

+ (NSString*)URLDecodedString:(NSString *)decodeStr
{
    NSString *result = (NSString *)
    CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                            (CFStringRef)decodeStr,
                                                            CFSTR(""),
                                                            kCFStringEncodingUTF8));
    return result;
}


+(BOOL)checkPhoneNumInput:(NSString *) phone{
    
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    BOOL res1 = [regextestmobile evaluateWithObject:phone];
    BOOL res2 = [regextestcm evaluateWithObject:phone];
    BOOL res3 = [regextestcu evaluateWithObject:phone];
    BOOL res4 = [regextestct evaluateWithObject:phone];
    
    if (res1 || res2 || res3 || res4 )
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
}
@end
