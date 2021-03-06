//
//  NavigitionHeaderView.h
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/13.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,NaviHeaderViewType) {
    
    NaviHeaderViewOverView = 0,
    NaviHeaderViewIncome,
};

typedef NS_ENUM(NSUInteger,NaviHeaderViewButtonType) {

    NaviHeaderViewButtonCalendar = 1000,
    NaviHeaderViewButtonToday,
    NaviHeaderViewButtontYesterday,
    NaviHeaderViewButtontSevenDay
    
};


typedef void(^SelectAtIndexBlock)(NaviHeaderViewButtonType indexType, BOOL isSelected);

@interface NavigitionHeaderView : UIView

@property (nonatomic, copy) SelectAtIndexBlock selectAtIndexBlock;

@property (nonatomic, strong) UIButton *calendarButton;


@property (nonatomic, assign) BOOL isHideLine;

-(instancetype)initWithFrame:(CGRect)frame withTitles:(NSArray *)titles withViewType:(NaviHeaderViewType)type;

@property(nonatomic, copy) NSString *calendarTitle;

- (void)upDateView;

@end
