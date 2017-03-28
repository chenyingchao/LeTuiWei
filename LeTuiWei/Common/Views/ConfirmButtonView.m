//
//  ConfirmButtonView.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/3/28.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "ConfirmButtonView.h"

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
    [clickButton setBackgroundImage:[UIImage imageNamed:@"enterButton"] forState:UIControlStateNormal];
    [clickButton  setTitleColor:[Theme colorWhite] forState:UIControlStateNormal];
    [clickButton setTitle:title forState:UIControlStateNormal];
    
    [clickButton  bk_whenTapped:^{
        if (block) {
            block(clickButton);
        }
        
    }];
    return bgView;
}
@end
