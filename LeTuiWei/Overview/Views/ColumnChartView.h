//
//  ColumnChartView.h
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/13.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColumnChartView : UIView

@property (nonatomic, assign) UIEdgeInsets contentInsets;


@property (nonatomic, strong) NSArray * valueArr;


@property (nonatomic, strong) NSArray * columnColorArr;

@property (nonatomic, strong) NSArray * xLineDataArr;

@property (nonatomic, strong) NSArray * yLineDataArr;

@property (nonatomic, strong) UIColor *xTextColor;

@property (nonatomic, strong) UIColor *yTextColor;

@property (nonatomic, strong) UIColor *yLineColor;

@property (nonatomic, strong) UIColor *columnTextColor;

-(void)showAnimation;

@end
