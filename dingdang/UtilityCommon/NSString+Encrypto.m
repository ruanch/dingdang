//
//  NSString+Encrypto.m
//  universityFace
//
//  Created by Chen Jing on 14-9-20.
//  Copyright (c) 2014年 Chen Jing. All rights reserved.
//

#import "NSString+Encrypto.h"

@implementation NSString (Encrypto)
- (NSString *) sha1
{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];

    uint8_t digest[CC_SHA1_DIGEST_LENGTH];

    CC_SHA1(data.bytes, data.length, digest);

    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];

    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }

    return output;
}
@end
