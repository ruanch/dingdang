//
//  DateUtil.m
//  iNews
//
//  Created by FZDC FZDC on 14-2-14.
//  Copyright (c) 2014年 xiao wen. All rights reserved.
//

#import "DateUtil.h"

@implementation DateUtil

+ (BOOL)isDateSameDay:(NSDate*)source dest:(NSDate*)dest
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSString* first = [formatter stringFromDate:source];
    NSString* second = [formatter stringFromDate:dest];
    return [first compare:second] == NSOrderedSame;
}

+ (NSString*)getStringFromDateWithDefaultFormat:(NSDate*)date
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [formatter stringFromDate:date];
}

+ (NSDate*)getDateFromStringWithDefaultFormat:(NSString*)date
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter dateFromString:date];
}

+ (NSDate*)getDateFromStringWithFormat:(NSString*)date format:(NSString*)format
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter dateFromString:date];
}

+ (NSString*)getINDateString:(NSString*)date
{
    NSDate *dateValue = [self getDateFromStringWithFormat:date format:@"yyyy-MM-dd HH:mm:ss"];
    return [self getStringFromDateWithDefaultFormat:dateValue];
}

+ (NSString*)getDateDisplayString:(NSString*)fromDateTimeStamp toDate:(NSString*)toDateTimeStamp
{
    NSTimeInterval from = fromDateTimeStamp.doubleValue / 1000.0;
    NSTimeInterval to = toDateTimeStamp.doubleValue / 1000.0;
    NSDate *fromD = [NSDate dateWithTimeIntervalSince1970:from];
    NSDate *toD = [NSDate dateWithTimeIntervalSince1970:to];
    if ((to - from) < 60.0)
        return @"刚刚";
    else if ((to - from) < 60.0 * 60)
    {
        int min = floor ((to - from) / 60);
        return [NSString stringWithFormat:@"%d分钟前", min];
    }
    else if ((to - from) < 60.0 * 60 * 12)
    {
        int hour = floor ((to - from) / (60.0 * 60));
        return [NSString stringWithFormat:@"%d小时前", hour];
    }
    else if ((to - from) < 60.0 * 60 * 24)
    {
        if ([self isDateSameDay:fromD dest:toD])
            return @"今天";
        else
            return @"昨天";
    }
    else if ((to - from) < 60.0 * 60 * 24 * 2)
    {
        NSDate * date = [NSDate dateWithTimeInterval:60.0 * 60 * 24 sinceDate:fromD];
        if ([self isDateSameDay:date  dest:toD])
            return @"昨天";
        else
            return [self getStringFromDateWithDefaultFormat:fromD];
    }
    else
    {
        return  [self getStringFromDateWithDefaultFormat:fromD];
    }
}

+ (NSString*)getDateDisplayStringExtend:(NSString*)fromDateTimeStamp toDate:(NSString*)toDateTimeStamp
{
    NSTimeInterval from = fromDateTimeStamp.doubleValue / 1000.0;
    NSTimeInterval to = toDateTimeStamp.doubleValue / 1000.0;
    NSDate *fromD = [NSDate dateWithTimeIntervalSince1970:from];
//    NSDate *toD = [NSDate dateWithTimeIntervalSince1970:to];
    if ((to - from) < 60.0)
        return @"刚刚";
    else if ((to - from) < 60.0 * 60)
    {
        int min = floor ((to - from) / 60);
        return [NSString stringWithFormat:@"%d分钟前", min];
    }
    else if ((to - from) < 60.0 * 60 * 12)
    {
        int hour = floor ((to - from) / (60.0 * 60));
        return [NSString stringWithFormat:@"%d小时前", hour];
    }
    else
    {
        return  [self getStringFromDateWithDefaultFormat:fromD];
    }
}

+ (NSString*)getDateDisplayStringByDate:(NSDate*)fromDate toDate:(NSString*)toDateTimeStamp
{
    NSTimeInterval interval = [fromDate timeIntervalSince1970] * 1000;
    return [self getDateDisplayString:[NSString stringWithFormat:@"%lf", interval] toDate:toDateTimeStamp];
}

+ (NSString*) getDateDisplayStringByDateStr:(NSString*)fromDate toDate:(NSString*)toDateTimeStamp
{
    NSDate *date = [self getDateFromStringWithDefaultFormat:fromDate];
    return [self getDateDisplayStringByDate:date toDate:toDateTimeStamp];
}

+ (NSDate *)buildDate:(NSString *)str{
    if (!str)
        return NULL;
    NSDate *rtDate;
    NSArray  * array= [str componentsSeparatedByString:@":"];
    NSString *datestr;
    if ([array count] ==2)
    {
        datestr = [str stringByAppendingString:@":00"];
    }
    else
    {
        datestr = [NSString stringWithString:str];
    }
    NSString *fmstr = [datestr stringByReplacingOccurrencesOfString :@"/" withString:@"-"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //    [dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
    //    [dateFormatter setDateFormat:@"EEE, d MMM yyyy HH:mm:ss Z"];
    if ([array count] == 1)
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    else
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    rtDate = [dateFormatter dateFromString: fmstr];
    //[dateFormatter release];
    return rtDate;
}

+ (NSString *)DateFormat:(NSDate *)date {
    if (!date)
        return NULL;
    return [self format:@"yyyy-MM-dd" date:date];
}

+ (NSString *)DateTimeFormat:(NSDate *)date {
    if (!date)
        return NULL;
    return [self format:@"yyyy-MM-dd HH:mm:ss" date:date];
}

+ (NSString *)format:(NSString *)str date:(NSDate *)date {
    if ((!date) || (!str))
        return NULL;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:str];
    NSString *result = [dateFormatter stringFromDate:date];
    //[dateFormatter release];
    return result;
    
}

