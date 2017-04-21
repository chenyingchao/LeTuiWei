//
//  IncomeViewController.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/3/28.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "IncomeViewController.h"
#import "DistributionChartView.h"
#import "NavigitionHeaderView.h"
#import "CalendarView.h"
#import "IncomeViewCell.h"

@interface IncomeViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NavigitionHeaderView *headerView;

@property (nonatomic, strong) CalendarView *calendarView;

@property (nonatomic, copy) NSString *checkInDateStr;

@property (nonatomic, copy) NSString *checkOutDateStr;

@property (nonatomic, assign) NaviHeaderViewButtonType headerButtonType;

@property (nonatomic, strong) UILabel *naviLbael;

@property (nonatomic, strong) UIView *naviView;


@end

@implementation IncomeViewController

- (void)loadView {
    [super loadView];
    [self createNavigitionHeaderView];
    [self creatTableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout=UIRectEdgeNone;
  
}

- (void)creatTableView {
    WS(weakSelf);
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [Theme colorForAppBackground];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_tableView];
    [self.view sendSubviewToBack:_tableView];
    [_tableView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view).offset([Theme paddingWithSize:200] + 64);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return [Theme paddingWithSize:200];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    IncomeViewCell *cell = nil;
    
    switch (indexPath.section) {
        case IncomeViewCellLineBottomStore: {
        
            cell = [[IncomeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BottomStore" withDataSource:nil withCellType:IncomeViewCellLineBottomStore];
        }
            
            break;
            
        case IncomeViewCellLineUpH5Object: {
            
            cell = [[IncomeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LineUpH5Object" withDataSource:nil withCellType:IncomeViewCellLineUpH5Object];
        }
            break;
            
        case IncomeViewCellLineUpH5Serve: {
               cell = [[IncomeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LineUpH5Serve" withDataSource:nil withCellType:IncomeViewCellLineUpH5Serve];
        }
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.bottomSeparatorStyle = ATCommonCellSeparatorStyleNone;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return [Theme paddingWithSize20];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}



-(void)createNavigitionHeaderView {
    WS(weakSelf);
    self.naviView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    self.naviView.backgroundColor = [Theme colorForAppearance];
    [[UIApplication sharedApplication].keyWindow addSubview:self.naviView];
    
    self.naviLbael = [[UILabel alloc] initWithFrame:CGRectZero];
    self.naviLbael.text = @"我的收入";
    self.naviLbael.textColor = [UIColor whiteColor];
    self.naviLbael.font = [Theme fontWithSize36];
    self.naviLbael.textAlignment = NSTextAlignmentCenter;
    [self.naviView addSubview:self.naviLbael];
    [self.naviLbael mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(weakSelf.naviView);
        make.bottom.equalTo(weakSelf.naviView).offset(-[Theme paddingWithSize24]);
    }];
    

   
    
    self.headerView = [[NavigitionHeaderView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, [Theme paddingWithSize:200]) withTitles:@[@"今天",@"昨天",@"近7天"]withViewType:NaviHeaderViewIncome];
    self.headerView.isHideLine = NO;
    self.headerView.backgroundColor = [UIColor whiteColor];
    self.checkInDateStr =  [[NSDate date] stringForYearMonthDayDashed];
    
    self.checkOutDateStr =  [[NSDate date] stringForYearMonthDayDashed];
    
    self.headerView.calendarTitle = [NSString stringWithFormat:@"%@至%@",self.checkInDateStr,self.checkOutDateStr];
    
    [self.headerView upDateView];
    
   // [[UIApplication sharedApplication].keyWindow addSubview:self.headerView];
    
    [[UIApplication sharedApplication].keyWindow insertSubview:self.headerView belowSubview:self.naviView];
    

    self.headerView.selectAtIndexBlock = ^(NaviHeaderViewButtonType indexType, BOOL isSelected) {
        
        weakSelf.headerButtonType = indexType;
        switch (indexType) {
            case NaviHeaderViewButtonCalendar: {
                if (isSelected) {
                    //创建日历
                    weakSelf.calendarView = [[CalendarView alloc] initWithFrame:CGRectMake(0,[Theme paddingWithSize:200] + 64, kScreenWidth, kScreenHeight - [Theme paddingWithSize:200] - 64)];
                    weakSelf.calendarView.origin = CGPointMake(0, [Theme paddingWithSize:200] + 64);
                    weakSelf.calendarView.confirmDateButton = ^(NSString *checkInDate, NSString *checkOutDate) {
                        
                        weakSelf.headerView.calendarButton.selected = NO;
                        //更改button内容
                        weakSelf.checkInDateStr = checkInDate;
                        weakSelf.checkOutDateStr = checkOutDate;
                        weakSelf.headerView.calendarTitle = [NSString stringWithFormat:@"%@至%@",weakSelf.checkInDateStr,weakSelf.checkOutDateStr];
                        [weakSelf.headerView upDateView];
                       // [weakSelf loadDataSource];
                        
                    };
                    
                    [[UIApplication sharedApplication].keyWindow insertSubview:weakSelf.calendarView belowSubview:weakSelf.headerView];
                    
                    
                    weakSelf.calendarView.checkInDate = [NSDate at_dateFromString:weakSelf.checkInDateStr];
                    weakSelf.calendarView.checkOutDate  = [NSDate at_dateFromString:weakSelf.checkOutDateStr];
                    
                    [weakSelf.calendarView showCalendarView];
                    
                } else {
                    
                    [weakSelf.calendarView dismissCalendarView];
                    
                }
            }
                break;
                
            case NaviHeaderViewButtonToday: {
                weakSelf.checkInDateStr =  [[NSDate date] stringForYearMonthDayDashed];
                weakSelf.checkOutDateStr =  [[NSDate date] stringForYearMonthDayDashed];
                weakSelf.headerView.calendarTitle = [NSString stringWithFormat:@"%@至%@",weakSelf.checkInDateStr,weakSelf.checkOutDateStr];
                
                [weakSelf.headerView upDateView];
                
                weakSelf.headerView.calendarButton.selected = NO;
                [weakSelf.calendarView dismissCalendarView];
               // [weakSelf loadDataSource];
                
            }
                
                break;
                
            case NaviHeaderViewButtontYesterday: {
                
                NSDate *lastDay = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:[NSDate date] ];//前一天
                weakSelf.checkInDateStr =  [lastDay stringForYearMonthDayDashed];
                weakSelf.checkOutDateStr = [lastDay stringForYearMonthDayDashed];
                weakSelf.headerView.calendarTitle = [NSString stringWithFormat:@"%@至%@",weakSelf.checkInDateStr,weakSelf.checkOutDateStr];
                
                [weakSelf.headerView upDateView];
                weakSelf.headerView.calendarButton.selected = NO;
                [weakSelf.calendarView dismissCalendarView];
                //[weakSelf loadDataSource];
                
                
            }
                
                break;
                
            case NaviHeaderViewButtontSevenDay: {
                
                NSDate *lastSevenDay = [NSDate dateWithTimeInterval:-24*60*60*7 sinceDate:[NSDate date] ];//前7天
                NSDate *lastDay = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:[NSDate date] ];//前一天
                
                weakSelf.checkInDateStr =  [lastSevenDay stringForYearMonthDayDashed];
                weakSelf.checkOutDateStr = [lastDay stringForYearMonthDayDashed];
                weakSelf.headerView.calendarTitle = [NSString stringWithFormat:@"%@至%@",weakSelf.checkInDateStr,weakSelf.checkOutDateStr];
                [weakSelf.headerView upDateView];
                
                
                weakSelf.headerView.calendarButton.selected = NO;
                [weakSelf.calendarView dismissCalendarView];
              //  [weakSelf loadDataSource];
                
                
            }
                
                break;
                
        }
        
    };
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.headerView.hidden = NO;
    self.naviView.hidden =NO;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.headerView.hidden = YES;
    self.naviView.hidden = YES;
    
}

@end
