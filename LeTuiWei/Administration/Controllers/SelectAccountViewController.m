//
//  SelectAccountViewController.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/5.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "SelectAccountViewController.h"
#import "SelectAccountViewCell.h"
@interface SelectAccountViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SelectAccountViewController

- (void)loadView {
    [super loadView];
    
    [self creatTableView];

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"选择账号";
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

#pragma mark -- tableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return [Theme paddingWithSize:136];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController popViewControllerAnimated:YES];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    
    SelectAccountViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"account"];
    if (!cell) {
        cell = [[SelectAccountViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"account"];
        
    }
    cell.accountValueLabel.text = @"1234567";
    cell.passwordValueLabel.text = @"11111";
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

@end
