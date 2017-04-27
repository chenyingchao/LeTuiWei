//
//  BaseNavigationController.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/3/28.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.exclusiveTouch = YES;
    WS(weakSelf);
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
    }
   
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {

    [super pushViewController:viewController animated:animated];
    self.interactivePopGestureRecognizer.enabled = YES;
    
}

@end
