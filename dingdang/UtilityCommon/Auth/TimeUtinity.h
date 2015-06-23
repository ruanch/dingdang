#import <Foundation/Foundation.h>

@interface TimeUtinity : NSObject

+ (NSString *)getCurrentTime;
+ (NSDate *)getCurrentTimeFromString:(NSString *)datetime;
+ (NSString *)getCurrentTimeFromString2:(NSDate *)datetime;
+ (NSString *)getWeakDay:(NSDate *)datetime;
+ (int)minusNowDate:(NSDate *)date;
+ (NSString *)getmessageTime:(NSDate *)date;

@end
