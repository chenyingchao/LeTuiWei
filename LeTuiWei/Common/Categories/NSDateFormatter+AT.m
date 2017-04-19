//
//  NSDateFormatter+AT.m
//  AsiaTravel
//
//  Created by wangxinxin on 16/2/1.
//  Copyright © 2016年 asiatravel. All rights reserved.
//

#import "NSDateFormatter+AT.h"

@implementation NSDateFormatter (AT)

+ (NSDateFormatter *)at_utcDateFormatter {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:kDateFormatYYMMDD];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    return formatter;
}

@end
