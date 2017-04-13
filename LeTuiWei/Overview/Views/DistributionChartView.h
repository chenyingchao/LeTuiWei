//
//  DistributionChartView.h
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/13.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DistributionChartView : UIView


@property (nonatomic, assign) UIEdgeInsets contentInsets;

@property (nonatomic, strong) NSArray * valueArr;

-(void)showAnimation;

@end
