//
//  CustomAlertView.h
//  LeTuiWei
//
//  Created by 陈营超 on 2017/3/30.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, AlertViewType) {
    AlertViewTypeCommon = 0,
    AlertViewTypeIKnow,
    AlertViewTypeAddAccount,
    AlertViewTypeAddStores,
};

@protocol AlertViewDelegate <NSObject>

- (void)requestEventAction:(UIButton *)button withAlertTitle:(NSString *)title;

- (void)spaceRequestEventAction:(UIButton *)button withAlertTitle:(NSString *)title;

@end


@interface CustomAlertView : UIView

@property (nonatomic,weak) id <AlertViewDelegate> delegate;

- (void)showAlertView:(NSString *)title withType:(AlertViewType)type;

- (void)closeView;

@end
