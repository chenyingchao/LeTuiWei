//
//  DataChartViewController.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/26.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "DataChartViewController.h"
#import "IncomeHeaderView.h"
#import "CalendarView.h"
#import "SiftView.h"
#import "DataChartViewCell.h"
#import "AddStoreMaskView.h"
#import "AddStoresViewController.h"
@interface DataChartViewController ()<UITableViewDataSource, UITableViewDelegate, SiftViewDelegate,IncomeHeaderViewDelegate,CalendarViewDelegate>
@property (nonatomic, strong) CalendarView *calendarView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) IncomeHeaderView *incomeHeaderView;

@property (nonatomic, strong) SiftView *siftView;

@property (nonatomic, strong) UIView *naviView;

@property (nonatomic, strong) UILabel *naviLbael;

@property (nonatomic, strong) NSArray *siftDataSource;

@property (nonatomic, copy) NSString *checkInDateStr;

@property (nonatomic, copy) NSString *checkOutDateStr;

@end

@implementation DataChartViewController

- (void)loadView {
    [super loadView];
    [self createHeaderView];
    [self creatTableView];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.edgesForExtendedLayout=UIRectEdgeNone;

}

- (void)creatTableView {
    WS(weakSelf);
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [Theme colorForAppBackground];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.estimatedRowHeight = 200;
    
    [self.view addSubview:_tableView];
    [self.view sendSubviewToBack:_tableView];
    [_tableView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view).offset(CGRectGetMaxY(weakSelf.siftView.frame));
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WS(weakSelf);
    DataChartViewCell *cell = nil;
    
    switch (indexPath.section) {
        

            
        case 0: {
            cell = [[DataChartViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OrderMoneyStatistics" withDataSource:nil withCellType:DataChartViewCellTypeTrendChart];
        }
            
            break;
            
            
        case 1: {
            cell = [[DataChartViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ProductTop5" withDataSource:@"123" withCellType:DataChartViewCellTypeTop5];
            
            cell.segmentIndexBlock = ^(NSInteger index) {
                //按 self.tabBarController.tabBar.hidden = YES;
                if (index == 0) {
                    NSLog(@"按销量");
                } else { //按销售额
                    NSLog(@"按销售额");
                    
                }
                
                
            };
            //开通智慧门店
            cell.openWisdomStoreBlock = ^() {
                AddStoreMaskView *addStoreMaskView = [[AddStoreMaskView alloc] initWithFrame:CGRectMake([Theme paddingWithSize:90], [Theme paddingWithSize:220], kScreenWidth - 2 * [Theme paddingWithSize:90], [Theme paddingWithSize:700])];
                
                [addStoreMaskView showView];
                addStoreMaskView.addStoreButtonBlock = ^(UIButton *button) {
                    
                    AddStoresViewController *addStoreVC = [[AddStoresViewController alloc] init];
                    [weakSelf.navigationController pushViewController:addStoreVC animated:YES];
                    
                };
                
            };
        }
            
            break;
            
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.bottomSeparatorStyle = ATCommonCellSeparatorStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return [Theme paddingWithSize20];
    }
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}


-(void)createHeaderView {
    WS(weakSelf);
    
    self.naviView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    self.naviView.backgroundColor = [Theme colorForAppearance];
    [ATKeyWindow addSubview:self.naviView];
    
    self.naviLbael = [[UILabel alloc] initWithFrame:CGRectZero];
    self.naviLbael.text = @"数据图表";
    self.naviLbael.textColor = [UIColor whiteColor];
    self.naviLbael.font = [Theme fontWithSize36];
    self.naviLbael.textAlignment = NSTextAlignmentCenter;
    [self.naviView addSubview:self.naviLbael];
    [self.naviLbael mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(weakSelf.naviView);
        make.bottom.equalTo(weakSelf.naviView).offset(-[Theme paddingWithSize24]);
    }];
    
    UIView *leftContainerView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 44, 44)];
    [self.naviView addSubview:leftContainerView];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftContainerView addSubview:backBtn];
    
    [backBtn setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"return"] forState:UIControlStateHighlighted];
    [backBtn setImage:[UIImage imageNamed:@"return"] forState:UIControlStateSelected];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(leftContainerView);
    }];
    
 
    [backBtn bk_whenTapped:^{
        [weakSelf leftbarbuttonAction];
    }];

    
    
    self.checkInDateStr =  [[NSDate date] stringForYearMonthDayDashed];
    self.checkOutDateStr =  [[NSDate date] stringForYearMonthDayDashed];
    
    self.incomeHeaderView = [[IncomeHeaderView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, [Theme paddingWithSize:238]) isOpenWisdomStorm:YES storeQuantity:1];
    self.incomeHeaderView.incomeHeaderViewDelegate = self;
    self.incomeHeaderView.calendarTitle = [NSString stringWithFormat:@"%@至%@",self.checkInDateStr,self.checkOutDateStr];
    [ATKeyWindow insertSubview:self.incomeHeaderView belowSubview: self.naviView];
    
    
    self.siftView = [[SiftView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.incomeHeaderView.frame), kScreenWidth, [Theme paddingWithSize:84]) storeQuantity:2];
    
    self.siftView.siftDelegate = self;
    [ATKeyWindow insertSubview:self.siftView belowSubview: self.incomeHeaderView];
    
}

