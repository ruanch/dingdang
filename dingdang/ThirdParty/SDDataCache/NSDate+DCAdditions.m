//
//  NSDate+DCAdditions.m
//  iNews
//
//  Created by Chen Jing on 14-2-26.
//  Copyright (c) 2014年 xiao wen. All rights reserved.
//

#import "NSDate+DCAdditions.h"

@implementation NSDate (DCAdditions)



+ (NSString *)weekdayAfterToday:(NSInteger)afterToday{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	NSString *weekdayStr = nil;
	[formatter setDateFormat:@"c"];
	NSInteger weekday = [[formatter stringFromDate:[NSDate date]] integerValue];
    weekday = (weekday - 1 + afterToday) % 7 + 1;
	if( weekday==1 ){
		weekdayStr = @"星期日";
	}else if( weekday==2 ){
		weekdayStr = @"星期一";
	}else if( weekday==3 ){
		weekdayStr = @"星期二";
	}else if( weekday==4 ){
		weekdayStr = @"星期三";
	}else if( weekday==5 ){
		weekdayStr = @"星期四";
	}else if( weekday==6 ){
		weekdayStr = @"星期五";
	}else if( weekday==7 ){
		weekdayStr = @"星期六";
	}else{
        weekdayStr = [NSString stringWithFormat:@"%@",@"傻逼了"];
    }
	return weekdayStr;
}

@end
