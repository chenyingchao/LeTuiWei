//
//  addStoreAccountViewController.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/1.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "addStoreAccountViewController.h"
#import "LoginInputView.h"
#import "ConfirmButtonView.h"
#import "UIButton+text.h"
#import "CustomAlertView.h"
#import "StoreAccountManagerViewController.h"
@interface addStoreAccountViewController ()<AlertViewDelegate>

@property(nonatomic, strong)LoginInputView *storeAccountView;

@property(nonatomic, strong)LoginInputView *passwordView;

@property (nonatomic, strong) CustomAlertView *customAlertView;

@end

@implementation addStoreAccountViewController

- (void)loadView {
    [super loadView];
    [self setupView];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [Theme colorForAppBackground];
    self.navigationItem.title = @"添加门店派账号";

}

- (void)addStoreAccount {
  //添加成功
    [self.customAlertView showAlertView:@"已成功添加门店派账号！请在收银机端使用" withType:AlertViewTypeIKnow];
    

}

//点击我知道了  跳转门店派账号管理详情
- (void)requestEventAction:(UIButton *)button withAlertTitle:(NSString *)title {

    StoreAccountManagerViewController *accountManagerVC = [[StoreAccountManagerViewController alloc] init];
    [self.navigationController pushViewController:accountManagerVC animated:YES];
}

- (void)readAgreement {


}

- (void)setupView {
    WS(weakSelf);
  
    
    [self.view addSubview:self.storeAccountView];
    self.storeAccountView.backgroundColor = [Theme colorWhite];
    [self.storeAccountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset([Theme paddingWithSize20]);
        make.left.equalTo(weakSelf.view);
        make.right.equalTo(weakSelf.view);
        make.height.equalTo(@([Theme paddingWithSize:90]));
        
    }];
   
    UILabel *accountPromptLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    accountPromptLabel.text = @"字母（不区分大小写）、数字、下划线组成（不能以下划线开头），不少于6位";
    accountPromptLabel.numberOfLines = 0;
    accountPromptLabel.font = [Theme fontWithSize24];
    accountPromptLabel.textColor = [Theme colorDimGray];
    [self.view addSubview:accountPromptLabel];
    
    [accountPromptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).offset([Theme paddingWithSize:46]);
        make.right.equalTo(weakSelf.view).offset(-[Theme paddingWithSize:46]);
        make.top.equalTo(weakSelf.storeAccountView.mas_bottom).offset([Theme paddingWithSize24]);
    }];
    [self.view addSubview:self.passwordView];
    self.passwordView.backgroundColor = [Theme colorWhite];
    [self.passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(accountPromptLabel.mas_bottom).offset([Theme paddingWithSize24]);
        make.left.equalTo(weakSelf.view);
        make.right.equalTo(weakSelf.view);
        make.height.equalTo(@([Theme paddingWithSize:90]));
        
    }];
    
    
    UILabel *passwordPromptLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    passwordPromptLabel.text = @"大小写字母、数字组成，不少于6位";
    passwordPromptLabel.numberOfLines = 0;
    passwordPromptLabel.font = [Theme fontWithSize24];
    passwordPromptLabel.textColor = [Theme colorDimGray];
    [self.view addSubview:passwordPromptLabel];
    
    [passwordPromptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).offset([Theme paddingWithSize:46]);
        make.right.equalTo(weakSelf.view).offset(-[Theme paddingWithSize:46]);
        make.top.equalTo(weakSelf.passwordView.mas_bottom).offset([Theme paddingWithSize24]);
    }];

    ConfirmButtonView *submitView = [ConfirmButtonView confirmButtonViewWithTitle:@"确认添加" andButtonClickedBlock:^(UIButton *button) {
        [weakSelf addStoreAccount];
    }];
    [self.view addSubview:submitView];
    [submitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).offset([Theme paddingWithSize40]);
        make.right.equalTo(weakSelf.view.mas_right).offset(-[Theme paddingWithSize40]);
        make.top.equalTo(passwordPromptLabel.mas_bottom).offset([Theme paddingWithSize:44]);
        make.height.equalTo(@([Theme paddingWithSize:88]));
    }];
    
    NSString *str = @"我已阅读并接受《乐推微门店派服务协议》";
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attrStr addAttribute:NSForegroundColorAttributeName value:[Theme colorDimGray] range:NSMakeRange(0, 7)];
    [attrStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x3f88cd) range:NSMakeRange(7, 12)];

    UIButton *agreementButton = [[UIButton alloc] initWithFrame:CGRectZero withAttributedTitle:attrStr withTitleColor:nil withFont:[Theme fontWithSize28] andButtonClickedBlock:^(UIButton *button) {
        [weakSelf readAgreement];
    }];

    [self.view addSubview:agreementButton];
    [agreementButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view);
        make.top.equalTo(submitView.mas_bottom).offset([Theme paddingWithSize28]);
    }];
    
}


- (LoginInputView *)storeAccountView {
    if (!_storeAccountView) {
        _storeAccountView = [[LoginInputView alloc] initWithTitle:@"门店派账号" placeHolder:@"请填写"];
    }
    return _storeAccountView;
}

- (LoginInputView *)passwordView {
    if (!_passwordView) {
        _passwordView = [[LoginInputView alloc] initWithTitle:@"登录密码" placeHolder:@"请填写"];
    }
    return _passwordView;
}

- (CustomAlertView *)customAlertView {
    if (!_customAlertView) {
        _customAlertView = [[CustomAlertView alloc] initWithFrame:CGRectMake([Theme paddingWithSize100], 200, [UIScreen mainScreen].bounds.size.width - [Theme paddingWithSize100] * 2,[Theme paddingWithSize:300])];
        
        
        _customAlertView.backgroundColor = [UIColor whiteColor];
        _customAlertView.delegate = self;
    }
    
    return _customAlertView;
}

@end
