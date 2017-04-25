//
//  IncomeHeaderView.h
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/21.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IncomeHeaderView;

typedef NS_ENUM(NSUInteger, IncomeHeaderViewTopButton) {
    IncomeHeaderViewTopButtonLeft = 500,
    IncomeHeaderViewTopButtonRight,

};

@protocol IncomeHeaderViewDelegate<NSObject>

@required

- (void)incomeHeaderView:(IncomeHeaderView *)headerView didSelectCalendarButton:(UIButton *)button buttonStatus:(BOOL)selected;

@optional

@end

@interface IncomeHeaderView : UIView

-(instancetype)initWithFrame:(CGRect)frame isOpenWisdomStorm:(BOOL)isOpenWisdomStore storeQuantity:(NSInteger)storeQuantity;

@property (nonatomic, weak) id<IncomeHeaderViewDelegate> incomeHeaderViewDelegate;


@property (nonatomic, strong) NSString *calendarTitle;

@property (nonatomic, strong) UIButton *calendarButton;

@end
