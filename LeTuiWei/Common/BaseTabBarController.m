//
//  BaseTabBarController.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/3/28.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"
#import "AdministrationViewController.h"
#import "IncomeViewController.h"
#import "OverviewViewController.h"
@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupAllChildViewControllers];
    
}

- (void)setupAllChildViewControllers {
    
    NSArray *titleArray = @[@"概况", @"收入", @"管理"];
    NSArray *normalImageArray =@[@"overview", @"income", @"set"];
    NSArray *selectedImageArray =@[@"overview_fill", @"income_fill", @"set_fill"];
    
    for (int i = 0; i < titleArray.count; i++) {
        if (i == 0) {
            OverviewViewController *overviewVC = [[OverviewViewController alloc] init];
            [self setupChildViewController:overviewVC title:titleArray[i] imageName:normalImageArray[i] selectedImageName:selectedImageArray[i]];
        } else if (i == 1) {
            IncomeViewController *incomeVC = [[IncomeViewController alloc] init];
            [self setupChildViewController:incomeVC title:titleArray[i] imageName:normalImageArray[i] selectedImageName:selectedImageArray[i]];
        } else if (i == 2) {
            AdministrationViewController *adminVC = [[AdministrationViewController alloc] init];
            [self setupChildViewController:adminVC title:titleArray[i] imageName:normalImageArray[i] selectedImageName:selectedImageArray[i]];
        }
    }
}

- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    
    childVc.title = title;
    
    [childVc.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[Theme colorDimGray],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[Theme colorForAppearance],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    [childVc.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -3 )];
    
    
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    [childVc.tabBarItem setImageInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    UIImage *selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = selectedImage;
    
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:childVc];
    
    //childVc.navigationItem.title = title;
    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
