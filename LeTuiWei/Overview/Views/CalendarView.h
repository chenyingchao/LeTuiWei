//
//  CalendarView.h
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/17.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CalendarView;
@protocol CalendarViewDelegate<NSObject>

@required

- (void)calendarView:(CalendarView *)calendarView comfirmDidSelectedCheckInDate:(NSString *)checkInDate checkOutDate:(NSString *)checkOutDate;

@optional



@end

@interface CalendarView : UIView

@property (strong, nonatomic)NSDate *checkInDate;

@property (strong, nonatomic)NSDate *checkOutDate;

- (void)showCalendarView;

- (void)dismissCalendarView;

@property (nonatomic, weak) id<CalendarViewDelegate> calendarViewDelegate;

@property (nonatomic, assign) CGPoint calendarOrigin;

@end
