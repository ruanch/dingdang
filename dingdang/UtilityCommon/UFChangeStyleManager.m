//
//  UFChangeStyleManager.m
//  universityFace
//
//  Created by Chen Jing on 14-9-13.
//  Copyright (c) 2014年 Chen Jing. All rights reserved.
//

#import "UFChangeStyleManager.h"

#define kCurrentStyle @"currentStyle"
#define kDefaultStyle @"defalutStyle"
@interface UFChangeStyleManager ()
@property(nonatomic,strong)NSString * currentStyle;
@end

@implementation UFChangeStyleManager
+(UFChangeStyleManager *)shareInstance{
    static dispatch_once_t onceToken;
    static UFChangeStyleManager * manager;
    dispatch_once(&onceToken, ^{
        manager = [[UFChangeStyleManager alloc]init];
        manager.currentStyle = [[NSUserDefaults standardUserDefaults]objectForKey:kCurrentStyle];
    });
    return manager;
}

+(UIImage *)imageNamed:(NSString *)imageName{
    return [[UFChangeStyleManager shareInstance]imageNamed:imageName];
}

-(UIImage *)imageNamed:(NSString *)imageName{
    UIImage * tempImage = nil;
    if ([self.currentStyle isEqualToString:kDefaultStyle]) {
        tempImage = [UIImage imageNamed:imageName];
    }else{
        NSString * tempImageName = [NSString stringWithFormat:@""];
        tempImage = [UIImage imageNamed:@""];
    }
    return tempImage;
}


-(void)changeToStyle:(NSString *)style{
    self.currentStyle = style;
    [[NSUserDefaults standardUserDefaults]setObject:style forKey:kCurrentStyle];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

@end
