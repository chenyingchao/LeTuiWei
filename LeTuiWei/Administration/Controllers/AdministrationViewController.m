//
//  AdministrationViewController.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/3/28.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "AdministrationViewController.h"
#import "AdministrationViewCell.h"
#import "AdministrationViewModel.h"
#import "ModifyCodeViewController.h"
#import "CustomAlertView.h"
#import "UserLoginViewController.h"
#import "BaseNavigationController.h"
#import "AddStoresViewController.h"
#import "StoresListViewController.h"
#import "addStoreAccountViewController.h"
#import "StoreAccountManagerViewController.h"
@interface AdministrationViewController ()<UITableViewDataSource, UITableViewDelegate, AlertViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *headSectionArray;

@property (nonatomic, strong) NSMutableArray *midSectionArray;

@property (nonatomic, strong) NSMutableArray *footerSectionArray;

@property (nonatomic, strong) CustomAlertView *customAlertView;

@property (nonatomic, assign) BOOL isStore;

@property (nonatomic, assign) BOOL isStoreAccount;

@end

@implementation AdministrationViewController

- (void)loadView {
    [super loadView];
    [self creatTableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"管理";
    [self dataSource];
}

- (void)dataSource {
    
    AdministrationViewModel *model = [[AdministrationViewModel alloc] init];
    model.headerImage = @"head";
    model.headerTitle = @"18500106505";
    model.rightLabel = @"修改密码";
    [self.headSectionArray addObject:model];
    
    NSArray *midImageArray = @[@"guanlistore",@"id",@"product"];
    NSArray *mideTitleArray = @[@"门店管理",@"门店派账号",@"门店派设备"];
    
    for (NSInteger i = 0; i < mideTitleArray.count; i++) {
        AdministrationViewModel *model = [[AdministrationViewModel alloc] init];
        model.headerImage = midImageArray[i];
        model.headerTitle = mideTitleArray[i];
        model.rightLabel = @"";
        [self.midSectionArray addObject:model];
    }
    
    NSArray *footerImageArray = @[@"update",@"exit"];
    NSArray *footerTitleArray = @[@"检测更新",@"退出账号"];
    
    for (NSInteger i = 0; i < footerTitleArray.count; i++) {
        AdministrationViewModel *model = [[AdministrationViewModel alloc] init];
        model.headerImage = footerImageArray[i];
        model.headerTitle = footerTitleArray[i];
        if ([footerTitleArray[i] isEqualToString:@"检测更新"]) {
     
             model.rightLabel = [NSString stringWithFormat:@"v%@",APP_Version];
        } else {
             model.rightLabel = @"";
        }
       
        [self.footerSectionArray addObject:model];
    }

    [_tableView reloadData];
}

- (void)creatTableView {
    WS(weakSelf);
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   
    [self.view addSubview:_tableView];
    [_tableView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
}

#pragma mark -- tableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [Theme paddingWithSize:126];
    }
    return [Theme paddingWithSize100];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return self.headSectionArray.count;
    } else if (section == 1) {
        return self.midSectionArray.count;
    } else if (section == 2){
    
        return self.footerSectionArray.count; 
    }
    
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
  
        ModifyCodeViewController *modifyCodeVC = [[ModifyCodeViewController alloc] init];
        [self.navigationController pushViewController:modifyCodeVC animated:YES];
    }

    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            //判断是否有门店
            _isStore = YES;
            if (_isStore) {
                StoresListViewController *storelistVC = [[StoresListViewController alloc] init];
                [self.navigationController pushViewController:storelistVC animated:YES];
                
            } else {
                
                AddStoresViewController *addStoresVC = [[AddStoresViewController alloc] init];
                [self.navigationController pushViewController:addStoresVC animated:YES];
            }
           
        } else if (indexPath.row == 1) {
          _isStore = YES;
            _isStoreAccount = YES;
            if (_isStore) {
                
                if (_isStoreAccount) {
                    //如果有账号  取选择门店
                    [self.customAlertView showAlertView:@"请选择添加账号的门店" withDataScoure:@[@"常营三兄弟店", @"金老三店", @"海天一色店", @"xxxxx店", @"阿斯达所店"]];
                    
                    
                } else {
                
                  [self.customAlertView showAlertView:@"此处添加的账号需要在“门店派”收银机上登录使用，请确保您已经购买了“门店派”收银机" withType:AlertViewTypeAddAccount];
                }
       
            } else {
            
                AddStoresViewController *addStoresVC = [[AddStoresViewController alloc] init];
                [self.navigationController pushViewController:addStoresVC animated:YES];
            }
            
          
        }
        

    }
    
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            
            if ([APP_Version floatValue] < 1) {
            [self.customAlertView showAlertView:@"确定要升级吗" withType:AlertViewTypeCommon];
            } else {
            [self.customAlertView showAlertView:@"已是最新版本" withType:AlertViewTypeIKnow];
            }
    
        }
        
        if (indexPath.row == 1) {
            [self.customAlertView showAlertView:@"您确定要退出账号吗？" withType:AlertViewTypeCommon];
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    AdministrationViewCell *cell = nil;
    
    if (indexPath.section == 0) {
        cell = [[AdministrationViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell" withDataSource:self.headSectionArray[indexPath.row] withCellType:AdministrationViewCellTypeRightLabel];
        
    } else if (indexPath.section == 1) {
          cell = [[AdministrationViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell" withDataSource:self.midSectionArray[indexPath.row] withCellType:AdministrationViewCellTypeRightLabel];
    
    } else if (indexPath.section == 2) {
         cell = [[AdministrationViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell" withDataSource:self.footerSectionArray[indexPath.row] withCellType:AdministrationViewCellTypeRightLabel];
    
    }
    
    return cell;;
    
}

#pragma mark 弹窗确定按钮 协议
- (void)requestEventAction:(UIButton *)button withAlertTitle:(NSString *)title {
    if ([title isEqualToString:@"确定要升级吗"]) {
        //跳转去升级
    }
    
    if ([title isEqualToString:@"您确定要退出账号吗？"]) {
        
        UserLoginViewController *loginVC = [[UserLoginViewController alloc] init];
        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:nav animated:YES completion:nil];
        
    }
    
    if ([title isEqualToString:@"此处添加的账号需要在“门店派”收银机上登录使用，请确保您已经购买了“门店派”收银机"]) {
        if ([button.titleLabel.text isEqualToString:@"知道了，我已购买"]) {
            addStoreAccountViewController *addStoreAccountVC = [[addStoreAccountViewController alloc] init];
            [self.navigationController pushViewController:addStoreAccountVC animated:YES];
        } else if ([button.titleLabel.text isEqualToString:@"未购买，点击了解门派店收银机"]) {
            NSLog(@"未购买，点击了解门派店收银机");
        }
    }
}

- (void)alertView:(CustomAlertView *)alertView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSLog(@"%ld", (long)indexPath.row);
    StoreAccountManagerViewController *accountManagerVC = [[StoreAccountManagerViewController    alloc] init];
    [self.navigationController pushViewController:accountManagerVC animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return CGFLOAT_MIN;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return [Theme paddingWithSize40];
}



- (NSMutableArray *)headSectionArray {
    
    if (!_headSectionArray) {
        _headSectionArray = [[NSMutableArray alloc] init];
    }
    
    return _headSectionArray;
}

- (NSMutableArray *)midSectionArray {
    
    if (!_midSectionArray) {
        _midSectionArray = [[NSMutableArray alloc] init];
    }
    
    return _midSectionArray;
}

- (NSMutableArray *)footerSectionArray {
    
    if (!_footerSectionArray) {
        _footerSectionArray = [[NSMutableArray alloc] init];
    }
    
    return _footerSectionArray;
}

- (CustomAlertView *)customAlertView {
    if (!_customAlertView) {
        _customAlertView = [[CustomAlertView alloc] initWithFrame:CGRectMake([Theme paddingWithSize100], 200, [UIScreen mainScreen].bounds.size.width - [Theme paddingWithSize100] * 2,[Theme paddingWithSize:300])];
        
        
        _customAlertView.backgroundColor = [UIColor whiteColor];
        _customAlertView.delegate = self;
    }

    return _customAlertView;
}

@end
