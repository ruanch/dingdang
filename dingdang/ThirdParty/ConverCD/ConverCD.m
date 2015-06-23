//
//  ConverCD.m
//  BeautySalon
//
//  Created by wuqiang on 13-3-20.
//  Copyright (c) 2013年 ecc. All rights reserved.
//
/* ----------------------------------------------
 日期：2013年3月20日
 功能描述：主要用于字符串长度与高度的计算
 ----------------------------------------------*/

#import "ConverCD.h"
#import <CommonCrypto/CommonDigest.h>
#import <QuartzCore/QuartzCore.h>

@implementation ConverCD

//取偶
+(int) getWHint:(int)value
{
	if(value % 2 != 0 )
	{
		value = value +1;
	}
	return value;
}
//计算字符串一行的长度，当字符串不换行的情况下
+(float) getContentMaxWidth:(NSString *)content FontSize:(int)fontsize 
{
    NSArray *arr = [content componentsSeparatedByString:@"\n"];
    int maxWidth = 0;
    for(int i = 0; i < [arr count] ; i++)
    {
        NSString *str = [arr objectAtIndex:i];
        CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:fontsize]];
        if(size.width > maxWidth)
        {
            maxWidth = size.width;
        }
    }
    return [ConverCD getWHint:maxWidth];
}
//计算字符串在给定宽度下的高度
+(float) getContentHeight:(NSString *)content Width:(float)width FontSize:(int)fontsize
{
	int height = 0;
	NSArray *arr = [content componentsSeparatedByString:@"\n"];
	for(int i = 0; i < [arr count]; i++)
	{
		NSString *str = [arr objectAtIndex:i];
		if (str == nil || [str length] == 0)
		{
			if ([arr count] > 1) //当“\n”前面为空的时候
			{
				height += fontsize +2; 
			}
		}
		else
		{
			CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:fontsize] constrainedToSize:CGSizeMake(width, 1000) lineBreakMode:UILineBreakModeTailTruncation];
			height += size.height;
		}
	}
	return [ConverCD getWHint:height];
}

+ (UIImage *)resizeImageWithCapInsets:(UIEdgeInsets)capInsets with:(UIImage*)gImage {
    CGFloat systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    UIImage *image = nil;
    if (systemVersion >= 5.0) {
        image = [gImage resizableImageWithCapInsets:capInsets];
        return image;
    }
    image = [gImage stretchableImageWithLeftCapWidth:capInsets.left topCapHeight:capInsets.top];
    return image;
}

+ (BOOL)checkIsTel:(NSString *)str
{
    if ([str length] == 0)
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入手机号码" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return NO;
    }    
//    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
//    NSString *regex = @"^[1][358][0-9]{9}$";
    NSString *regex = @"^[1][0-9]{10}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    if (!isMatch)
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return NO;
    }
    return YES;
}

//md5加密方法
+ (NSString *)md5HexDigest:(NSString*)password
{
    password=[password stringByAppendingString:@"ljsheng"];
    const char *original_str = [password UTF8String];
    
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
    {
        [hash appendFormat:@"%02X", result[i]];
    }
    
    NSString *mdfiveString = [hash lowercaseString];
    NSLog(@"Encryption Result %@",mdfiveString);
    return mdfiveString;
}

