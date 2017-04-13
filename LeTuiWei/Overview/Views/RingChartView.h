//
//  RingChartView.h
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/11.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RingChartView : UIView


/**
 *  Data source Array
 */
@property (nonatomic, strong) NSArray * valueDataArr;


/**
 *  An array of colors in the loop graph
 */
@property (nonatomic, strong) NSArray * fillColorArray;


@property (nonatomic,assign) CGFloat ringWidth;


@property (nonatomic,assign) CGFloat redius;



- (void)showAnimation;

@end
