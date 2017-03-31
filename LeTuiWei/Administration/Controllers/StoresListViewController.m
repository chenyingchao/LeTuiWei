//
//  StoresListViewController.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/3/31.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "StoresListViewController.h"
#import "StoresListViewCell.h"
#import "ConfirmButtonView.h"
#import "AddStoresViewController.h"
@interface StoresListViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation StoresListViewController

- (void)loadView {
    [super loadView];
    [self creatTableView];
    [self creatBottomView];
   

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"门店管理";
   
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
  
        make.top.left.right.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view).offset(-[Theme paddingWithSize:96]);
    }];
}

- (void)addNewStore {

    AddStoresViewController *addStoreVC = [[AddStoresViewController alloc] init];
    [self.navigationController pushViewController:addStoreVC animated:YES];
}

- (void)creatBottomView {
    WS(weakSelf);
    ConfirmButtonView *submitView = [ConfirmButtonView confirmButtonViewWithTitle:@"添加新门店" andButtonClickedBlock:^(UIButton *button) {
        [weakSelf addNewStore];
    }];
    [self.view addSubview:submitView];
    [submitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.tableView.mas_bottom);
        
    }];

}

#pragma mark -- tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StoresListViewCell *cell = [[StoresListViewCell alloc] init];
    return cell;

}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [Theme paddingWithSize20];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}



@end
