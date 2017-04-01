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

@interface StoreAccountManagerViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

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
    
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    StoreAccountManagerViewCell *cell = nil;
    switch (indexPath.section) {
        case 0: {
        
            cell = [[StoreAccountManagerViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"storeName" withDataSource:@"xxxx店" cellType:AccountManagerCellTypeStoreName];
        }
            
            break;
            
        case 1:
            switch (indexPath.row) {
                case 0: {
                 cell = [[StoreAccountManagerViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"account" withDataSource:@"xxxx店" cellType:AccountManagerCellTypeAccount];
                
                }
                    
                    break;
                    
                case 1: {
                    cell = [[StoreAccountManagerViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"password" withDataSource:@"xxxx店" cellType:AccountManagerCellTypePassword];
                    
                }

                    break;
                    return cell;
            }
            
            break;
        case 2: {
            
            switch (indexPath.row) {
                case 0: {
                      cell = [[StoreAccountManagerViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Marketing" withDataSource:@"xxxx店" cellType:AccountManagerCellTypeMarketing];
                }
                    
                    break;
                case 1: {
                      cell = [[StoreAccountManagerViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OrderTaking" withDataSource:@"xxxx店" cellType:AccountManagerCellTypeOrderTaking];
                
                }
        
                    break;
            }
        }
            
            break;
        case 3: {
            
            cell = [[StoreAccountManagerViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"storeName" withDataSource:@"xxxx店" cellType:AccountManagerCellTypeStoreName];
        }
            
            break;

    }
   
    
    
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [Theme paddingWithSize20];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}


@end
