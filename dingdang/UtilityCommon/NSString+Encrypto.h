//
//  NSString+Encrypto.h
//  universityFace
//
//  Created by Chen Jing on 14-9-20.
//  Copyright (c) 2014年 Chen Jing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>
@interface NSString (Encrypto)
- (NSString *) sha1;
@end
