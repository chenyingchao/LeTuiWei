//
//  UserRegisterViewController.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/3/29.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "UserRegisterViewController.h"
#import "ConfirmButtonView.h"
#import "UIImage+AT.h"
@interface UserRegisterViewController ()<inputViewDelegate>

@property(nonatomic, strong) UIButton *clickButton;

@end

@implementation UserRegisterViewController

- (void)loadView {
    [super loadView];
    [self setupView];


}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"注册";

    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //[self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

#pragma mark 注册
- (void)userRegister {
    
    OIDevLog(@"%@", self.accountView.textField.text);
    OIDevLog(@"%@", self.passwordView.textField.text);
    
    
    if ( self.accountView.textField.text.length != 11) {
        [self showErrorMessage:@"请输入11位手机号"];
    }
    
    
}

- (void)setupView {
    WS(weakSelf);
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectZero];
    bgView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset([Theme paddingWithSize:66]);
        make.left.equalTo(weakSelf.view).offset([Theme paddingWithSize40]);
        make.right.equalTo(weakSelf.view).offset(-[Theme paddingWithSize40]);
        make.height.equalTo(@([Theme paddingWithSize:90] *3));
    }];
    
    bgView.layer.borderWidth = kSeparatorHeight;
    bgView.layer.borderColor = [[Theme colorBlackWithAlpha:0.3] CGColor];
    
    [bgView addSubview:self.accountView];
    self.accountView.delegate = self;
    [self.accountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView);
        make.left.equalTo(bgView);
        make.right.equalTo(bgView);
        make.height.equalTo(@([Theme paddingWithSize:90]));
    }];
    [self addLineToView:self.accountView separatorStyle:ATCommonCellSeparatorStyleFullLength];
    
    [bgView addSubview:self.captchaView];
    self.captchaView.delegate = self;
    [self.captchaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.accountView.mas_bottom);
        make.left.equalTo(bgView);
        make.right.equalTo(bgView);
        make.height.equalTo(@([Theme paddingWithSize:90]));
    }];
    
    [self addLineToView:self.captchaView separatorStyle:ATCommonCellSeparatorStyleFullLength];
    
    self.captchaView.verifyButtonClickedBlock = ^(UIButton *button) {
        
        [weakSelf countDown];
    };
    
    [bgView addSubview:self.passwordView];
    self.passwordView.delegate = self;
    [self.passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.captchaView.mas_bottom);
        make.left.equalTo(bgView);
        make.right.equalTo(bgView);
        make.height.equalTo(@([Theme paddingWithSize:90]));
    }];
    
    
    _clickButton= [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_clickButton];
    _clickButton.titleLabel.font = [Theme boldFontWithSize36];
    

    
    [_clickButton setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0xcccccc)] forState:UIControlStateNormal];
    
    [_clickButton  setTitleColor:[Theme colorWhite] forState:UIControlStateNormal];
    [_clickButton setTitle:@"立即注册" forState:UIControlStateNormal];
    _clickButton.userInteractionEnabled = NO;
    [_clickButton  bk_whenTapped:^{
        
        [weakSelf userRegister];
    }];
    
    [_clickButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).offset([Theme paddingWithSize36]);
        make.right.equalTo(weakSelf.view.mas_right).offset(-[Theme paddingWithSize36]);
        make.top.equalTo(bgView.mas_bottom).offset([Theme paddingWithSize:44]);
        make.height.equalTo(@([Theme paddingWithSize:88]));
    }];
    
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    
//    [self.view endEditing:YES];
//    
//
//    if (self.accountView.textField.text.length > 0 && self.passwordView.textField.text.length > 0 && self.captchaView.textField.text.length > 0) {
//        
//        [_clickButton setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0x3f88cd)] forState:UIControlStateNormal];
//        [_clickButton setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0x2c6ca7)] forState:UIControlStateHighlighted];
//        _clickButton.userInteractionEnabled = YES;
//    }
//    
//}

- (void)inputViewTextFieldDidEndEditing:(UITextField *)textField {

    
    if (self.accountView.textField.text.length > 0 && self.passwordView.textField.text.length > 0 && self.captchaView.textField.text.length > 0) {
        
        [_clickButton setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0x3f88cd)] forState:UIControlStateNormal];
        [_clickButton setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0x2c6ca7)] forState:UIControlStateHighlighted];
        _clickButton.userInteractionEnabled = YES;
    }
}

@end
