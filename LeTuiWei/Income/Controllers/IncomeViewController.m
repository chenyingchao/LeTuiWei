//
//  IncomeViewController.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/3/28.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "IncomeViewController.h"
#import "DistributionChartView.h"
@interface IncomeViewController ()

@end

@implementation IncomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DistributionChartView *lineChart = [[DistributionChartView alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth, 200)];

    [lineChart showAnimation];
    [self.view addSubview:lineChart];
}



@end
