//
//  ReplaceCodeViewController.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/3/29.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "ReplaceCodeViewController.h"
#import "UIImage+AT.h"
#import "ReplaceCodeLastViewController.h"
@interface ReplaceCodeViewController ()

@property(nonatomic, strong) UIButton *clickButton;

@end

@implementation ReplaceCodeViewController

- (void)loadView {
    [super loadView];
    [self setupView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"重置密码";
}

- (void)nextStep {
    
    ReplaceCodeLastViewController *replaceCodeLastVC = [[ReplaceCodeLastViewController alloc] init];
    replaceCodeLastVC.phoneNum = self.accountView.textField.text;
    [self.navigationController pushViewController:replaceCodeLastVC animated:YES];
}

- (void)setupView {

    WS(weakSelf);
    [self.view addSubview:self.accountView];
    [self.accountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset([Theme paddingWithSize:66]);
        make.left.equalTo(weakSelf.view).offset([Theme paddingWithSize:40]);
        make.right.equalTo(weakSelf.view).offset(-[Theme paddingWithSize:40]);
        make.height.equalTo(@([Theme paddingWithSize:90]));
    }];

    self.accountView.layer.borderWidth = kSeparatorHeight;
    self.accountView.layer.borderColor = [[Theme colorBlackWithAlpha:0.3] CGColor];
    
    
    _clickButton= [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_clickButton];
    _clickButton.titleLabel.font = [Theme boldFontWithSize36];
    
    
    
    [_clickButton setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0xcccccc)] forState:UIControlStateNormal];
    
    [_clickButton  setTitleColor:[Theme colorWhite] forState:UIControlStateNormal];
    [_clickButton setTitle:@"下一步" forState:UIControlStateNormal];
    _clickButton.userInteractionEnabled = NO;
    [_clickButton  bk_whenTapped:^{
        
        [weakSelf nextStep];
    }];
    
    [_clickButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).offset([Theme paddingWithSize36]);
        make.right.equalTo(weakSelf.view.mas_right).offset(-[Theme paddingWithSize36]);
        make.top.equalTo(weakSelf.accountView.mas_bottom).offset([Theme paddingWithSize:44]);
        make.height.equalTo(@([Theme paddingWithSize:88]));
    }];


}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
    
    OIDevLog(@"%@", self.accountView.textField.text);
    OIDevLog(@"%@", self.passwordView.textField.text);
    
    if (self.accountView.textField.text.length > 0) {
        
        [_clickButton setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0x3f88cd)] forState:UIControlStateNormal];
        [_clickButton setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0x2c6ca7)] forState:UIControlStateHighlighted];
        _clickButton.userInteractionEnabled = YES;
        
    }
    
    
}

@end
