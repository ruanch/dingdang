//
//  NSString+DCAdditions.h
//  DCFramework
//
//  Created by Chen Jing on 14-2-19.
//  Copyright (c) 2014年 Chen Jing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DCAdditions)
+(NSString *)uniqueString;
+(NSString *)getScreenShotFilePath_png_Type;

-(NSString *)md5;

-(BOOL)isIncludeString:(NSString *)string;
-(NSString *) imageType;
@end
