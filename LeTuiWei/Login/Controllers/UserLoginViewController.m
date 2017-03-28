//
//  UserLoginViewController.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/3/28.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "UserLoginViewController.h"
#import "ConfirmButtonView.h"
@interface UserLoginViewController ()<UIScrollViewDelegate>

@end

@implementation UserLoginViewController

- (void)loadView {
    [super loadView];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
  
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}


- (void)setupView {
    WS(weakSelf);
    UIScrollView *bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    [bgScrollView setContentSize:CGSizeMake(0, (kScreenHeight + 10))];
    bgScrollView.delegate = self;
    bgScrollView.showsHorizontalScrollIndicator=NO;
    bgScrollView.showsVerticalScrollIndicator=NO;
    bgScrollView.userInteractionEnabled=YES;
    [self.view addSubview:bgScrollView];
    [bgScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    UIImageView *titleImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [bgScrollView addSubview:titleImageView];
    titleImageView.image = [UIImage imageNamed:@"oilinstalments_icon"];
    [titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgScrollView);
        make.top.equalTo(bgScrollView.mas_top).offset([Theme paddingWithSize:124]);
    }];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLable.text = @"欢迎来到乐推微";
    titleLable.font = [Theme fontWithSize36];
    titleLable.tintColor = [Theme colorDarkGray];
    [bgScrollView addSubview:titleLable];
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgScrollView);
        make.top.equalTo(titleImageView.mas_bottom).offset([Theme paddingWithSize24]);
    }];
    
    [bgScrollView addSubview:self.accountView];
    [self.accountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLable.mas_bottom).offset([Theme paddingWithSize:58]);
        make.left.equalTo(weakSelf.view);
        make.right.equalTo(weakSelf.view);
        make.height.equalTo(@([Theme paddingWithSize:104]));
    }];
    
    [bgScrollView addSubview:self.passwordView];
    [self.passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.accountView.mas_bottom);
        make.left.equalTo(weakSelf.view);
        make.right.equalTo(weakSelf.view);
        make.height.equalTo(@([Theme paddingWithSize:104]));
    }];
    
    ConfirmButtonView *loginView = [ConfirmButtonView confirmButtonViewWithTitle:@"登录" andButtonClickedBlock:^(UIButton *button) {
        //[weakSelf userLgoin];
    }];
    
    [bgScrollView addSubview:loginView];
    
    [loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).offset([Theme paddingWithSize36]);
        make.right.equalTo(weakSelf.view.mas_right).offset(-[Theme paddingWithSize36]);
        make.top.equalTo(weakSelf.passwordView.mas_bottom).offset([Theme paddingWithSize:84]);
        make.height.equalTo(@([Theme paddingWithSize:88]));
    }];
    

}



@end
