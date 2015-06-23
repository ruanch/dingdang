//
//  UFChangeStyleManager.h
//  universityFace
//
//  Created by Chen Jing on 14-9-13.
//  Copyright (c) 2014年 Chen Jing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface UFChangeStyleManager : NSObject
+(UFChangeStyleManager *)shareInstance;
+(UIImage *)imageNamed:(NSString *)imageName;

@end