#pragma mark incomeHeaderView delegate

- (void)incomeHeaderView:(IncomeHeaderView *)headerView didSelectCalendarButton:(UIButton *)button buttonStatus:(BOOL)selected {
    CGFloat calendarHight = kScreenHeight - CGRectGetMaxY(self.incomeHeaderView.frame);
    if (selected) {
        //创建日历
        self.calendarView = [[CalendarView alloc] initWithFrame:CGRectMake(0,1, kScreenWidth, calendarHight)];
        self.calendarView.origin = CGPointMake(0,  CGRectGetMaxY(self.incomeHeaderView.frame));
        
        [ATKeyWindow insertSubview:self.calendarView belowSubview: self.incomeHeaderView];
        self.calendarView.calendarViewDelegate = self;
        self.calendarView.checkInDate = [NSDate at_dateFromString:[[NSDate date] stringForYearMonthDayDashed]];
        self.calendarView.checkOutDate  = [NSDate at_dateFromString:[[NSDate date] stringForYearMonthDayDashed]];
        
        [self.calendarView showCalendarView];
        
    } else {
        
        [self.calendarView dismissCalendarView];
        
    }
    
    
    
}
#pragma mark 日历delegate

- (void)calendarView:(CalendarView *)calendarView comfirmDidSelectedCheckInDate:(NSString *)checkInDate checkOutDate:(NSString *)checkOutDate {
    self.checkInDateStr = checkInDate;
    self.checkOutDateStr = checkOutDate;
    self.incomeHeaderView.calendarTitle = [NSString stringWithFormat:@"%@至%@",self.checkInDateStr,self.checkOutDateStr];
    self.incomeHeaderView.calendarButton.selected = NO;
    
    
}


#pragma mark siftView delegate
//当选择筛选条件时 为tabview 加载数据
- (void)siftView:(SiftView *)siftView didSelectedButtonType:(SiftViewButtonType)type buttonStatus:(BOOL)selected {
    
    if (!selected) {
        return ;
    }
    
    switch (type) {
        case SiftViewButtonTypeAllStores: {
            self.siftDataSource = @[@"全部门店",@"东单点",@"西单店",@"南单点",@"背单点"];
        }
            
            break;
        case SiftViewButtonTypeAllIncome: {
            self.siftDataSource = nil;
        }
            
            break;
        case SiftViewButtonTypeAllChannel: {
            self.siftDataSource = @[@"全部渠道",@"微信",@"支付宝",@"刷卡",@"现金",@"现金1",@"现金2",@"现金三"];
        }
            
            break;
        case SiftViewButtonTypeAllTool: {
            self.siftDataSource = @[@"全部工具",@"收银机",@"二维码"];
        }
            
            break;
            
    }
    
    [self.siftView.tableView reloadData];
    
}

//筛选条件
- (void)siftView:(SiftView *)siftView didSelectedData:(NSArray *)data {
    
    for (NSString *str in data) {
        NSLog(@"筛选条件    %@", str);
    }
    
}

- (NSInteger)numberOfRowsInOrderDetailsView {
    return self.siftDataSource.count;
}

- (NSString *)dataForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *str = nil;
    
    str = self.siftDataSource[indexPath.row];
    
    return str;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.incomeHeaderView.hidden = NO;
    self.naviView.hidden =NO;
    self.siftView.hidden = NO;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.incomeHeaderView.hidden = YES;
    self.naviView.hidden = YES;
    self.siftView.hidden = YES;
    
}

- (void)leftbarbuttonAction {
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
