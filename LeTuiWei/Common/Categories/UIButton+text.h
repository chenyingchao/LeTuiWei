//
//  UIButton+text.h
//  OilInstalments
//
//  Created by 陈颖超 on 2017/2/13.
//  Copyright © 2017年 chenyingchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (text)

- (id)initWithFrame:(CGRect)frame withTitle:(NSString *)title withTitleColor:(UIColor *)color withFont:(UIFont *)font andButtonClickedBlock:(void(^)(UIButton * button))block;


- (id)initWithFrame:(CGRect)frame withAttributedTitle:(NSAttributedString *)AttributedTitle withTitleColor:(UIColor *)color withFont:(UIFont *)font andButtonClickedBlock:(void(^)(UIButton * button))block;

@end
