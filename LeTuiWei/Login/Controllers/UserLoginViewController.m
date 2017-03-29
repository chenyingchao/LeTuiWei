//
//  UserLoginViewController.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/3/28.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "UserLoginViewController.h"
#import "ConfirmButtonView.h"
#import "UIButton+text.h"
#import "UserRegisterViewController.h"
#import "BaseNavigationController.h"
#import "ReplaceCodeViewController.h"
@interface UserLoginViewController ()
@end

@implementation UserLoginViewController

- (void)loadView {
    [super loadView];
    [self setupView];
}


- (void)viewDidLoad {
    [super viewDidLoad];
  
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

#pragma mark 登录
- (void)userLgoin {
    OIDevLog(@"%@", self.accountView.textField.text);
    OIDevLog(@"%@", self.passwordView.textField.text);
    
    if ( self.accountView.textField.text.length != 11) {
        [self showErrorMessage:@"请输入11位手机号"];
    }
    
}

#pragma mark 忘记密码
- (void)forgetCode {
    ReplaceCodeViewController *replaceCodeVC =[[ ReplaceCodeViewController alloc] init];
    [self.navigationController pushViewController:replaceCodeVC animated:YES];
}

#pragma mark 注册账号
- (void)registerAccount {

    UserRegisterViewController *registerVC =[[ UserRegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];

}

- (void)setupView {
    WS(weakSelf);

    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:bgImageView];
    bgImageView.image = [UIImage imageNamed:@"loginbg"];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.edges.equalTo(weakSelf.view);
    }];
    bgImageView.userInteractionEnabled = YES;
    
    UIImageView *titleImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [bgImageView addSubview:titleImageView];
    titleImageView.image = [UIImage imageNamed:@"companyLogo"];
    [titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgImageView);
        make.top.equalTo(bgImageView.mas_top).offset([Theme paddingWithSize:216]);
    }];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLable.text = @"欢迎来到乐推微";
    titleLable.font = [Theme fontWithSize32];
    titleLable.textColor = [Theme colorWhite];
    [bgImageView addSubview:titleLable];
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view);
        make.top.equalTo(titleImageView.mas_bottom).offset([Theme paddingWithSize:30]);
    }];
    
    [bgImageView addSubview:self.accountView];
    [self.accountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLable.mas_bottom).offset([Theme paddingWithSize:58]);
        make.left.equalTo(weakSelf.view).offset([Theme paddingWithSize40]);
        make.right.equalTo(weakSelf.view).offset(-[Theme paddingWithSize40]);
        make.height.equalTo(@([Theme paddingWithSize:104]));
    }];
    
    [self addLineToView:self.accountView separatorStyle:ATCommonCellSeparatorStyleFullLength];
    
    [bgImageView addSubview:self.passwordView];
    [self.passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.accountView.mas_bottom);
        make.left.equalTo(weakSelf.view).offset([Theme paddingWithSize40]);
        make.right.equalTo(weakSelf.view).offset(-[Theme paddingWithSize40]);
        make.height.equalTo(@([Theme paddingWithSize:104]));
    }];
    
    ConfirmButtonView *loginView = [ConfirmButtonView confirmButtonViewWithTitle:@"登录" andButtonClickedBlock:^(UIButton *button) {
        [weakSelf userLgoin];
    }];
    
    [bgImageView addSubview:loginView];
    
    [loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).offset([Theme paddingWithSize36]);
        make.right.equalTo(weakSelf.view.mas_right).offset(-[Theme paddingWithSize36]);
        make.top.equalTo(weakSelf.passwordView.mas_bottom).offset([Theme paddingWithSize:84]);
        make.height.equalTo(@([Theme paddingWithSize:88]));
    }];
    
    
    UIButton *forgetCodeButton = [[UIButton alloc] initWithFrame:CGRectZero withTitle:@"忘记密码？" withTitleColor:UIColorFromRGB(0x5f6c92)  withFont: [Theme fontWithSize28] andButtonClickedBlock:^(UIButton *button) {
        [weakSelf forgetCode];
  
    }];
    [bgImageView addSubview:forgetCodeButton];
    [forgetCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view);
        make.top.equalTo(loginView.mas_bottom).offset([Theme paddingWithSize:30]);
    }];
    
    UIButton *registerButton = [[UIButton alloc] initWithFrame:CGRectZero withTitle:@"还没有账号，点此注册" withTitleColor:[Theme colorForAppearance] withFont: [Theme fontWithSize28] andButtonClickedBlock:^(UIButton *button) {
        [weakSelf registerAccount];

    }];
    
    [bgImageView addSubview:registerButton];
    [registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view.mas_bottom).offset(-[Theme paddingWithSize:138]);
    }];
    
    
    UILabel * seperatorLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    seperatorLabel.backgroundColor = [Theme colorForAppearance];
    [bgImageView addSubview:seperatorLabel];
   
    [seperatorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgImageView).offset([Theme paddingWithSize32]);
        make.right.equalTo(registerButton.mas_left).offset(-[Theme paddingWithSize32]);
        make.height.equalTo(@(kSeparatorHeight));
        make.centerY.equalTo(registerButton);
    }];
    
    
    UILabel * seperatorLabel1 = [[UILabel alloc] initWithFrame:CGRectZero];
    seperatorLabel1.backgroundColor = [Theme colorForAppearance];
    [bgImageView addSubview:seperatorLabel1];
    
    [seperatorLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(registerButton.mas_right).offset([Theme paddingWithSize32]);
        make.right.equalTo(bgImageView).offset(-[Theme paddingWithSize32]);
        make.height.equalTo(@(kSeparatorHeight));
        make.centerY.equalTo(registerButton);
    }];



}





@end
