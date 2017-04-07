//
//  PlatformOrderTakingViewController.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/6.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "PlatformOrderTakingViewController.h"
#import "SelectPaymentTypeViewController.h"
#import "VipMarketingViewCell.h"
#import "SelectPaymentTypeViewController.h"
@interface PlatformOrderTakingViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation PlatformOrderTakingViewController
#pragma mark  多平台接单详情
- (void)loadView {
    [super loadView];
    [self creatTableView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"详情介绍";
}

- (void)creatTableView {
    WS(weakSelf);
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight = 150;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_tableView];
    [_tableView  mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.right.bottom.equalTo(weakSelf.view);
        
    }];
}

#pragma mark -- tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    
    return 2;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WS(weakSelf);
    VipMarketingViewCell *cell = nil;
    
    if (indexPath.section == 0) {
        
        NSArray *dataArray = @[@"外卖多平台接单",@"对接饿了么、百度、美团外卖平台，自动接单打印。解决商户在收银机中使用外卖多平台软件时需要多个软件相互切换，不方便且容易丢单的问题。\n\n注:依据百度外卖平台政策，对接百度外卖时需要商户本身为知名品牌，或者大型连锁企业，否则仅可对接美团及饿了么，但百度外卖客户端可在门店运行时在后台自动接单，并不影响使用。"];
        cell = [[VipMarketingViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"titleSection" withDataSource:dataArray cellType:VipMarketingViewCellTypeTitle];
        cell.immediateOpeningButtonBlock = ^(){
            
            SelectPaymentTypeViewController *paymentType = [[SelectPaymentTypeViewController alloc] init];
            [weakSelf.navigationController pushViewController:paymentType animated:YES];
        };
        
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell = [[VipMarketingViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"itemTitle" withDataSource:@"功能图片" cellType:VipMarketingViewCellTypeItemTitle];
            
        } else {
            cell = [[VipMarketingViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"itemTitle" withDataSource:nil cellType:VipMarketingViewCellTypeFunctionImages];
            
        }
    }
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return [Theme paddingWithSize20];
}


@end
