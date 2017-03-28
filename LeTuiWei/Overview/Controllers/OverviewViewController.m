//
//  OverviewViewController.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/3/28.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "OverviewViewController.h"
#import "UserLoginViewController.h"
#import "BaseNavigationController.h"
@interface OverviewViewController ()

@end

@implementation OverviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:loginButton];
    [loginButton bk_whenTapped:^{
        UserLoginViewController *userLoginVC = [[UserLoginViewController alloc] init];
        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:userLoginVC];
        [self presentViewController:nav animated:YES completion:nil];
        
    }];
}

@end
