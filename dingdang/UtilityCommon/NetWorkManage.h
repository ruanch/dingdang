//
//  NetWorkManage.h
//  iNews
//
//  Created by FZDC FZDC on 14-2-12.
//  Copyright (c) 2014年 xiao wen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@protocol NetWorkManagerDelegate;

@interface NetWorkManage: NSObject

///!!!NOTICE:WNEH YOU WANT TO GET THIS,YOU MUST START THE WATCH FIRST
@property (nonatomic, assign, readonly, getter = witchNetWorkerEnabled) NetworkStatus witchNetWorkerEnabled;

///!!!NOTICE:WNEH YOU WANT TO GET THIS,YOU MUST START THE WATCH FIRST
@property (nonatomic, assign, readonly, getter = netWorkIsEnabled) BOOL netWorkIsEnabled;

@property (nonatomic, weak) id<NetWorkManagerDelegate> delegate;

/**
 *
 * 获取网络管理器
 *
 */
+ (NetWorkManage*) sharedInstance;

/**
 *
 * 是否有网络
 *
 */
- (BOOL)isHasNetWork:(NSString*)address;

- (BOOL)isWiFiNetWork:(NSString*)address;

- (BOOL)isWWANiNetWork:(NSString*)address;

/**
 *
 * 检测当前网络状态
 *
 */
- (NetworkStatus) checkNowNetWorkStatus:(NSString*)address;
/**
 *
 * 开始检测网络
 *
 */
- (BOOL) startNetWorkeWatch:(NSString*)address;

/**
 *
 * 停止检测网络
 *
 */
- (void) stopNetWorkWatch;

@end

/**
 *
 * 您的应用程序需要实现此协议，当网络发生变化时候，与用户交互
 *
 */
@protocol NetWorkManagerDelegate

//@required
@optional

- (void) netWorkStatusWillChange:(NetworkStatus)status;

@optional

- (void) netWorkStatusWillEnabled;

- (void) netWorkStatusWillEnabledViaWifi;

- (void) netWorkStatusWillEnabledViaWWAN;

- (void) netWorkStatusWillDisconnection;
@end
