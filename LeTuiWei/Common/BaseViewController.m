//
//  BaseViewController.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/3/28.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "BaseViewController.h"
#import "MBProgressHUD+AT.h"
#import "SVProgressHUD.h"

@interface BaseViewController ()

@end

@implementation BaseViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [Theme colorWhite];
    [self setupNavigationBar:self.navigationController];
    if (self.navigationController.viewControllers.count > 1) {
        [self setUpNavigationBarLeftBack];
    }
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


- (void)setupNavigationBar:(UINavigationController *)naviController {
    naviController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[Theme colorForNavigationBarText], NSFontAttributeName:[Theme fontWithSize36]};
    self.navigationController.navigationBar.barTintColor = [Theme colorForNavigationBarBackgroundWithAlpha:0.7];
}


- (void)setUpNavigationBarLeftBack {
    UIView *leftContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, kNavigationBarHeight)];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftContainerView addSubview:backBtn];
    [backBtn setImage:[UIImage imageNamed:@"goBack"] forState:UIControlStateNormal];
    //   [backBtn setImage:[UIImage imageByApplyingAlpha:0.7 image:[UIImage imageNamed:@"goBack"]] forState:UIControlStateHighlighted];
    
    
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    backBtn.frame = CGRectMake(0, 0, kNavigationBarHeight, kNavigationBarHeight);
    WS(weakSelf);
    [backBtn bk_whenTapped:^{
        [weakSelf leftbarbuttonAction];
    }];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftContainerView];
}

- (void)leftbarbuttonAction {
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)hiddenNavigationBarSeparatorLine {
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        NSArray *list=self.navigationController.navigationBar.subviews;
        for (id obj in list) {
            if ([obj isKindOfClass:[UIView class]]) {
                UIView *imageView=(UIView *)obj;
                NSArray *list2=imageView.subviews;
                for (id obj2 in list2) {
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        UIImageView *imageView2=(UIImageView *)obj2;
                        imageView2.hidden = imageView2.bounds.size.height < 1;
                    }
                }
            }
        }
    }
}

- (void)addNavigationBarSeparatorLine {
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        NSArray *list=self.navigationController.navigationBar.subviews;
        for (id obj in list) {
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView=(UIImageView *)obj;
                NSArray *list2=imageView.subviews;
                for (id obj2 in list2) {
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        UIImageView *imageView2=(UIImageView *)obj2;
                        imageView2.hidden = NO;
                        if (!imageView2.subviews.count) {
                            UIView *separatorLine = [[UIView alloc] initWithFrame:imageView2.bounds];
                            separatorLine.backgroundColor = [Theme colorForSeparatorLine];
                            [imageView2 addSubview:separatorLine];
                        }
                    }
                }
            }
        }
    }
}


- (BOOL)isHiddenNavigationBar {
    return NO;
}

- (BOOL)isHiddenNavigationBarShadowImage {
    return NO;
}


- (void)showErrorMessage:(NSString *)message {
    if (!message.length) {
        return;
    }
    [MBProgressHUD showError:message];
}

- (void)showSuccessMessage:(NSString *)message {
    if (!message.length) {
        return;
    }
    [MBProgressHUD showSuccess:message];
}

- (void)showPlainMessage:(NSString *)message {
    if (!message.length) {
        return;
    }
    [MBProgressHUD showMessage:message];
}

- (void)showErrorMessage:(NSString *)message toView:(UIView *)view {
    if (!message.length) {
        return;
    }
    [MBProgressHUD showError:message toView:view];
}

- (void)showSuccessMessage:(NSString *)message toView:(UIView *)view {
    if (!message.length) {
        return;
    }
    [MBProgressHUD showSuccess:message toView:view];
}

- (void)showPlainMessage:(NSString *)message toView:(UIView *)view {
    if (!message.length) {
        return;
    }
    [MBProgressHUD showMessage:message toView:view];
}

- (void)dismissHudView {
    [MBProgressHUD hideHUD];
}

- (void)showModalLoading {
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.9]];
    [SVProgressHUD setForegroundColor:[Theme colorThemeColor]];
    [SVProgressHUD show];
    
    //TODO::
    //    NSString *loadingImg = [self getLoadingImageName];
    //    if (loadingImg.length) {
    //        [ATHudView setGifWithImageName:loadingImg];
    //        [ATHudView showWithOverlay];
    //    } else {
    //        // show default loading
    //        // TODO, we use MBProgressHud to display the 'default' loading view,
    //        //  ---lack of UX resources for this kind of loading.
    //        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:ATKeyWindow animated:YES];
    //        hud.mode = MBProgressHUDAnimationFade;
    //        hud.removeFromSuperViewOnHide = YES;
    //    }
}

- (void)showModalLoadingWithMessage:(NSString *)message {
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.9]];
    [SVProgressHUD setForegroundColor:[Theme colorThemeColor]];
    [SVProgressHUD showWithStatus:message];
    
    //TODO::
    //    NSString *loadingImg = [self getLoadingImageName];
    //    if (loadingImg.length) {
    //        [ATHudView setGifWithImageName:loadingImg andLaodingMessage:message];
    //        [ATHudView showWithOverlay];
    //    } else {
    //        // show default loading
    //        // TODO, we use MBProgressHud to display the 'default' loading view,
    //        //  ---lack of UX resources for this kind of loading.
    //        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:ATKeyWindow animated:YES];
    //        hud.mode = MBProgressHUDAnimationFade;
    //        hud.removeFromSuperViewOnHide = YES;
    //    }
}

- (void)dismissModalLoadingView {
    [SVProgressHUD dismiss];
    //    NSString *loadingImg = [self getLoadingImageName];
    //    if (loadingImg.length) {
    //        [ATHudView dismiss];
    //    } else {
    //        [MBProgressHUD hideHUDForView:ATKeyWindow animated:YES];
    //    }
}







@end
