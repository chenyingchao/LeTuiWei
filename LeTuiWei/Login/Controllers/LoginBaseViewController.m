//
//  LoginBaseViewController.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/3/28.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "LoginBaseViewController.h"

#define kSurplusSecond 60
@interface LoginBaseViewController ()

@property (assign, nonatomic) NSInteger surplusSecond;

@end

@implementation LoginBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)countDown {
    _surplusSecond = kSurplusSecond;
    WS(weakSelf);
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, globalQueue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0.0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        
        if (_surplusSecond <= 0) {
            dispatch_source_cancel(timer);
            dispatch_async(mainQueue, ^{
                weakSelf.captchaView.verifyButton.enabled = YES;
                [weakSelf.captchaView.verifyButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                _surplusSecond = kSurplusSecond;
            });
        } else {
            _surplusSecond--;
            dispatch_async(mainQueue, ^{
                NSString *btnInfo = [NSString stringWithFormat:@"%ldS", (long)(_surplusSecond + 1)];
                weakSelf.captchaView.verifyButton.enabled = NO;
                [weakSelf.captchaView.verifyButton setTitle:btnInfo forState:UIControlStateDisabled];
            });
        }
    });
    dispatch_source_set_cancel_handler(timer, ^{
        
    });
    dispatch_resume(timer);
}


- (LoginInputView *)accountView {
    if (!_accountView) {
        
        LoginInputView *accountView = [[LoginInputView alloc] initWithImageIcon:[UIImage imageNamed:@"phone_logo"] placeHolder:@"请输入手机号" ShowVerifyButton:NO];
        accountView.textField.keyboardType = UIKeyboardTypeNumberPad;
        _accountView = accountView;
        
    }
    return _accountView;
}

- (LoginInputView *)passwordView {
    if (!_passwordView) {
        
        LoginInputView *passwordView = [[LoginInputView alloc] initWithImageIcon:[UIImage imageNamed:@"code_logo"] placeHolder:@"请输入登录密码" ShowVerifyButton:NO];
        passwordView.textField.secureTextEntry = YES;
        _passwordView = passwordView;
    }
    return _passwordView;
}

- (LoginInputView *)captchaView {
    if (!_captchaView) {
        
        LoginInputView *captchaView = [[LoginInputView alloc] initWithImageIcon:[UIImage imageNamed:@"message_logo"] placeHolder:@"请输入短信验证码" ShowVerifyButton:YES];
        captchaView.textField.secureTextEntry = YES;
        _captchaView = captchaView;
    }
    return _captchaView;
    
}

- (LoginInputView *)invitationView {
    if (!_invitationView) {
        
        LoginInputView *invitationView = [[LoginInputView alloc] initWithImageIcon:[UIImage imageNamed:@"person_logo"] placeHolder:@"请输入邀请人" ShowVerifyButton:NO];
        invitationView.textField.secureTextEntry = YES;
        _invitationView = invitationView;
    }
    return _invitationView;
}

- (void)addLineToView:(UIView *)view separatorStyle:(ATCommonCellSeparatorStyle)separatorStyle {
    
    [self removeLine:view];
    
    UILabel * seperatorLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    seperatorLabel.backgroundColor = [Theme colorBlackWithAlpha:0.3];
    [view addSubview:seperatorLabel];
    seperatorLabel.tag = 999;
    if (separatorStyle == ATCommonCellSeparatorStyleDefault) {
        [seperatorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).offset([Theme paddingWithSize36]);
            make.right.equalTo(view);
            make.height.equalTo(@(kSeparatorHeight));
            make.bottom.equalTo(view);
        }];
    } else {
        [seperatorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view);
            make.right.equalTo(view);
            make.height.equalTo(@(kSeparatorHeight));
            make.bottom.equalTo(view);
        }];
    }
    
}

- (void)removeLine:(UIView *)view {
    UILabel *find_label = (UILabel *)[view viewWithTag:999];
    [find_label removeFromSuperview];
    
}


@end
