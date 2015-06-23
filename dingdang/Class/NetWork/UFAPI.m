//
//  UFAPI.m
//  universityFace
//
//  Created by 阮 沧晖 on 14-9-25.
//  Copyright (c) 2014年 阮 沧晖. All rights reserved.
//

#import "UFAPI.h"
//服务器IP
//NSString *const hostIp = @"http://192.168.2.112:81";
NSString *const hostIp = @"http://192.168.1.43:6060";

NSString *const hostNormapIp = @"http://192.168.2.112:86";
//NSString *const hostNormapIp = @"http://192.168.1.43:6080";

#pragma mark -认证
//用户登录
NSString *const apiLogin = @"/User/Login";
//用户登出
NSString *const apiLoginOut = @"/User/Logout";
//修改用户密码
NSString *const apiUpdatePassWord = @"/User/UpdatePassword";
//找回密码
NSString *const apiSendSmsCode = @"/User/SendPwdSms";
//验证短信
NSString *const apiValidateSms = @"/User/ValidatePwdSms";
//无登录修修改密码
NSString *const apiNoLoginUpdatePassWord = @"/User/NoLoginUpdatePassword";
//返回系统时间
NSString *const apiSysTime = @"/User/GetSystemTime";

#pragma mark -首页
//修改用户手机
NSString *const apiUpdateMobilePhone = @"/User/ModifyUserPhone";
//获取用户资料
NSString *const apiGetUserInfo = @"/User/GetUserInfo";
//版本更新
NSString *const apiGetVersion = @"/User/GetVersion";
//意见反馈
NSString *const apiSubmitFeedBack = @"/User/SubmitFeedBack";
//获取首页新闻
NSString *const apiGetHomePageNews = @"/News/GetHomePageNews";
//获取学生信息
NSString *const apiGetHomePageStudentData = @"/Index/GetHomePageStudentData";
//获取教师信息
NSString *const apiGetHomePageTeacherData = @"/Index/GetHomePageTeacherData";
//获取新闻列表
NSString *const apiGetNews = @"/News/GetNews";




#pragma mark - 课堂
//课程信息（老师端）
NSString * const apiGetTeacherScheduleInfo = @"/Scheduleinfo/GetTeacherScheduleInfo";

//获取某个课程所有学生的（已到，未到，日志）情况（老师端）
NSString * const apiGeTeacherScheduleDetailInfo = @"/Attendance/GeTeacherScheduleDetailInfo";

//课程历史信息  (学生端)
NSString * const apiGetStudentScheduleInfo = @"/Scheduleinfo/GetStudentScheduleInfo";

//学生签到和静音设置（学生端）
NSString * const apiSetUserSignMuteStatus = @"/Attendance/SetUserSignMuteStatus";


#pragma mark - 校讯
NSString * const apiGetNotice = @"/News/GetNotice";


@implementation UFAPI

+ (UFAPI *)shared
{
    static UFAPI *_api = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _api = [[self alloc] init];
    });
    return _api;
}


-(NSString *)urlStringWithModuleLoginTag:(UFLoginTag)tag
{
    NSString *tempStr = nil;
    switch (tag) {
        case kUFLogin:
            tempStr = apiLogin;
            break;
        case kUFLoginOut:
            tempStr = apiLoginOut;
            break;
        case kUFUpdatePassWord:
            tempStr = apiUpdatePassWord;
            break;
        case kUFSendSms:
            tempStr = apiSendSmsCode;
            break;
        case kUFValidateSms:
            tempStr = apiValidateSms;
            break;
        case kUFNoLoginUpdatePassWord:
            tempStr = apiNoLoginUpdatePassWord;
            break;
        case kUFSysTime:
            tempStr = apiSysTime;
            break;
        default:
            break;
    }
    tempStr = [NSString stringWithFormat:@"%@%@",hostIp,tempStr];
    return tempStr;
    
}
-(NSString *)urlStringWithModuleHomeTag:(UFHomeTag)tag
{
    NSString *tempStr = nil;
    switch (tag) {
        case kUFGetUserInfo:
            tempStr = apiGetUserInfo;
            break;
        case kUFUpdateMobilePhone:
            tempStr = apiUpdateMobilePhone;
            break;
        case kUFGetHomePageNews:
            tempStr = apiGetHomePageNews;
            break;
        case KUFGetVersion:
            tempStr = apiGetVersion;
            break;
        case KUFSubmitFeedBack:
            tempStr = apiSubmitFeedBack;
            break;
        case KUFGetHomePageStudentData:
            tempStr = apiGetHomePageStudentData;
            break;
        case KUFGetHomePageTeacherData:
            tempStr = apiGetHomePageTeacherData;
            break;
        case kUFGetNews:
            tempStr = apiGetNews;
            break;
        default:
            break;
    }
    tempStr = [NSString stringWithFormat:@"%@%@",hostNormapIp,tempStr];
    return tempStr;

}

-(NSString *)urlStringWithModuleClassroomTag:(UFClassroomTag)tag{
    NSString *tempStr = nil;
    switch (tag) {
        case kUFGetTeacherScheduleInfo:
            tempStr = apiGetUserInfo;
            break;
        case kUFGeTeacherScheduleDetailInfo:
            tempStr = apiGeTeacherScheduleDetailInfo;
            break;
        case kUFGetStudentScheduleInfo:
            tempStr = apiGetStudentScheduleInfo;
            break;
        case kUFSetUserSignMuteStatus:
            tempStr = apiSetUserSignMuteStatus;
            break;
        default:
            break;
    }
    tempStr = [NSString stringWithFormat:@"%@%@",hostNormapIp,tempStr];
    return tempStr;
}

-(NSString *)urlStringWithModuleSchoolMessageTag:(UFSchoolMessageTag)tag{
    NSString *tempStr = nil;
    switch (tag) {
        case kUFGetNotice:
            tempStr = apiGetNotice;
            break;

        default:
            break;
    }
    tempStr = [NSString stringWithFormat:@"%@%@",hostNormapIp,tempStr];
    return tempStr;
}

@end
