//
//  DateUtil.h
//  iNews
//
//  Created by FZDC FZDC on 14-2-14.
//  Copyright (c) 2014年 xiao wen. All rights reserved.
//

#import <Foundation/Foundation.h>

enum {
    DVM_SECOND = 0,
    DVM_MINUTE = 1,
    DVM_HOUR   = 2,
	DVM_DAY    = 3,
	DVM_MONTH  = 4,
	DVM_YEAR   = 5
};

@interface DateUtil : NSObject

+ (BOOL)isDateSameDay:(NSDate*)source dest:(NSDate*)dest;
+ (NSString*)getStringFromDateWithDefaultFormat:(NSDate*)date;
+ (NSDate*)getDateFromStringWithDefaultFormat:(NSString*)date;
+ (NSDate*)getDateFromStringWithFormat:(NSString*)date format:(NSString*)format;
+ (NSString*)getINDateString:(NSString*)date;
+ (NSString*)getDateDisplayString:(NSString*)fromDateTimeStamp toDate:(NSString*)toDateTimeStamp;
+ (NSString*)getDateDisplayStringExtend:(NSString*)fromDateTimeStamp toDate:(NSString*)toDateTimeStamp;
+ (NSString*)getDateDisplayStringByDate:(NSDate*)fromDate toDate:(NSString*)toDateTimeStamp;
+ (NSString*) getDateDisplayStringByDateStr:(NSString*)fromDate toDate:(NSString*)toDateTimeStamp;


//现在是不是跟输入的时间是同一天
+(BOOL)isDifferentDayFromHoldDate:(NSDate *)holdDate;

/**
 * 根据字符串创建日期对象
 *
 * @author zwd
 *
 * @param str
 * 			{@link String} 字符串
 * @return
 */
+ (NSDate *)buildDate:(NSString *) str;

/**
 * 日期格式化（yyyy-MM-dd）
 *
 * @author zwd
 *
 * @param date
 * 			{@link Date} 日期对象
 * @return
 */
+ (NSString *)DateFormat:(NSDate *) date;

/**
 * 日期格式化（yyyy-MM-dd HH:mm:ss）
 *
 * @author zwd
 *
 * @param date
 * 			{@link Date} 日期对象
 * @return
 */
+ (NSString *)DateTimeFormat:(NSDate *)date;

/**
 * 日期格式化
 *
 * @author zwd
 *
 * @param str
 * 			{@link String} 日期格式
 * @param date
 * 			{@link Date} 日期对象
 * @return
 */
+ (NSString *)format:(NSString *)str date:(NSDate *)date;

/**
 * 计算日期间隔
 *
 * @author zwd
 *
 * @param beginTime
 * 			{@link Date} 开始日期
 * @param endTime
 * 			{@link Date} 结束日期
 * @return
 */
+ (int)dateDiff:(NSDate *)beginTime endTime:(NSDate *)endTime;

/**
 * 计算时间间隔
 *
 * @author zwd
 *
 * @param mode
 * 			{@link Integer} 间隔模式
 * @param beginTime
 * 			{@link Date} 开始日期
 * @param endTime
 * 			{@link Date} 结束日期
 * @return
 */
+ (double)timeDiff:(int)mode beginTime:(NSDate *)beginTime endTime:(NSDate *)endTime;

/**
 * 截取日期部分
 *
 * @author zwd
 *
 * @param date
 * 			{@link Date} 日期
 * @return
 */
+ (NSDate *)getDate:(NSDate *) date;

/**
 * 日期拼接
 *
 * @author zwd
 *
 * @param date
 * 			{@link Date} 新date日期部分
 * @param time
 * 			{@link Date} 新date时间部分
 * @return
 */
+ (NSDate *)dateSpell:(NSDate *) date time:(NSDate *)time;

/**
 * 计算某天是当周中的第几天
 *
 * @author zwd
 *
 * @param date
 * 			{@link Date} 日期
 * @return
 */
+ (int)dayOfWeek:(NSDate *)date;

/**
 * 计算某天是一年中的第几天
 *
 * @author zwd
 *
 * @param date
 * 			{@link Date} 日期
 * @return
 */
+ (int)dayOfYear:(NSDate *)date;

/**
 * 计算某月份有多少天
 *
 * @author zwd
 *
 * @param year
 * 			{@link Integer} 年
 * @param month
 * 			{@link Integer} 月
 * @return
 */

+ (int)getDaysOfMonth:(int) year month:(int) month;

/**
 * 加减时间
 *
 * @author zwd
 *
 * @return
 */
+ (NSDate *)Add:(NSDate *)date calendarField:(int) calendarField value:(int) value;

/**
 * 取得周几描述
 *
 * @author zwd
 *
 * @return
 */
+ (NSString *)getWeekDayDescp:(int) Day;

@end
