//
//  ReplaceCodeLastViewController.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/3/29.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "ReplaceCodeLastViewController.h"
#import "UIImage+AT.h"
@interface ReplaceCodeLastViewController ()

@property(nonatomic, strong) UIButton *clickButton;

@end

@implementation ReplaceCodeLastViewController


- (void)loadView {
    [super loadView];
    [self setupView];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"重置密码";
}

- (void)setupView {

    WS(weakSelf);
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.font = [Theme fontWithSize30];
    titleLabel.textColor = [Theme colorDarkGray];
    titleLabel.text = [NSString stringWithFormat:@"短信验证码已发送至%@",self.phoneNum];
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).offset([Theme paddingWithSize40]);
        make.top.equalTo(weakSelf.view).offset([Theme paddingWithSize:56]);
    }];
    
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectZero];
    bgView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset([Theme paddingWithSize:30]);
        make.left.equalTo(weakSelf.view).offset([Theme paddingWithSize40]);
        make.right.equalTo(weakSelf.view).offset(-[Theme paddingWithSize40]);
        make.height.equalTo(@([Theme paddingWithSize:90] *2));
    }];
    
    bgView.layer.borderWidth = kSeparatorHeight;
    bgView.layer.borderColor = [[Theme colorBlackWithAlpha:0.3] CGColor];
    
    [bgView addSubview:self.captchaView];
    [self.captchaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView);
        make.left.equalTo(bgView);
        make.right.equalTo(bgView);
        make.height.equalTo(@([Theme paddingWithSize:90]));
    }];
    
    [self addLineToView:self.captchaView separatorStyle:ATCommonCellSeparatorStyleFullLength];
    
    self.captchaView.verifyButtonClickedBlock = ^(UIButton *button) {
        
        [weakSelf countDown];
    };
    
    [bgView addSubview:self.passwordView];
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
    [_clickButton setTitle:@"重置密码" forState:UIControlStateNormal];
    _clickButton.userInteractionEnabled = NO;
    [_clickButton  bk_whenTapped:^{
        
        
    }];
    
    [_clickButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).offset([Theme paddingWithSize36]);
        make.right.equalTo(weakSelf.view.mas_right).offset(-[Theme paddingWithSize36]);
        make.top.equalTo(bgView.mas_bottom).offset([Theme paddingWithSize:44]);
        make.height.equalTo(@([Theme paddingWithSize:88]));
    }];


}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
    
    OIDevLog(@"%@", self.accountView.textField.text);
    OIDevLog(@"%@", self.passwordView.textField.text);
    
    if (self.passwordView.textField.text.length > 0 && self.captchaView.textField.text.length > 0) {
        
        [_clickButton setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0x3f88cd)] forState:UIControlStateNormal];
        [_clickButton setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0x2c6ca7)] forState:UIControlStateHighlighted];
        _clickButton.userInteractionEnabled = YES;
    }
    
}


@end
