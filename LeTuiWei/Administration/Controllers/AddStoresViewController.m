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
#import "AddStoresViewModel.h"
#import "StoreCoordinateViewController.h"
#import <TPKeyboardAvoidingTableView.h>
@interface AddStoresViewController ()<UITableViewDataSource, UITableViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) TPKeyboardAvoidingTableView *tableView;

@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, strong) CustomPickerView *pickerView;

@property (nonatomic, strong) AddStoresViewModel *storeModel;


@end

@implementation AddStoresViewController

- (void)loadView {
    [super loadView];
    [self creatTableView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"添加门店";
    self.storeModel = [[AddStoresViewModel   alloc] init];
    
}

#pragma mark 提交门店信息
- (void)submitStoreInfo {


}

- (void)creatTableView {
    WS(weakSelf);
    _tableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
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


    
    switch (indexPath.row) {
        case 5: {
           
            [self.pickerView show];
            WS(weakSelf);
            self.pickerView.determineBtnBlock = ^(NSInteger shengId, NSInteger shiId, NSInteger xianId, NSString *shengName, NSString *shiName, NSString *xianName){
                [weakSelf provinceName:shengName city:shiName county:xianName];
            };
        
        }
            
            break;
        case 7: {
            StoreCoordinateViewController *storeCoordinateVC = [[StoreCoordinateViewController alloc] init];
            storeCoordinateVC.storeLocationBlock = ^(CLLocationCoordinate2D storeCoordinate) {
                NSLog(@"%f  %f", storeCoordinate.latitude , storeCoordinate.longitude);
            
            };
            [self.navigationController pushViewController:storeCoordinateVC animated:YES];
            
        
        }
            break;
        default:
            break;
    }
    
    
}

- (void)provinceName:(NSString *)province city:(NSString *)city county:(NSString *)county {
    NSLog(@"%@   %@   %@", province, city, county);
    
    self.storeModel.storeArea = [NSString stringWithFormat:@"%@ %@ %@", province, city, county];
    [self.tableView reloadData];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WS(weakSelf);
    AddStoresViewCell *cell = nil;

    switch (indexPath.row) {
        case 0: {
            cell = [[AddStoresViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"productName"];
            cell.bottomSeparatorStyle = ATCommonCellSeparatorStyleSymmetricalDefault;
            cell.cellTextField.placeholder = @"如国美、麦当劳";
            cell.cellTextField.text = self.storeModel.MerchantName;
            cell.cellTextField.bk_didEndEditingBlock = ^(UITextField *textField) {
                weakSelf.storeModel.MerchantName = textField.text;
            };
        
        }
            
            break;
        case 1: {
            cell = [[AddStoresViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"storeName"];
            cell.bottomSeparatorStyle = ATCommonCellSeparatorStyleSymmetricalDefault;
            cell.cellTextField.placeholder = @"如西单店，将与商户名合并展示";
            cell.cellTextField.text = self.storeModel.storeName;
            cell.cellTextField.bk_didEndEditingBlock = ^(UITextField *textField) {
                weakSelf.storeModel.storeName = textField.text;
            };
            
        }
            
            break;
            
        case 2: {
            cell = [[AddStoresViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"money"];
            cell.bottomSeparatorStyle = ATCommonCellSeparatorStyleSymmetricalDefault;
            cell.cellTextFieldMoney.placeholder = @"请填写";
            cell.cellTextFieldMoney.text = self.storeModel.personCapita;
            cell.cellTextFieldMoney.bk_didEndEditingBlock = ^(UITextField *textField) {
                weakSelf.storeModel.personCapita = textField.text;
            };
            
        }
            
            break;
            
        case 3: {
            cell = [[AddStoresViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"phone"];
            cell.bottomSeparatorStyle = ATCommonCellSeparatorStyleSymmetricalDefault;
            cell.cellTextField.placeholder = @"区号-电话，如010-67085435";
            cell.cellTextField.text = self.storeModel.phoneNum;
            cell.cellTextField.bk_didEndEditingBlock = ^(UITextField *textField) {
     
                weakSelf.storeModel.phoneNum = textField.text;
            };
            
            
        }
            
            break;
            
        case 4: {
            cell = [[AddStoresViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"categories"];
            cell.bottomSeparatorStyle = ATCommonCellSeparatorStyleSymmetricalDefault;
            cell.cellContentLabel.text = @"选择";
            
            
        }
            
            break;
            
        case 5: {
            cell = [[AddStoresViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"area"];
            cell.bottomSeparatorStyle = ATCommonCellSeparatorStyleSymmetricalDefault;
            cell.cellContentLabel.text = self.storeModel.storeArea.length > 0 ? self.storeModel.storeArea : @"选择";
            cell.cellContentLabel.textColor = self.storeModel.storeArea.length > 0 ? [Theme colorDarkGray] : [Theme colorForTextPlaceHolder];
            
            
        }
            
            break;
            
        case 6: {
            cell = [[AddStoresViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"address"];
            cell.bottomSeparatorStyle = ATCommonCellSeparatorStyleSymmetricalDefault;
            cell.cellTextField.placeholder = @"请填写";
            cell.cellTextField.text = self.storeModel.detailAddress;
            cell.cellTextField.bk_didEndEditingBlock = ^(UITextField *textField) {
                weakSelf.storeModel.detailAddress = textField.text;
            };
            
        }
            
            break;
        case 7: {
            cell = [[AddStoresViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"locate"];
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
