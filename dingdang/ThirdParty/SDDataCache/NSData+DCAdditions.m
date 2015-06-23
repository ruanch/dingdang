//
//  NSData+DCAdditions.m
//  DCFramework
//
//  Created by Chen Jing on 14-2-21.
//  Copyright (c) 2014年 Chen Jing. All rights reserved.
//

#import "NSData+DCAdditions.h"

@implementation NSData (DCAdditions)
-(BOOL)writeImageDataToFileWithDefaultPath{
    NSArray *paths= NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachedictionary = [paths objectAtIndex:0];
    return [self writeToFile:[NSString stringWithFormat:@"%@/capture.png",cachedictionary] atomically:YES];
}
@end
