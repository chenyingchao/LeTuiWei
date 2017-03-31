//
//  CustomPickerView.h
//  LeTuiWei
//
//  Created by 陈营超 on 2017/3/31.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^determineBtnActionBlock)(NSInteger shengId, NSInteger shiId, NSInteger xianId, NSString *shengName, NSString *shiName, NSString *xianName);

@interface CustomPickerView : UIView

@property (copy, nonatomic) determineBtnActionBlock determineBtnBlock;

- (void)show;

- (void)dismiss;


@property (strong, nonatomic) NSArray        *shengArray;

@property (strong, nonatomic) NSArray        *shiArray;

@property (strong, nonatomic) NSArray        *xianArray;


@end
