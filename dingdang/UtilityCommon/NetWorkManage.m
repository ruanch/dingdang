//
//  NetWorkManage.m
//  iNews
//
//  Created by FZDC FZDC on 14-2-12.
//  Copyright (c) 2014年 xiao wen. All rights reserved.
//

#import "NetWorkManage.h"

@interface NetWorkManage ()
{
    Reachability *reach;
}

@end

@implementation NetWorkManage

+ (NetWorkManage *)sharedInstance
{
    static NetWorkManage *sharedManager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[NetWorkManage alloc] init];
    });
    
    return sharedManager;
}

- (BOOL)isHasNetWork:(NSString*)address
{
    NetworkStatus result= [self checkNowNetWorkStatus:address];
    return  result != NotReachable;
}

- (BOOL)isWiFiNetWork:(NSString*)address
{
    NetworkStatus result= [self checkNowNetWorkStatus:address];
    return  result == ReachableViaWiFi;
}

- (BOOL)isWWANiNetWork:(NSString*)address
{
    NetworkStatus result= [self checkNowNetWorkStatus:address];
    return  result == ReachableViaWWAN;
}

- (NetworkStatus)checkNowNetWorkStatus:(NSString*)address
{
    NSString *hostName = @"www.baidu.com";
    if (address && ([address compare:@""] != NSOrderedSame))
        hostName = address;
    Reachability *r = [Reachability reachabilityWithHostName:hostName];
    _witchNetWorkerEnabled = [r currentReachabilityStatus];
    _netWorkIsEnabled = _witchNetWorkerEnabled != NotReachable;
    return _witchNetWorkerEnabled;
}

- (BOOL)startNetWorkeWatch:(NSString*)address
{
    NSString *hostName = @"www.baidu.com";
    if (address && ([address compare:@""] != NSOrderedSame))
        hostName = address;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name: kReachabilityChangedNotification
                                               object: nil];
    reach = [Reachability reachabilityWithHostName:hostName];
    _witchNetWorkerEnabled = [reach currentReachabilityStatus];
    _netWorkIsEnabled = _witchNetWorkerEnabled != NotReachable;
    BOOL finish = [reach startNotifier];
    return finish;
}

- (void)stopNetWorkWatch
{
    [reach stopNotifier];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)reachabilityChanged:(NSNotification *)note
{
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    NetworkStatus status = [curReach currentReachabilityStatus];
    
    //调用代理方法,此方法为必须实现
    if ([(NSObject*)self.delegate respondsToSelector:@selector(netWorkStatusWillChange:)])
        [self.delegate netWorkStatusWillChange:status];
    
    //代理的可选方法
    switch (status)
    {
        case NotReachable:
        {
            //网络不可达
            _netWorkIsEnabled = NO;
            _witchNetWorkerEnabled = NotReachable;
            
            if ([(NSObject*)self.delegate respondsToSelector:@selector(netWorkStatusWillDisconnection)])
            {
                [self.delegate netWorkStatusWillDisconnection];
            }
        }
            break;
        case ReachableViaWiFi:
        {
            //网络可达
            _netWorkIsEnabled = YES;
            _witchNetWorkerEnabled = ReachableViaWiFi;
            
            if ([(NSObject*)self.delegate respondsToSelector:@selector(netWorkStatusWillEnabledViaWifi)])
            {
                [self.delegate netWorkStatusWillEnabledViaWifi];
            }
        }
            break;
        case ReachableViaWWAN:
        {
            //网络可达
            _netWorkIsEnabled = YES;
            _witchNetWorkerEnabled = ReachableViaWWAN;
            
            if ([(NSObject*)self.delegate respondsToSelector:@selector(netWorkStatusWillEnabledViaWWAN)])
            {
                [self.delegate netWorkStatusWillEnabledViaWWAN];
            }
        }
            break;
        default:
            break;
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