+(NSUInteger) unicodeLengthOfString: (NSString *) text
{
    NSUInteger asciiLength = 0;
    for (NSUInteger i = 0; i < text.length; i++)
    {
        unichar uc = [text characterAtIndex: i];
        asciiLength += isascii(uc) ? 1 : 2;
    }
    NSUInteger unicodeLength = asciiLength / 2;
    if(asciiLength % 2)
    {
        unicodeLength++;
    }
    return unicodeLength;
}
//判断昵称是否合法
+(BOOL)checkNickNamEqualified:(NSString *)str
{
    NSArray *keywordArray = [NSArray arrayWithObjects:@"微乐",@"一定火",@"一定火客服",@"微乐客服",@"微乐一定火",@"一定火微乐", nil];
    for (NSString *keyword in keywordArray)
    {
        if ([str isEqualToString:keyword])
        {
            return NO;
        }
    }
    return YES;
}
//检查版本号
+(BOOL)isVersion:(NSString*)versionA biggerThanVersion:(NSString*)versionB
{
    NSArray *arrayNow = [versionB componentsSeparatedByString:@"."];
    NSArray *arrayNew = [versionA componentsSeparatedByString:@"."];
    BOOL isBigger = NO;
    NSInteger i = arrayNew.count > arrayNow.count? arrayNow.count : arrayNew.count;
    NSInteger j = 0;
    BOOL hasResult = NO;
    for (j = 0; j < i; j ++) {
        NSString* strNew = [arrayNew objectAtIndex:j];
        NSString* strNow = [arrayNow objectAtIndex:j];
        if ([strNew integerValue] > [strNow integerValue]) {
            hasResult = YES;
            isBigger = YES;
            break;
        }
        if ([strNew integerValue] < [strNow integerValue]) {
            hasResult = YES;
            isBigger = NO;
            break;
        }
    }
    if (!hasResult) {
        if (arrayNew.count > arrayNow.count) {
            NSInteger nTmp = 0;
            NSInteger k = 0;
            for (k = arrayNow.count; k < arrayNew.count; k++) {
                nTmp += [[arrayNew objectAtIndex:k]integerValue];
            }
            if (nTmp > 0) {
                isBigger = YES;
            }
        }
    }
    return isBigger;
}

//生成默认图片
+(UIImage*)creactLoadingImage:(CGSize)imagesize FillColor:(UIColor*)fillcolor
{
    UIView *mainview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, imagesize.width, imagesize.height)];
    mainview.backgroundColor = fillcolor;
    UIImage *centerImage = [UIImage imageNamed:@"news_logo_application_2"];
    UIImageView *centerview = [[UIImageView alloc]initWithImage:centerImage];
    centerview.center = mainview.center;
    [mainview addSubview:centerview];
    [centerview release];
    
    UIGraphicsBeginImageContextWithOptions(imagesize, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [mainview.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [mainview release];
    return image;
}
//生成小张的默认图片
+(UIImage*)creactSmallLoadingImage:(CGSize)imagesize FillColor:(UIColor*)fillcolor
{
    UIView *mainview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, imagesize.width, imagesize.height)];
    mainview.backgroundColor = fillcolor;
    UIImage *centerImage = [UIImage imageNamed:@"news_logo_application_2"];
    CGSize logosize = centerImage.size;
    float logoh = (logosize.height*imagesize.width)/(logosize.width*2);
    UIImageView *centerview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, imagesize.width/2, logoh)];
    centerview.image = centerImage;
    centerview.center = mainview.center;
    [mainview addSubview:centerview];
    [centerview release];
    
    UIGraphicsBeginImageContextWithOptions(imagesize, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [mainview.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [mainview release];
    return image;
}

+(NSString *)hidePartOfPhoneNumber:(NSString *)phonenum
{
    NSString *frontPart = [phonenum substringToIndex:3];
    NSString *backPart = [phonenum substringFromIndex:7];
    NSString *hiddenPhoneNum = [NSString stringWithFormat:@"%@****%@",frontPart,backPart];
    return hiddenPhoneNum;
}

+(NSString *)changeNormalToBankCardFormat:(NSString *)normalstr
{
    NSString *formatStr = @"";
    int arrayNun = normalstr.length/4;
    int remainder = normalstr.length%4;
    if (remainder != 0)
    {
        arrayNun++;
    }
    
    for (int i=0; i<arrayNun; i++)
    {
        NSString *subStr = @"";
        if (i == arrayNun - 1)
        {
            subStr =[normalstr substringFromIndex:4*i];
        }
        else
        {
            subStr = [normalstr substringWithRange:NSMakeRange(4*i, 4)];
        }
        
        if (formatStr.length == 0)
        {
            formatStr = subStr;
        }
        else
        {
            formatStr = [NSString stringWithFormat:@"%@ %@",formatStr,subStr];
        }
    }
    return formatStr;
}
+(NSString *)changeBankCardFormatToNormal:(NSString *)formatstr
{
    NSString *normalStr = [formatstr stringByReplacingOccurrencesOfString:@" " withString:@""];
    return normalStr;
}


@end
