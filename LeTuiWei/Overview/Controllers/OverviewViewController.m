//
//  OverviewViewController.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/3/28.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "OverviewViewController.h"
#import "RingChartView.h"
#import "LineChartView.h"
@interface OverviewViewController ()

@end

@implementation OverviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(0x1c2249);
    
    RingChartView *ring = [[RingChartView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    /*        background color         */
    ring.backgroundColor = [UIColor whiteColor];
    /*        Data source array, only the incoming value, the corresponding ratio will be automatically calculated         */
    ring.valueDataArr = @[@"50",@"20",@"10",@"20"];
    /*         Width of ring graph        */
    ring.ringWidth = 80.0;
    /*        Fill color for each section of the ring diagram         */
    ring.fillColorArray = @[[UIColor colorWithRed:1.000 green:0.783 blue:0.371 alpha:1.000], [UIColor colorWithRed:1.000 green:0.562 blue:0.968 alpha:1.000],[UIColor colorWithRed:0.313 green:1.000 blue:0.983 alpha:1.000],[UIColor colorWithRed:0.560 green:1.000 blue:0.276 alpha:1.000],[UIColor colorWithRed:0.239 green:0.651 blue:0.170 alpha:1.000],[UIColor colorWithRed:0.239 green:0.651 blue:0.170 alpha:1.000]];
    /*        Start animation             */
    [ring showAnimation];
   // [self.view addSubview:ring];
    
    
    
    
    
    LineChartView *lineChart = [[LineChartView alloc] initWithFrame:CGRectMake(10, 100, kScreenWidth-20, 300)];
  
    [self.view addSubview:lineChart];

}

@end
