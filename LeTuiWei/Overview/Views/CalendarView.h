//
//  CalendarView.h
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/17.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarView : UIView

@property (strong, nonatomic)NSDate *checkInDate;

@property (strong, nonatomic)NSDate *checkOutDate;

- (void)showCalendarView;

- (void)dismissCalendarView;


@property (nonatomic, copy) void (^confirmDateButton)(NSString *checkIndate, NSString *checkOutDate);

@property (nonatomic, assign) CGPoint calendarOrigin;

@end
