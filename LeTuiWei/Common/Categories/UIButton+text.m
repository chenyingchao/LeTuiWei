//
//  UIButton+text.m
//  OilInstalments
//
//  Created by 陈颖超 on 2017/2/13.
//  Copyright © 2017年 chenyingchao. All rights reserved.
//

#import "UIButton+text.h"

@implementation UIButton (text)

- (id)initWithFrame:(CGRect)frame withTitle:(NSString *)title withTitleColor:(UIColor *)color withFont:(UIFont *)font andButtonClickedBlock:(void(^)(UIButton * button))block {
    self = [super initWithFrame:frame];
    if (self) {

        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor: color forState:UIControlStateNormal];
        self.titleLabel.font = font;
        [self bk_whenTapped:^{
            if (block) {
                block(self);
            }
            
        }];
    }
    return self;
}




@end
