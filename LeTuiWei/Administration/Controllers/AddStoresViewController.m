//
//  AddStoresViewController.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/3/30.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "AddStoresViewController.h"
#import "AddStoresViewCell.h"
#import "ConfirmButtonView.h"
#import "CustomPickerView.h"
@interface AddStoresViewController ()<UITableViewDataSource, UITableViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, strong) CustomPickerView *pickerView;


@end

@implementation AddStoresViewController

- (void)loadView {
    [super loadView];
    [self creatTableView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"添加门店";
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
    tap.delegate = self;
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
}

- (void)submitStoreInfo {


}

- (void)creatTableView {
    WS(weakSelf);
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [Theme colorForAppBackground];
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
    
    return [Theme paddingWithSize:96];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.titleArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSLog(@"点击");
    if (indexPath.row == 5) {
        [self.pickerView show];
        WS(weakSelf);
        self.pickerView.determineBtnBlock = ^(NSInteger shengId, NSInteger shiId, NSInteger xianId, NSString *shengName, NSString *shiName, NSString *xianName){
            [weakSelf provinceName:shengName city:shiName county:xianName];
        };

    }
    
}

- (void)provinceName:(NSString *)province city:(NSString *)city county:(NSString *)county {
    NSLog(@"%@   %@   %@", province, city, county);

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AddStoresViewCell *cell = nil;

    switch (indexPath.row) {
        case 0: {
            cell = [[AddStoresViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"storeName"];
            cell.bottomSeparatorStyle = ATCommonCellSeparatorStyleSymmetricalDefault;
            cell.cellTextField.placeholder = @"如国美、麦当劳";
            
        
        }
            
            break;
        case 1: {
            cell = [[AddStoresViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"storeName"];
            cell.bottomSeparatorStyle = ATCommonCellSeparatorStyleSymmetricalDefault;
            cell.cellTextField.placeholder = @"如西单店，将与商户名合并展示";
            
            
        }
            
            break;
            
        case 2: {
            cell = [[AddStoresViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"storeName"];
            cell.bottomSeparatorStyle = ATCommonCellSeparatorStyleSymmetricalDefault;
            cell.cellTextFieldMoney.placeholder = @"请填写";
            
            
        }
            
            break;
            
        case 3: {
            cell = [[AddStoresViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"storeName"];
            cell.bottomSeparatorStyle = ATCommonCellSeparatorStyleSymmetricalDefault;
            cell.cellTextField.placeholder = @"区号-电话，如010-67085435";
            
            
        }
            
            break;
            
        case 4: {
            cell = [[AddStoresViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"storeName"];
            cell.bottomSeparatorStyle = ATCommonCellSeparatorStyleSymmetricalDefault;
            cell.cellContentLabel.text = @"选择";
            
            
        }
            
            break;
            
        case 5: {
            cell = [[AddStoresViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"storeName"];
            cell.bottomSeparatorStyle = ATCommonCellSeparatorStyleSymmetricalDefault;
            cell.cellContentLabel.text = @"选择";
            
            
        }
            
            break;
            
        case 6: {
            cell = [[AddStoresViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"storeName"];
            cell.bottomSeparatorStyle = ATCommonCellSeparatorStyleSymmetricalDefault;
            cell.cellTextField.placeholder = @"请填写";
            
            
        }
            
            break;
        case 7: {
            cell = [[AddStoresViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"storeName"];
            cell.bottomSeparatorStyle = ATCommonCellSeparatorStyleFullLength;
            cell.cellContentLabel.text = @"标记";
            
            
        }
            
            break;

            
    }
    

    cell.cellTitleLabel.text = self.titleArray[indexPath.row];
  
    return cell;;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return [Theme paddingWithSize:100];
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
     return [Theme paddingWithSize:100];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, [Theme paddingWithSize:100])];
    titleLabel.text = @"请完善门店信息";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [Theme fontWithSize32];
    titleLabel.textColor = [Theme colorDarkGray];
    return titleLabel;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    WS(weakSelf);
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, [Theme paddingWithSize:100])];
    
    ConfirmButtonView *submitView = [ConfirmButtonView confirmButtonViewWithTitle:@"提交" andButtonClickedBlock:^(UIButton *button) {
        [weakSelf submitStoreInfo];
    }];
    [bgView addSubview:submitView];
    [submitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView.mas_left).offset([Theme paddingWithSize40]);
        make.right.equalTo(bgView.mas_right).offset(-[Theme paddingWithSize40]);
        make.top.equalTo(bgView.mas_top).offset([Theme paddingWithSize:44]);
        make.height.equalTo(@([Theme paddingWithSize:88]));
    }];

    
    return bgView;

}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [[NSArray alloc] initWithObjects:@"商户名称",@"门店名称",@"人均消费",@"电话",@"经营类目",@"所在区域",@"详细地址",@"门店坐标", nil];
    }
    return _titleArray;
}


#pragma mark - UITapGestureRecognizer Action

- (void)hideKeyboard:(UITapGestureRecognizer *)gesture {
    [self.view endEditing:YES];
}

#pragma mark - UITapGestureRecognizer Delegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return YES;
}

- (CustomPickerView *)pickerView {

    if (!_pickerView) {
        _pickerView = [[CustomPickerView alloc]  init];
    
    }
    
    return _pickerView;
}

@end
