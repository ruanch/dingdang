//
//  NSString+DCAdditions.m
//  DCFramework
//
//  Created by Chen Jing on 14-2-19.
//  Copyright (c) 2014年 Chen Jing. All rights reserved.
//

#import "NSString+DCAdditions.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (DCAdditions)
- (NSString *)md5
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (unsigned int) strlen(cStr), result);
    return [NSString stringWithFormat:
			@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
			result[0], result[1], result[2], result[3],
			result[4], result[5], result[6], result[7],
			result[8], result[9], result[10], result[11],
			result[12], result[13], result[14], result[15]
			];
}

+ (NSString*)uniqueString
{
	CFUUIDRef	uuidObj = CFUUIDCreate(nil);
	NSString	*uuidString = (__bridge_transfer NSString*)CFUUIDCreateString(nil, uuidObj);
	CFRelease(uuidObj);
	return uuidString;
}

+(NSString *)getScreenShotFilePath_png_Type{
    NSString * tempString = nil;
    NSArray *paths= NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachedictionary = [paths objectAtIndex:0];
    tempString = [cachedictionary stringByAppendingString:@"/capture"];
    return tempString;
}

-(BOOL)isIncludeString:(NSString *)string{
    NSRange tempRange = [self rangeOfString:string];
    if (tempRange.length > 0) {
        return YES;
    }else{
        return NO;
    }
}

-(NSString *) imageType
{
    //默认为空
    NSString * imageTypeStr = @"";
    //从url中获取图片类型
    NSMutableArray *arr = (NSMutableArray *)[self componentsSeparatedByString:@"."];
    if (arr) {
        imageTypeStr = [arr objectAtIndex:arr.count-1];
    }
    return imageTypeStr;
}
@end
