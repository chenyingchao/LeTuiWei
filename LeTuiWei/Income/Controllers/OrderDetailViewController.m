//
//  OrderDetailViewController.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/26.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderDetailViewCell.h"
@interface OrderDetailViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation OrderDetailViewController

- (void)loadView {
    [super loadView];
    [self creatTableView];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"详情";
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
        make.left.right.bottom.top.equalTo(weakSelf.view);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 3;
    }
    
    return 1;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OrderDetailViewCell *cell = nil;
    switch (indexPath.section) {
        case 0: {
            switch (indexPath.row) {
                case 0: {
                
                    cell = [[OrderDetailViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell" withDataSource:nil withCellType:OrderDetailViewCellTypeOrderNumber];
                }
                    
                    break;
                    
                case 1: {
                   cell = [[OrderDetailViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell" withDataSource:nil withCellType:OrderDetailViewCellTypeOrderProduct];
                }
                    break;
                    
                case 2: {
                    cell = [[OrderDetailViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell" withDataSource:nil withCellType:OrderDetailViewCellTypeOrderMoney];
                
                }
                    
                    break;
                    
            }

        }
            
            break;
            
        case 1:{
        
            cell = [[OrderDetailViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell" withDataSource:nil withCellType:OrderDetailViewCellTypeSecondSection];
        
        }
            break;
    }
    
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



@end
