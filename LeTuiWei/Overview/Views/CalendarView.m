//
//  CalendarView.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/17.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "CalendarView.h"
#import "FSCalendar.h"
#import "ConfirmButtonView.h"

#define kCalendarViewWidth  kScreenWidth-(kScreenWidth - floorf(kScreenWidth / 7) * 7)
@interface CalendarView()<FSCalendarDataSource,FSCalendarDelegate>

@property (nonatomic, strong) FSCalendar *calendar;


@end

@implementation CalendarView


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.tag = 10000;
        self.backgroundColor = [UIColor whiteColor];
        self.frame = CGRectMake(0, -1000, kScreenWidth, self.frame.size.height);
   
        self.calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 0, kCalendarViewWidth, self.frame.size.height)];
        self.calendar.backgroundColor = [UIColor whiteColor];
        self.calendar.dataSource = self;
        self.calendar.delegate = self;
        self.calendar.pagingEnabled = NO; // important
        self.calendar.allowsMultipleSelection = YES;
        self.calendar.firstWeekday = 1;
        self.calendar.appearance.caseOptions = FSCalendarCaseOptionsWeekdayUsesSingleUpperCase|FSCalendarCaseOptionsHeaderUsesUpperCase;
        [self addSubview:self.calendar];
        
        [self creatFooterView];
        
  
    }
    return self;
}


- (void)showCalendarView {

    self.calendar.minimumDate = [NSDate at_dateFromString:@"1970-01-01"];
    self.calendar.maximumDate = [NSDate at_dateFromString:@"2099-12-31"];

    
    self.calendar.checkInDate = self.checkInDate;
    if (self.calendar.checkInDate) {
        [self.calendar setCurrentPage:self.calendar.checkInDate animated:YES];
    }
    self.calendar.checkOutDate = self.checkOutDate;
    
    WS(weakSelf);
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.frame = CGRectMake(0, weakSelf.origin.y, kScreenWidth, self.frame.size.height);

        
    } completion:^(BOOL finished) {
    }];

}



- (void)dismissCalendarView {
    WS(weakSelf);
    [UIView animateWithDuration:0.3 animations:^{
        
     weakSelf.frame = CGRectMake(0, - 1000, kScreenWidth, self.frame.size.height);
    } completion:^(BOOL finished) {
        
        [weakSelf removeFromSuperview];
    }];
}


- (BOOL)calendar:(FSCalendar *)calendar shouldSelectDate:(NSDate *)date {
    
    NSDate *formatDate = [NSDate at_dateFromString:[date stringForFormat:kDateFormatYYMMDD]];
    if (!calendar.checkOutDate) {
        if (calendar.checkInDate && [calendar.checkInDate fs_daysFrom:formatDate] > 0) {
            return YES;
        }
        if (!calendar.checkInDate) {
            return ([formatDate fs_daysFrom:[NSDate at_dateFromString:[[NSDate date] stringForFormat:kDateFormatYYMMDD]]] >= 0);
        }
        return ([formatDate fs_daysFrom:calendar.checkInDate] > 0);
    }
    
    
    
    return YES;
    
    
}


- (void)calendar:(FSCalendar *)calendar willSelectDate:(NSDate *)date {
    
    if (calendar.checkInDate) {
        if (calendar.checkOutDate) {
            calendar.checkInDate = date;
            calendar.checkOutDate = nil;
            //self.checkOutDate = nil;
        } else {
            if ([date fs_daysFrom:calendar.checkInDate] >= 0) {
                calendar.checkOutDate = date;
            } else {
                calendar.checkInDate = date;
            }
        }
        
    } else {
        calendar.checkInDate = date;
    }
}

- (void)creatFooterView {
    WS(weakSelf);
    UIView *bgHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
    bgHeaderView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
    
    [self.calendar addSubview:bgHeaderView];
    [bgHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weakSelf.calendar);
        make.height.equalTo(@([Theme paddingWithSize:200]));
    }];
    
    ConfirmButtonView *submitView = [ConfirmButtonView confirmButtonViewWithTitle:@"选择完毕" andButtonClickedBlock:^(UIButton *button) {

        if (weakSelf.calendar.checkOutDate == nil) {
            weakSelf.calendar.checkOutDate = weakSelf.calendar.checkInDate;
        }
        
        if ([weakSelf.calendarViewDelegate respondsToSelector:@selector(calendarView:comfirmDidSelectedCheckInDate:checkOutDate:)]) {
            
            [weakSelf.calendarViewDelegate calendarView:weakSelf comfirmDidSelectedCheckInDate:[weakSelf.calendar.checkInDate stringForYearMonthDayDashed] checkOutDate:[weakSelf.calendar.checkOutDate stringForYearMonthDayDashed]];
            
        }
        
        [weakSelf dismissCalendarView];
        
    }];
    [bgHeaderView addSubview:submitView];
    [submitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgHeaderView.mas_left).offset([Theme paddingWithSize40]);
        make.right.equalTo(bgHeaderView.mas_right).offset(-[Theme paddingWithSize40]);
        make.bottom.equalTo(bgHeaderView.mas_bottom).offset(- [Theme paddingWithSize40]);
        make.height.equalTo(@([Theme paddingWithSize:88]));
    }];
    
}


@end
