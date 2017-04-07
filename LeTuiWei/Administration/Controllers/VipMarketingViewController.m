//
//  VipMarketingViewController.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/6.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "VipMarketingViewController.h"
#import "VipMarketingViewCell.h"
#import "SelectPaymentTypeViewController.h"

@interface VipMarketingViewController ()<UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, strong) UITableView *tableView;

@end

@implementation VipMarketingViewController

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
    
    return 3;
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
        NSArray *dataArray = @[@"会员营销",@"通过门店派智能收银设备，以支付即会员积累客流，并根据消费商品数据分析，进行精准会员营销，提高客单价和复购率"];
        cell = [[VipMarketingViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"titleSection" withDataSource:dataArray cellType:VipMarketingViewCellTypeTitle];
        cell.immediateOpeningButtonBlock = ^(){
            
            SelectPaymentTypeViewController *paymentType = [[SelectPaymentTypeViewController alloc] init];
            [weakSelf.navigationController pushViewController:paymentType animated:YES];
        };

    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell = [[VipMarketingViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"itemTitle" withDataSource:@"下单功能" cellType:VipMarketingViewCellTypeItemTitle];

        } else {
            cell = [[VipMarketingViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"itemTitle" withDataSource:nil cellType:VipMarketingViewCellTypeSingleFunction];
        
        }
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            cell = [[VipMarketingViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"itemTitle" withDataSource:@"会员系统" cellType:VipMarketingViewCellTypeItemTitle];
            
        } else {
            cell = [[VipMarketingViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"itemTitle" withDataSource:nil cellType:VipMarketingViewCellTypeVipSystem];
            
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
