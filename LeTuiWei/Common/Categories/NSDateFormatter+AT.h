//
//  NSDateFormatter+AT.h
//  AsiaTravel
//
//  Created by wangxinxin on 16/2/1.
//  Copyright © 2016年 asiatravel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (AT)


// Returen a `NSDateFormatter` whose timezone is set to "UTC 0000", this date formatter is used to parse date string
//  with format `YY-mm-dd`,
//  eg. "2016-02-04".
//  `YY-MM-DD` formatted string is widely used in `ATFlight` `ATHotel` service request parameters.
+ (NSDateFormatter *)at_utcDateFormatter;

@end
