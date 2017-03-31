//
//  ConfirmButtonView.h
//  LeTuiWei
//
//  Created by 陈营超 on 2017/3/28.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import <UIKit/UIKit.h>


//typedef NS_ENUM(NSUInteger, SelectStatus) {
//    SelectStatusNormal,
//    SelectStatusNot,
// 
//    
//};

@interface ConfirmButtonView : UIView

+ (instancetype)confirmButtonViewWithTitle:(NSString *)title andButtonClickedBlock:(void(^)(UIButton * button))block;


@property(nonatomic, strong) UIButton *clickButton;

@end
