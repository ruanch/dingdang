//
//  UFUserInfo.h
//  universityFace
//
//  Created by 阮 沧晖 on 14-9-23.
//  Copyright (c) 2014年 阮 沧晖. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UFUserInfo : NSObject

@property (nonatomic,strong) NSString *userName;//学号
@property (nonatomic,assign) int sex;//性别 0男 1女
@property (nonatomic,strong) NSString *name;//姓名
@property (nonatomic,strong) NSString *age;//年龄
@property (nonatomic,strong) NSString *phone;//电话
@property (nonatomic,assign) int userType;//用户类型 1学生 2老师
@property (nonatomic,assign) int classid;//班级ID
@property (nonatomic,strong) NSString *className;//班级名称
@property (nonatomic,strong) NSString *schoolname;//学生名称
@property (nonatomic,strong) NSString *photo;//照片URL
@property (nonatomic,strong) NSString *position;//学生职务，老师职称
@end
