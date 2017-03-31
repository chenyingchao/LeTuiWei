//
//  LoginBaseViewController.h
//  LeTuiWei
//
//  Created by 陈营超 on 2017/3/28.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "BaseViewController.h"
#import "LoginInputView.h"

typedef NS_ENUM(NSUInteger, SeparatorStyle) {
    SeparatorStyleDefault,
    SeparatorStyleFullLength,
    SeparatorStyleHalfLength,
    SeparatorStyleSymmetricalDefault,
    SeparatorStyleHalfWithRight,
    SeparatorStyleNone,
};


@interface LoginBaseViewController : BaseViewController


@property (nonatomic, strong) LoginInputView *accountView;

@property (nonatomic, strong) LoginInputView *passwordView;

@property (nonatomic, strong) LoginInputView *captchaView;


- (void)countDown;

- (void)addLineToView:(UIView *)view separatorStyle:(SeparatorStyle)separatorStyle;

- (void)removeLine:(UIView *)view;


@end
