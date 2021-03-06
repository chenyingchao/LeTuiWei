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
        
        LoginInputView *accountView = [[LoginInputView alloc] initWithImageIcon:[UIImage imageNamed:@"mobile"] placeHolder:@"请输入手机号" textFieldType:TextFieldTypeAccount];
        accountView.textField.keyboardType = UIKeyboardTypeNumberPad;
        _accountView = accountView;
        
    }
    return _accountView;
}

- (LoginInputView *)passwordView {
    if (!_passwordView) {
        
        LoginInputView *passwordView = [[LoginInputView alloc] initWithImageIcon:[UIImage imageNamed:@"password"] placeHolder:@"请输入登录密码" textFieldType:TextFieldTypePassWord];
        passwordView.textField.secureTextEntry = YES;
        _passwordView = passwordView;
    }
    return _passwordView;
}

- (LoginInputView *)captchaView {
    if (!_captchaView) {
        
        LoginInputView *captchaView = [[LoginInputView alloc] initWithImageIcon:[UIImage imageNamed:@"code"] placeHolder:@"请输入短信验证码" textFieldType:TextFieldTypeCaptcha];

        _captchaView = captchaView;
    }
    return _captchaView;
    
}


- (void)addLineToView:(UIView *)view separatorStyle:(SeparatorStyle)separatorStyle {
    
    [self removeLine:view];
    
    UILabel * seperatorLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    seperatorLabel.backgroundColor = [Theme colorBlackWithAlpha:0.3];
    [view addSubview:seperatorLabel];
    seperatorLabel.tag = 999;
    if (separatorStyle == SeparatorStyleDefault) {
        [seperatorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).offset([Theme paddingWithSize36]);
            make.right.equalTo(view);
            make.height.equalTo(@(kSeparatorHeight));
            make.bottom.equalTo(view);
        }];
    } else if (separatorStyle == SeparatorStyleHalfWithRight) {
        [seperatorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).offset([Theme paddingWithSize36]);
            make.right.equalTo(view).offset(-[Theme paddingWithSize36]);
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}


@end
