//
//  HomeViewController.h
//  AiDian
//
//  Created by Oliver Zheng on 14-4-10.
//  Copyright (c) 2014年 JiHeNet. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface NSDictionary (Helper)

+ (NSDictionary *)dictionaryWithContentsOfData:(NSData *)data;
- (NSData *)tranformToData;

@end
