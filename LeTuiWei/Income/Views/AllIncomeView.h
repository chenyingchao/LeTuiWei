//
//  AllIncomeView.h
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/25.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AllIncomeView;
@protocol AllIncomeDelegate<NSObject>

@required

- (void)allIncomeView:(AllIncomeView *)allIncomeView didSelectData:(NSString *)selectData;

@optional



@end


typedef NS_ENUM(NSUInteger, IncomeButtonType){

     IncomeButtonTypeAllIncome = 300,
     IncomeButtonTypeOrderProduct,
     IncomeButtonTypeOrderNoProduct,
     IncomeButtonTypeOrderVipTopUp
};


@interface AllIncomeView : UIView

@property (nonatomic, weak) id<AllIncomeDelegate> allIncomeDelegate;

- (void)showAllIncomeHeaderView;

- (void)dissmisAllIncomeHeaderView;

- (void)showTabView;

- (void)dissmisTabView;

@end
