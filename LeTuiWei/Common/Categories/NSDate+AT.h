//
//  NSDate+AT.h
//  AsiaTravel
//
//  Created by wangxinxin on 15/12/15.
//  Copyright © 2015年 asiatravel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (AT)

extern NSString *const kDateFormatYYMMDD;
extern NSString *const kDateFormatYYMMDDTHHmmss;
extern NSString *const kDateFormatYYMMDDTHHmmssWithoutT;
extern NSString *const kDateFormatYYMMDDTHHmm;

+ (NSDate *)at_dateFromString:(NSString *)dateString;

+ (NSDateFormatter *)shareDateFormatter;

- (NSString *)stringForFormat:(NSString *)format;

+ (NSDate *)at_currentDateInGMT;

/**
 *  NSString
 *
 *  @return formatted string with format "01月31日 周五", while `Wed` is localized
 */
- (NSString *)stringForMonthDayWeekDay;

// 2016-06-15
- (NSString *)stringForYearMonthDayDashed;

// 2016年06月15日
- (NSString *)stringForYearMontDayCN;

// 06月15日
- (NSString *)stringForMonthDayCN;

// 周五
- (NSString *)weekday;
// 5
- (NSInteger)weekdayNumber;

// 06:35
- (NSString *)stringForHourMinute;

// 2016-06-15 06:15
- (NSString *)stringForFullFormatDashed;

- (NSDate *)dateByAddingDays:(NSInteger)days;

- (NSInteger)daysBetween:(NSDate *)aDate;
- (NSInteger)nightsBetween:(NSDate *)aDate;

- (NSUInteger)getYear;
- (NSUInteger)getMonth;
- (NSUInteger)getDay;

+ (NSInteger)getDay:(NSInteger)minutes;

+ (NSInteger)getHour:(NSInteger)minutes;

+ (NSInteger)getMinutes:(NSInteger)minutes;

@end

@interface NSCalendar (AT)

+ (instancetype)sharedCalendar;

@end
