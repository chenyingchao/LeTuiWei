//
//  CustomSegmentView.h
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/6.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectAtIndexBlock)(NSInteger index);

@interface CustomSegmentView : UIView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles;

@property (nonatomic, readonly, assign) NSInteger selectedIndex;

@property (nonatomic, copy) SelectAtIndexBlock selectAtIndexBlock;


- (void)setTitles:(NSArray<NSString *> *)titles;

- (void)selectTabAtIndex:(NSInteger)index;

- (void)disableTabAtIndex:(NSInteger)index;

- (void)enableTabAtIndex:(NSInteger)index;

@end
