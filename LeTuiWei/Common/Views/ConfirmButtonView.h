//
//  ConfirmButtonView.h
//  LeTuiWei
//
//  Created by 陈营超 on 2017/3/28.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfirmButtonView : UIView

+ (instancetype)confirmButtonViewWithTitle:(NSString *)title andButtonClickedBlock:(void(^)(UIButton * button))block;

@property(nonatomic, strong) UIFont *titleFont;

@property(nonatomic, strong) UIColor *bgColor;


@end
