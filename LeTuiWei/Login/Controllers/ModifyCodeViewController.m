//
//  ModifyCodeViewController.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/3/30.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "ModifyCodeViewController.h"
#import "LoginInputView.h"
#import "UIImage+AT.h"
@interface ModifyCodeViewController ()

@property(nonatomic, strong)LoginInputView *currentCodeView;

@property(nonatomic, strong)LoginInputView *beforeCodeView;

@property(nonatomic, strong) UIButton *clickButton;


@end

@implementation ModifyCodeViewController

- (void)loadView {
    [super loadView];
    [self setupView];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"修改密码";
    self.view.backgroundColor = [Theme colorForAppBackground];
}

- (void)confirmModifyCode {


}

- (void)setupView {
    WS(weakSelf);
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectZero];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top).offset([Theme paddingWithSize20]);
        make.left.equalTo(weakSelf.view);
        make.right.equalTo(weakSelf.view);
        make.height.equalTo(@([Theme paddingWithSize:90] *2));
    }];
    
    bgView.layer.borderWidth = kSeparatorHeight;
    bgView.layer.borderColor = [[Theme colorBlackWithAlpha:0.3] CGColor];
    
    [bgView addSubview:self.beforeCodeView];
    [self.beforeCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView);
        make.left.equalTo(bgView);
        make.right.equalTo(bgView);
        make.height.equalTo(@([Theme paddingWithSize:90]));

    }];
    [self addLineToView:self.beforeCodeView separatorStyle:SeparatorStyleHalfWithRight];
    
    [bgView addSubview:self.currentCodeView];
    [self.currentCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.beforeCodeView.mas_bottom);
        make.left.equalTo(bgView);
        make.right.equalTo(bgView);
        make.height.equalTo(@([Theme paddingWithSize:90]));
        
    }];
    
    
    _clickButton= [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_clickButton];
    _clickButton.titleLabel.font = [Theme boldFontWithSize36];
    
    
    [_clickButton setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0x3f88cd)] forState:UIControlStateNormal];
    [_clickButton setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0x2c6ca7)] forState:UIControlStateHighlighted];
    
    [_clickButton  setTitleColor:[Theme colorWhite] forState:UIControlStateNormal];
    [_clickButton setTitle:@"确认修改" forState:UIControlStateNormal];
   
    [_clickButton  bk_whenTapped:^{
        
        [weakSelf confirmModifyCode];
    }];
    
    [_clickButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).offset([Theme paddingWithSize36]);
        make.right.equalTo(weakSelf.view.mas_right).offset(-[Theme paddingWithSize36]);
        make.top.equalTo(bgView.mas_bottom).offset([Theme paddingWithSize:44]);
        make.height.equalTo(@([Theme paddingWithSize:88]));
    }];
    




}

- (LoginInputView *)beforeCodeView {
    
    if (!_beforeCodeView) {
        _beforeCodeView = [[LoginInputView alloc] initWithTitle:@"当前密码" placeHolder:@"请填写当前密码"];
    }
    return _beforeCodeView;
}

- (LoginInputView *)currentCodeView {
    
    if (!_currentCodeView) {
        _currentCodeView = [[LoginInputView alloc] initWithTitle:@"新密码" placeHolder:@"请填写6到16位新密码"];
    }
    return _currentCodeView;
}


@end
