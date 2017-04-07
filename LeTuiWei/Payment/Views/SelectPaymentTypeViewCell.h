//
//  SelectPaymentTypeViewCell.h
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/6.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "ATCommonCell.h"

typedef NS_ENUM(NSUInteger, SelectPaymentCellType) {
    SelectPaymentCellTypeSegment=0,
    SelectPaymentCellTypeThirdPartyPayment,
    SelectPaymentCellTypeScanCodePayment
};

typedef NS_ENUM(NSUInteger, SelectPaymentItemType) {
    SelectPaymentItemTypeMonth=0,
    SelectPaymentItemTypeQuarter,
    SelectPaymentItemTypeHalfYear,
    SelectPaymentItemTypeYear
    
};

typedef NS_ENUM(NSUInteger, SelectPaymentType) {
    SelectPaymentTypeWechatPay =0,
    SelectPaymentTypeAliPay,
    SelectPaymentTypeScanCodePay,
    
};

@interface SelectPaymentTypeViewCell : ATCommonCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withDataSource:(id)dataSource cellType:(SelectPaymentCellType)type;


@property (nonatomic, copy) void (^selectLimitBlock)(SelectPaymentItemType type);

@property (nonatomic, copy) void (^segmentBlock)(SelectPaymentCellType type);

@property (nonatomic, copy) void (^selectPaymentTypeBlock)(SelectPaymentType type);

@end
