//
//  ConfirmButtonView.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/3/28.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "ConfirmButtonView.h"
#import "UIImage+AT.h"
@implementation ConfirmButtonView

+ (instancetype)confirmButtonViewWithTitle:(NSString *)title andButtonClickedBlock:(void(^)(UIButton * button))block {
    
    ConfirmButtonView *bgView = [[ConfirmButtonView alloc] initWithFrame:CGRectZero];
    bgView.userInteractionEnabled = YES;
    UIButton *clickButton= [UIButton buttonWithType:UIButtonTypeCustom];
    [bgView addSubview:clickButton];
    clickButton.titleLabel.font = [Theme boldFontWithSize36];
    
    [clickButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(bgView);
    }];

    [clickButton setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0x3f88cd)] forState:UIControlStateNormal];
    [clickButton setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0x2c6ca7)] forState:UIControlStateHighlighted];

    [clickButton  setTitleColor:[Theme colorWhite] forState:UIControlStateNormal];
    [clickButton setTitle:title forState:UIControlStateNormal];
    
    [clickButton  bk_whenTapped:^{
        
        if (block) {
            block(clickButton);
        }
        
    }];
    
    
    
    
    
   // [clickButton addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchDown];
    
    return bgView;
}





@end