+ (int)dateDiff:(NSDate *)beginTime endTime:(NSDate *)endTime {
    if ((!beginTime) || (!endTime))
        return 0;
    NSDate *startDate = [self getDate:beginTime];
    NSDate *overDate =  [self getDate:endTime];
    return (int)[self timeDiff:DVM_DAY beginTime:startDate endTime:overDate];
}

+ (double)timeDiff:(int)mode beginTime:(NSDate *)beginTime endTime :(NSDate *)endTime {
    double result = 0.0;
    if ((!beginTime) || (!endTime))
        return result;
    NSTimeInterval distance = [endTime timeIntervalSinceDate: beginTime];
    switch (mode) {
        case DVM_DAY:
            result = distance / (24*60*60);
            break;
        case DVM_HOUR:
            result = distance / (60*60);
            break;
        case DVM_MINUTE:
            result = distance / 60;
            break;
        case DVM_SECOND:
            result = distance;
            break;
        default:
            return result;
            break;
    }
    
    //保留两位小数
    result = round(result * 100) / 100;
    return result;
}

+ (NSDate *)getDate:(NSDate *)date {
    if (!date)
        return NULL;
    return [self buildDate:[self DateFormat:date]];
}

+ (NSDate *)dateSpell:(NSDate *)date time:(NSDate *)time {
    if ((!date) || (!time))
        return NULL;
    NSCalendar* clendarDate = [ [ NSCalendar alloc ] initWithCalendarIdentifier:NSGregorianCalendar ];
    NSCalendar* clendarTime = [ [ NSCalendar alloc ] initWithCalendarIdentifier:NSGregorianCalendar ];
    NSDateComponents *comp = [[NSDateComponents alloc]init];
    NSInteger unitFlagsDate = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSInteger unitFlagsTime = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;;
    NSDateComponents *cpsDate = [clendarDate components:unitFlagsDate fromDate:date];
    NSDateComponents *cpsTime = [clendarTime components:unitFlagsTime fromDate:time];
    //    NSLog(  @" From Now to %@, diff: Years: %d  Months: %d, Days; %d, Hours: %d, Mins:%d, sec:%d",
    //    [date description], [cpsDate year], [cpsDate month], [cpsDate day], [cpsTime hour], [cpsTime minute], [cpsTime second] );
    [comp setYear:[cpsDate year]];
    [comp setMonth:[cpsDate month]];
    [comp setDay:[cpsDate day]];
    [comp setHour:[cpsTime hour]];
    [comp setMinute:[cpsTime minute]];
    [comp setSecond:[cpsTime second]];
    NSDate *result = [clendarDate dateFromComponents:comp];
    //[comp release];
    //[clendarDate release];
    //[clendarTime release];
    return result;
}

+ (int)dayOfWeek:(NSDate *)date {
    //    NSCalendar* cal = [NSCalendar currentCalendar];
    //    NSDateComponents* comp = [cal components:NSWeekdayCalendarUnit fromDate:date];
    //    return [comp weekday];
    if (!date)
        return 0;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"e"];
    int result =  [[dateFormatter stringFromDate:date]intValue];
    //[dateFormatter release];
    return result;
}

+ (int)dayOfYear:(NSDate *)date {
    if (!date)
        return 0;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"D"];
    int result = [[dateFormatter stringFromDate:date]intValue];
    //[dateFormatter release];
    return result;
    
}

+ (int)getDaysOfMonth:(int)year month:(int)month {
    if (month < 1 || month > 12)
        return 0;
    int isLeapYear = 0;
    if(year % 400 == 0 || (year % 4==0 && year % 100!=0))
        isLeapYear = 1;
    NSArray *array= [NSArray arrayWithObjects:@"31",@"28",@"31",@"30",@"31",@"30",@"31",@"31",@"30",@"31",@"30",@"31",nil];
    if (month == 2 && isLeapYear)
        return [[array objectAtIndex: month - 1] intValue] + isLeapYear;
    else
        return [[array objectAtIndex: month - 1] intValue];
}

+ (NSDate *)Add:(NSDate *)date calendarField:(int)calendarField value:(int)value {
    if (!date)
        return NULL;
    NSCalendar* cal = [NSCalendar currentCalendar];
    NSDateComponents *comp = [[NSDateComponents alloc]init];
    switch (calendarField) {
        case DVM_YEAR:
            [comp setYear: value];
            break;
        case DVM_MONTH:
            [comp setMonth: value];
            break;
        case DVM_DAY:
            [comp setDay: value];
            break;
        case DVM_HOUR:
            [comp setHour: value];
            break;
        case DVM_MINUTE:
            [comp setMinute: value]; ;
            break;
        case DVM_SECOND:
            [comp setSecond: value];
            break;
    }
    NSDate *result = [cal dateByAddingComponents:comp toDate:date options:0];
    //[comp release];
    return result;
    
}

+ (NSString *)getWeekDayDescp:(int)Day {
    if (Day < 1 || Day > 7)
        return NULL;
    NSArray *array = [NSArray arrayWithObjects:@"日", @"一", @"二", @"三", @"四", @"五", @"六", nil ];
    return  [array objectAtIndex:Day -1];
    
}

+(BOOL)isDifferentDayFromHoldDate:(NSDate *)holdDate{
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate * now = [NSDate date];
    NSString * stringNow = [formatter stringFromDate:now];
    NSString * stringHoldDate = [formatter stringFromDate:holdDate];
    if ([stringHoldDate isEqualToString:stringNow]) {
        return NO;
    }else{
        return YES;
    }
}
@end
