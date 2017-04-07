//
//  StoreAccountManagerViewController.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/1.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "StoreAccountManagerViewController.h"
#import "ConfirmButtonView.h"
#import "StoreAccountManagerViewCell.h"
#import "SelectAccountViewController.h"
#import "UnfoldTabView.h"
#import "VipMarketingViewController.h"
#import "PlatformOrderTakingViewController.h"

@interface StoreAccountManagerViewController ()<UITableViewDataSource, UITableViewDelegate, UnfoldTableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UnfoldTabView *unfoldTabView;

@end

@implementation StoreAccountManagerViewController

- (void)loadView {
    [super loadView];
    [self creatTableView];
    [self creatBottomView];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"门店派账号管理";
    self.storeName = @"常营三兄弟";
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

- (void)creatBottomView {
    WS(weakSelf);
    ConfirmButtonView *submitView = [ConfirmButtonView confirmButtonViewWithTitle:@"添加门店派账号" andButtonClickedBlock:^(UIButton *button) {
      
    }];
    [self.view addSubview:submitView];
    [submitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.tableView.mas_bottom);
        
    }];
    
}

#pragma mark -- tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 2;
    } else if (section == 2) {
    
        return 2;
    } else if (section == 3) {
    
        return 4;
    }
    
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
        StoreAccountManagerViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.unfoldButton.selected = !cell.unfoldButton.selected;
        if (cell.unfoldButton.selected) {
            _unfoldTabView = [[UnfoldTabView alloc] initWithDataSource:self andHeight:kScreenHeight - 64 - [Theme paddingWithSize:86]];
            _unfoldTabView.dismissBlock = ^ {
                cell.unfoldButton.selected = !cell.unfoldButton.selected;
            };
            [self.unfoldTabView show];
        } else {
            [self.unfoldTabView dismiss];
        
        }
    }

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
     [self.unfoldTabView dismiss];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WS(weakSelf);
    StoreAccountManagerViewCell *cell = nil;
    switch (indexPath.section) {
        case 0: {
        
            cell = [[StoreAccountManagerViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"storeName" withDataSource:self.storeName cellType:AccountManagerCellTypeStoreName];
        }
            
            break;
            
        case 1:
            switch (indexPath.row) {
                case 0: {
                 cell = [[StoreAccountManagerViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"account" withDataSource:@"xxxx店" cellType:AccountManagerCellTypeAccount];
                    cell.changeButtonClickedBlock = ^(AccountManagerCellType type){
                        if (type == AccountManagerCellTypeAccount) {
                            SelectAccountViewController *selectAccountVC = [[SelectAccountViewController alloc] init];
                            [weakSelf.navigationController pushViewController:selectAccountVC animated:YES];
                        }

                
                    };
                }
                    break;
                    
                case 1: {
                    cell = [[StoreAccountManagerViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"password" withDataSource:@"xxxx店" cellType:AccountManagerCellTypePassword];
                    cell.changeButtonClickedBlock = ^(AccountManagerCellType type){
                        if (type == AccountManagerCellTypePassword) {
                            NSLog(@"修改密码");
                        }
                        
                        
                    };
                    
                }

                    break;
                    return cell;
            }
            
            break;
        case 2: {
            
            switch (indexPath.row) {
                case 0: {
                    cell = [[StoreAccountManagerViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Marketing" withDataSource:@"xxxx店" cellType:AccountManagerCellTypeMarketing];
                    cell.openButtonClickedBlock = ^(AccountManagerCellType type){
                        if (type == AccountManagerCellTypeMarketing) {
                            VipMarketingViewController *vipMarketingVC = [[VipMarketingViewController alloc] init];
                            [weakSelf.navigationController pushViewController:vipMarketingVC animated:YES];
                        }
                        
                        
                    };
                }
                    
                    break;
                case 1: {
                      cell = [[StoreAccountManagerViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OrderTaking" withDataSource:@"xxxx店" cellType:AccountManagerCellTypeOrderTaking];
                    cell.openButtonClickedBlock = ^(AccountManagerCellType type){
                        if (type == AccountManagerCellTypeOrderTaking) {
                            PlatformOrderTakingViewController *platformOrderTakingVC = [[PlatformOrderTakingViewController alloc] init];
                            [weakSelf.navigationController pushViewController:platformOrderTakingVC animated:YES];
                        }
                        
                        
                    };
                
                }
        
                    break;
            }
        }
            
            break;
        case 3: {
            NSArray *dataArray = @[@{@"title": @"收银",@"content":@"可在收银端直接收银"}, @{@"title": @"H5服务",@"content":@"可在收银端直接收银"}, @{@"title": @"打印配置",@"content":@"可在收银端直接收银"}, @{@"title": @"订单统计",@"content":@"可在收银端直接收银"}];
            cell = [[StoreAccountManagerViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"storeName" withDataSource:dataArray[indexPath.row] cellType:AccountManagerCellTypeBasicFunction];
        }
            
            break;

    }
   
    
    
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return CGFLOAT_MIN;
    }
    
    return [Theme paddingWithSize:76];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, [Theme paddingWithSize:76])];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake([Theme paddingWithSize:32], 0, kScreenWidth, [Theme paddingWithSize:76])];
    [bgView addSubview:titleLable];
    titleLable.font = [Theme fontWithSize24];
    titleLable.textColor = [Theme colorDimGray];
    if (section  == 1) {
        titleLable.text = @"本门店已经创建三个账号";
        
    } else if (section == 2) {
        titleLable.text = @"该账号的付费功能，需开通后使用";
    } else if (section == 3) {
        titleLable.text = @"以下为该账号的基础版功能，免费且永久有效";
    }
    
    return bgView;

}


#pragma mark  弹出窗的协议

- (void)dataForRowAtIndexPath:(id)data didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"~~%@",data);
    self.storeName = data;
    [self.tableView reloadData];
}

- (NSInteger)numberOfRowsInOrderDetailsView {
    return 3;
}

- (id)dataForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *title= nil;
    switch (indexPath.row) {
        case 0: {
            title = @"11111";
            
        }
            break;
            
        case 1: {
            title = @"22222";
        }
            break;
            
        default: {
            title = @"33333";
            
        }
            
            break;
    }
    
    return title;
}

@end
