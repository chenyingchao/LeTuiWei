//
//  BaseViewController.h
//  LeTuiWei
//
//  Created by 陈营超 on 2017/3/28.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "AllocDeallocViewController.h"

@interface BaseViewController : AllocDeallocViewController




/*loading interface*/
// modal loading with or without messages
- (void)showModalLoading;
- (void)showModalLoadingWithMessage:(NSString *)message;
- (void)dismissModalLoadingView;

// Show message with or without an indicator icon, they will be hidden automatically after a short delay.
- (void)showErrorMessage:(NSString *)message;
- (void)showSuccessMessage:(NSString *)message;
- (void)showPlainMessage:(NSString *)message;
- (void)showErrorMessage:(NSString *)message toView:(UIView *)view;
- (void)showSuccessMessage:(NSString *)message toView:(UIView *)view;
- (void)showPlainMessage:(NSString *)message toView:(UIView *)view;


// Hide the hud in case you want do it manually
- (void)dismissHudView;


@end
