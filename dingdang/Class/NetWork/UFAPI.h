//
//  UFAPI.h
//  universityFace
//
//  Created by 阮 沧晖 on 14-9-25.
//  Copyright (c) 2014年 阮 沧晖. All rights reserved.
//

#import <Foundation/Foundation.h>

//登陆模块API
typedef enum _UFLoginTag
{
    kUFLogin = 101,
    kUFLoginOut,
    kUFUpdatePassWord,
    kUFSendSms,
    kUFValidateSms,
    kUFNoLoginUpdatePassWord,
    kUFSysTime,
}UFLoginTag;
//首页模块API
typedef enum _UFHomeTag
{
    kUFGetUserInfo=201,
    kUFUpdateMobilePhone,
    kUFGetHomePageNews,
    KUFGetVersion,
    KUFSubmitFeedBack,
    KUFGetHomePageTeacherData,
    KUFGetHomePageStudentData,
    kUFGetNews,
}UFHomeTag;


//课堂
typedef enum _UFClassroomTag{
    kUFGetTeacherScheduleInfo = 301,    //课程信息（老师端）
    kUFGeTeacherScheduleDetailInfo,     //获取某个课程所有学生的（已到，未到，日志）情况（老师端）
    kUFGetStudentScheduleInfo,          //课程历史信息  (学生端)
    kUFSetUserSignMuteStatus,           //学生签到和静音设置（学生端）
}UFClassroomTag;

//校讯
typedef enum _UFSchoolMessageTag{
    kUFGetNotice = 401,
}UFSchoolMessageTag;



@interface UFAPI : NSObject

+(id)shared;

-(NSString *)urlStringWithModuleLoginTag:(UFLoginTag)tag;
-(NSString *)urlStringWithModuleHomeTag:(UFHomeTag)tag;

-(NSString *)urlStringWithModuleClassroomTag:(UFClassroomTag)tag;
-(NSString *)urlStringWithModuleSchoolMessageTag:(UFSchoolMessageTag)tag;
@end
