//
//  HomeViewController.h
//  AiDian
//
//  Created by Oliver Zheng on 14-4-10.
//  Copyright (c) 2014年 JiHeNet. All rights reserved.
//

#import "NSDictionary+Helper.h"

@implementation NSDictionary (Helper)

+ (NSDictionary *)dictionaryWithContentsOfData:(NSData *)data
{
    CFPropertyListRef plist =  CFPropertyListCreateFromXMLData(kCFAllocatorDefault, (CFDataRef)data,
                                                               kCFPropertyListImmutable,
                                                               NULL);
    if(plist == nil) return nil;
    if ([(id)plist isKindOfClass:[NSDictionary class]])
    {
        return [(NSDictionary *)plist autorelease];
    }
    else
    {
        CFRelease(plist);
        return nil;
    }
}

- (NSData *)tranformToData
{
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:self forKey:@"Some Key Value"];
    [archiver finishEncoding];
    [archiver release];
    return data;
}

@end
