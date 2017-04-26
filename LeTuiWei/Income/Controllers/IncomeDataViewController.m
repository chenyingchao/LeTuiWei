//
//  IncomeDataViewController.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/21.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "IncomeDataViewController.h"
#import "IncomeHeaderView.h"
#import "CalendarView.h"
#import "SiftView.h"
#import "IncomeDataViewCell.h"
#import "OrderDetailViewController.h"
#import "DataChartViewController.h"

@interface IncomeDataViewController ()<UITableViewDataSource, UITableViewDelegate, SiftViewDelegate,IncomeHeaderViewDelegate,CalendarViewDelegate>

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

@implementation IncomeDataViewController

- (void)loadView {
    [super loadView];
    [self createHeaderView];
    [self creatTableView];


}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout=UIRectEdgeNone;

    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)createHeaderView {
    WS(weakSelf);
    
    self.naviView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    self.naviView.backgroundColor = [Theme colorForAppearance];
    [ATKeyWindow addSubview:self.naviView];
    
    self.naviLbael = [[UILabel alloc] initWithFrame:CGRectZero];
    self.naviLbael.text = @"收入数据";
    self.naviLbael.textColor = [UIColor whiteColor];
    self.naviLbael.font = [Theme fontWithSize36];
    self.naviLbael.textAlignment = NSTextAlignmentCenter;
    [self.naviView addSubview:self.naviLbael];
    [self.naviLbael mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(weakSelf.naviView);
        make.bottom.equalTo(weakSelf.naviView).offset(-[Theme paddingWithSize24]);
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
    
    
- (void)creatTableView {
    WS(weakSelf);
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [Theme colorForAppBackground];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableHeaderView = [self tabViewHeaderView];
    [self.view addSubview:_tableView];
    [self.view sendSubviewToBack:_tableView];
    [_tableView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view).offset(CGRectGetMaxY(weakSelf.siftView.frame));
    }];
}

- (UIView *)tabViewHeaderView {
    WS(weakSelf);
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, [Theme paddingWithSize:150])];
    view.backgroundColor = UIColorFromRGB(0xe1ebf7);
    UILabel *orderNumLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    orderNumLabel.text = @"共10笔收入";
    orderNumLabel.font = [Theme fontWithSize28];
    orderNumLabel.textColor = [Theme colorForCommentBlue];
    [view addSubview:orderNumLabel];
    [orderNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset([Theme paddingWithSize32]);
        make.top.equalTo(view).offset([Theme paddingWithSize32]);
    }];
    
    UILabel *incomeNumLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    incomeNumLabel.text = @"总收入:21020";
    incomeNumLabel.font = [Theme fontWithSize28];
    incomeNumLabel.textColor = [Theme colorForCommentBlue];
    [view addSubview:incomeNumLabel];
    [incomeNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset([Theme paddingWithSize32]);
        make.top.equalTo(orderNumLabel.mas_bottom).offset([Theme paddingWithSize20]);
    }];
    
    UIButton *dataChartbutton = [[UIButton alloc] init];
    [dataChartbutton setTitle:@"数据图表" forState:UIControlStateNormal];
    [dataChartbutton setImage:[UIImage imageNamed:@"income_arrow"] forState:UIControlStateNormal];
    [dataChartbutton setTitleColor:[Theme colorForCommentBlue] forState:UIControlStateNormal];
    dataChartbutton.titleLabel.font = [Theme fontWithSize28];
    [view addSubview:dataChartbutton];
    [dataChartbutton bk_whenTapped:^{
        DataChartViewController *dataChartVC = [[DataChartViewController alloc] init];
        [weakSelf.navigationController pushViewController:dataChartVC animated:YES];
    }];

    CGSize size = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) textFont: [Theme fontWithSize28] aimString:@"数据图表"];
    dataChartbutton.imageEdgeInsets = UIEdgeInsetsMake(0,size.width + 3, 0, -(size.width + 3));
    dataChartbutton.titleEdgeInsets = UIEdgeInsetsMake(0, -([UIImage imageNamed:@"down"].size.width + 3), 0, [UIImage imageNamed:@"down"].size.width + 3);
    
    [dataChartbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.right.equalTo(view).offset(-[Theme paddingWithSize32]);
        
    }];
    return view;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [Theme paddingWithSize:126];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    OrderDetailViewController *orderDeatilVC = [[OrderDetailViewController alloc] init];
    [self.navigationController pushViewController:orderDeatilVC animated:YES];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    IncomeDataViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderCell"];
    
    if (!cell) {
        cell = [[IncomeDataViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"orderCell"];
    }
    
    switch (indexPath.row) {
        case IncomeDataViewCellTypeHaveProductQuantity:{
        
            [cell  creatCellView:nil withCellType:IncomeDataViewCellTypeHaveProductQuantity];
        }
            
            
            break;
        case IncomeDataViewCellTypeNoProductQuantity:{
            
            [cell  creatCellView:nil withCellType:IncomeDataViewCellTypeNoProductQuantity];
        }
            

            
            break;
        case IncomeDataViewCellTypeVIpTopUp:{
            
            [cell  creatCellView:nil withCellType:IncomeDataViewCellTypeVIpTopUp];
        }
            

            
            break;
            
        default:
            [cell  creatCellView:nil withCellType:IncomeDataViewCellTypeHaveProductQuantity];

            break;
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.bottomSeparatorStyle = ATCommonCellSeparatorStyleSymmetricalDefault;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [Theme paddingWithSize:60];
}

- (UIView  *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, [Theme paddingWithSize:60])];
    
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    dateLabel.font = [Theme fontWithSize24];
    dateLabel.textColor = [Theme colorDimGray];
    [bgView addSubview:dateLabel];
    dateLabel.text = @"2017-12-11";
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset([Theme  paddingWithSize40]);
        make.centerY.equalTo(bgView);
        
    }];
    
    UILabel *totalMoneyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    totalMoneyLabel.font = [Theme fontWithSize24];
    totalMoneyLabel.textColor = [Theme colorDimGray];
    [bgView addSubview:totalMoneyLabel];
    totalMoneyLabel.text = @"收入:￥200000";
    [totalMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgView).offset(-[Theme  paddingWithSize40]);
        make.centerY.equalTo(bgView);
        
    }];
    return bgView;
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

#pragma mark 返回字符串尺寸
- (CGSize)sizeOfStringWithMaxSize:(CGSize)maxSize textFont:(UIFont *)fontSize aimString:(NSString *)aimString{
    
    
    return [[NSString stringWithFormat:@"%@",aimString] boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:fontSize} context:nil].size;
    
}
@end
