//
//  PaymentResultViewController.h
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/7.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "BaseViewController.h"
typedef NS_ENUM(NSUInteger, PaymentResultType) {
    PaymentResultTypeSuccess =0,
    PaymentResultTypeFailed,
    PaymentResultTypeTimeOut,
    
};

typedef NS_ENUM(NSUInteger, PaymentType) {
    PaymentTypeWechatPay =0,
    PaymentTypeAliPay,
    PaymentTypeScanCodePay,
    
};

@interface PaymentResultViewController : BaseViewController


@property(nonatomic, assign) PaymentResultType paymentResultType;

@property(nonatomic, assign) PaymentType paymentType;

@end
