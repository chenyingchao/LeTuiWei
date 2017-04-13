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
#import "ColumnChartView.h"
@interface OverviewViewController ()

@end

@implementation OverviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    RingChartView *ring = [[RingChartView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    ring.backgroundColor = [UIColor redColor];
    ring.redius = 30;
 
    ring.valueDataArr = @[@"50",@"20",@"10",@"20"];
    /*         Width of ring graph        */
    ring.ringWidth = 30.0;
    /*        Fill color for each section of the ring diagram         */
    ring.fillColorArray = @[[UIColor colorWithRed:1.000 green:0.783 blue:0.371 alpha:1.000], [UIColor colorWithRed:1.000 green:0.562 blue:0.968 alpha:1.000],[UIColor colorWithRed:0.313 green:1.000 blue:0.983 alpha:1.000],[UIColor colorWithRed:0.560 green:1.000 blue:0.276 alpha:1.000],[UIColor colorWithRed:0.239 green:0.651 blue:0.170 alpha:1.000],[UIColor colorWithRed:0.239 green:0.651 blue:0.170 alpha:1.000]];
    /*        Start animation             */
    [ring showAnimation];
    [self.view addSubview:ring];
    
    
    
    
    
    LineChartView *lineChart = [[LineChartView alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth, 200)];
    lineChart.contentInsets = UIEdgeInsetsMake(20, 50, 20, 50);
    lineChart.xLineDataArr = @[@"0:00",@"4:00",@"8:00",@"12:00",@"16:00",@"20:00",@"24:00"];
    lineChart.yLineDataArr = @[@"2500",@"5000",@"7500",@"10000",@"12500"];
    lineChart.valueArr = @[@[@"100",@"2500",@"200",@2000,@10000,@300,@5000]
                           ];
    lineChart.showYLine = NO;
    lineChart.showYLevelLine = YES;
    lineChart.valueLineColorArr =@[ [UIColor greenColor], [UIColor orangeColor]];
    [lineChart showAnimation];
    [self.view addSubview:lineChart];
    
    ColumnChartView *columnChart = [[ColumnChartView alloc] initWithFrame:CGRectMake(0, 300, kScreenWidth, 200)];
    columnChart.contentInsets = UIEdgeInsetsMake(20, 50, 20, 50);
    columnChart.xLineDataArr = @[@"0", @"20",@"40", @"60", @"80"];
    columnChart.yLineDataArr = @[@"top1", @"top2",@"top3", @"top4", @"top5"];
    columnChart.valueArr = @[@"20",@"30",@"10",@"70",@"40"];
    columnChart.columnColorArr =  @[[UIColor redColor],[UIColor orangeColor],[UIColor blueColor],[UIColor grayColor],[UIColor greenColor]];
    
    
    [columnChart showAnimation];
    [self.view addSubview:columnChart];

}

@end
