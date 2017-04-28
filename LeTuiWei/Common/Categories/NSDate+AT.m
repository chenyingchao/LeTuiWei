//
//  NSDate+AT.m
//  AsiaTravel
//
//  Created by wangxinxin on 15/12/15.
//  Copyright © 2015年 asiatravel. All rights reserved.
//

#import "NSDate+AT.h"
#import "NSDateFormatter+AT.h"

NSString * const kDateFormatYYMMDD = @"yyyy-MM-dd";
NSString * const kDateFormatYYMMDDTHHmm = @"yyyy-MM-dd HH:mm";
NSString * const kDateFormatYYMMDDTHHmmssWithoutT = @"yyyy-MM-dd HH:mm:ss";
NSString * const kDateFormatYYMMDDTHHmmss = @"yyyy-MM-dd'T'HH:mm:ss";

@implementation NSDate (AT)

static NSDateFormatter *currentFormatter = nil;

+ (NSDateFormatter *)shareDateFormatter {
    static dispatch_once_t sharedDateFormatter_onceToken;
    dispatch_once(&sharedDateFormatter_onceToken, ^{
        if (!currentFormatter) {
            currentFormatter = [NSDateFormatter at_utcDateFormatter];
        }
    });
    return currentFormatter;
}

+ (NSDate *)at_dateFromString:(NSString *)dateString {
    NSDateFormatter *dateFormatter = [self shareDateFormatter];
    if (dateString.length > kDateFormatYYMMDD.length) {
        [dateFormatter setDateFormat:kDateFormatYYMMDDTHHmmss];
    } else {
        [dateFormatter setDateFormat:kDateFormatYYMMDD];
    }
    NSDate *date = [dateFormatter dateFromString:dateString];
    if (!date) {
        date = [NSDate date];
    }
    return date;
}

+ (NSDate *)at_currentDateInGMT {
    NSDate* currentDate = [NSDate date];
    
    NSTimeZone* currentTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    NSTimeZone* systemTimeZone = [NSTimeZone systemTimeZone];
    
    NSInteger currentGMTOffset = [currentTimeZone secondsFromGMTForDate:currentDate];
    NSInteger systemGMTOffset = [systemTimeZone secondsFromGMTForDate:currentDate];
    NSTimeInterval interval = systemGMTOffset - currentGMTOffset;
    NSDate* currentDateGMT = [[NSDate alloc] initWithTimeInterval:interval sinceDate:currentDate];
    return currentDateGMT;
}

- (NSString *)stringForFormat:(NSString *)format {
    if (!format) {
        return nil;
    }
    
    NSDateFormatter *formatter = [NSDate shareDateFormatter];
    [formatter setDateFormat:format];
    
    NSString *timeStr = [formatter stringFromDate:self];
    return timeStr;
}

- (NSString *) stringForYearMonthDayDashed {
    return [self stringForFormat:kDateFormatYYMMDD];
}

- (NSString *)stringForMonthDayCN {
    return [self stringForFormat:[NSString stringWithFormat:@"MM%@dd%@", @"月",@"日"]];
}

- (NSString *)stringForMonthDay {
    return [self stringForFormat:@"MM-dd"];
}


- (NSString *)stringForYearMontDayCN {
    return [self stringForFormat:@"yyyy年MM月dd日"];
}

- (NSString *)stringForMonthDayWeekDay {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setPositiveFormat:@"00"];
    NSString *monthDay = [NSString stringWithFormat:@"%@%@%@%@",
                          [formatter stringFromNumber:[NSNumber numberWithInteger:[self getMonth]]],
                         @"月",
                          [formatter stringFromNumber:[NSNumber numberWithInteger:[self getDay]]],
                          @"日"
                          ];
    NSString *result = [NSString stringWithFormat:@"%@ %@", monthDay, self.weekday];
    return result;

}

- (NSDate *)dateByAddingDays:(NSInteger)days {
    NSCalendar *calendar = [NSCalendar sharedCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:days];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSInteger)weekdayNumber {
    NSCalendar *calendar = [NSCalendar sharedCalendar];
    [calendar setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSDateComponents *component = [calendar components:NSCalendarUnitWeekday fromDate:self];
    if (component.weekday >= 1) {
        return component.weekday - 1;
    }
    return 0;
}

- (NSString *)weekday {
    NSCalendar *calendar = [NSCalendar sharedCalendar];
    [calendar setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSDateComponents *component = [calendar components:NSCalendarUnitWeekday fromDate:self];
    if (component.weekday >= 1) {
        NSArray *strArray = @[@"日", @"一", @"二", @"三", @"四",@"五", @"六"];
        return [NSString stringWithFormat:@"%@%@", @"周", strArray[component.weekday-1]];
    }
    return nil;
}

- (NSInteger)daysBetween:(NSDate *)aDate {
    NSUInteger unitFlags = NSCalendarUnitDay;
    NSDate *from = [NSDate at_dateFromString:[self stringForYearMonthDayDashed]];
    NSDate *to = [NSDate at_dateFromString:[aDate stringForYearMonthDayDashed]];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:unitFlags fromDate:from toDate:to options:0];
    return labs([components day]) + 1;
}

- (NSInteger)nightsBetween:(NSDate *)aDate {
    return [self daysBetween:aDate] - 1;
}

- (NSUInteger)getYear {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitYear) fromDate:self];
    return [dayComponents year];
}

- (NSUInteger)getMonth {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMonth) fromDate:self];
    return [dayComponents month];
}

- (NSUInteger)getDay {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitDay) fromDate:self];
    return [dayComponents day];
}

- (NSString *)stringForHourMinute{
    return [self stringForFormat:[NSString stringWithFormat:@"HH:mm"]];
}

- (NSString *)stringForFullFormatDashed{
    return [self stringForFormat:[NSString stringWithFormat:@"yyyy-MM-dd HH:mm"]];
}

+ (NSInteger)getDay:(NSInteger)minutes {
    return minutes / 1440;
}

+ (NSInteger)getHour:(NSInteger)minutes {
    return ((long)minutes) % 1440 / 60;
}

+ (NSInteger)getMinutes:(NSInteger)minutes {
    return ((long)minutes) % 1440 % 60;
}

@end

@implementation NSCalendar (AT)

+ (instancetype)sharedCalendar
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [NSCalendar currentCalendar];
    });
    return instance;
}

@end
