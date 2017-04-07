//
//  SelectPaymentTypeViewController.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/6.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "SelectPaymentTypeViewController.h"
#import "SelectPaymentTypeViewCell.h"
#import "PaymentResultViewController.h"

typedef NS_ENUM(NSUInteger, SegmentPaymentType) {
    SegmentPaymentTypeThirdPartyPayment = 0,
    SegmentPaymentTypeScanCodePayment,

};

@interface SelectPaymentTypeViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) SegmentPaymentType segmentPaymentType;

@end

@implementation SelectPaymentTypeViewController

- (void)loadView {
    [super loadView];
    [self creatTableView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"开通方式";
    _segmentPaymentType = SegmentPaymentTypeThirdPartyPayment;
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

    return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SelectPaymentTypeViewCell *cell = nil;
    WS(weakSelf);
    
    switch (indexPath.section) {
        case 0: {
            cell = [[SelectPaymentTypeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"segment" withDataSource:nil cellType:SelectPaymentCellTypeSegment];
            cell.segmentBlock = ^(SelectPaymentCellType type){
                if (type == SelectPaymentCellTypeThirdPartyPayment) {
                    _segmentPaymentType = SegmentPaymentTypeThirdPartyPayment;
                    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
                    [weakSelf.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
                } else {
                    _segmentPaymentType = SegmentPaymentTypeScanCodePayment;
                    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
                    [weakSelf.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
                }
            };
        
        }
            
            break;
            
        case 1: {
            
            switch (_segmentPaymentType) { //选择第三方， 微信 支付宝
                case SegmentPaymentTypeThirdPartyPayment: {
                    cell = [[SelectPaymentTypeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"segment" withDataSource:nil cellType:SelectPaymentCellTypeThirdPartyPayment];
                    //开通几个月的
                    cell.selectLimitBlock = ^(SelectPaymentItemType type){
                        NSLog(@"%lu", (unsigned long)type);
                    };
                    
                    cell.selectPaymentTypeBlock = ^(SelectPaymentType type){
                        
                        switch (type) {
                            case SelectPaymentTypeWechatPay: {
                               //此处跳转微信支付
                                [weakSelf wechatPay];
                            }
                                
                                break;
                                
                            case SelectPaymentTypeAliPay: {
                               //此处跳转支付宝支付
                                [weakSelf aliPay];
                            
                            }
                                break;
                                default:
                                break;
                        }
                    };

                
                }
                    
                    break;
                    
                default: { //扫码支付
                    cell = [[SelectPaymentTypeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"segment" withDataSource:nil cellType:SelectPaymentCellTypeScanCodePayment];
                    
                    
                    cell.selectPaymentTypeBlock = ^(SelectPaymentType type){
                        
                        switch (type) {
                            case SelectPaymentTypeScanCodePay: {
                                //此处扫码支付
                                [weakSelf scanCodePay];
                            }
                                break;

                            default:
                                break;
                        }
                    };
                
                }
                    break;
            }
    
        }
            break;
    }
    
    
    
    return cell;
    
}


#pragma mark 微信支付
- (void)wechatPay {

    PaymentResultViewController *paymentResultVC = [[PaymentResultViewController alloc] init];
    paymentResultVC.paymentType = PaymentTypeWechatPay;
    paymentResultVC.paymentResultType = PaymentResultTypeSuccess;
    [self.navigationController pushViewController:paymentResultVC animated:YES];

}

#pragma mark  支付宝支付
- (void)aliPay {
    
    PaymentResultViewController *paymentResultVC = [[PaymentResultViewController alloc] init];
    paymentResultVC.paymentType = PaymentTypeAliPay;
    paymentResultVC.paymentResultType = PaymentResultTypeFailed;
    [self.navigationController pushViewController:paymentResultVC animated:YES];
    
}

#pragma mark 兑换码支付
- (void)scanCodePay{
    
    PaymentResultViewController *paymentResultVC = [[PaymentResultViewController alloc] init];
    paymentResultVC.paymentType = PaymentTypeScanCodePay;
    paymentResultVC.paymentResultType = PaymentResultTypeTimeOut;
    [self.navigationController pushViewController:paymentResultVC animated:YES];
    
}




- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return [Theme paddingWithSize20];
}



@end
