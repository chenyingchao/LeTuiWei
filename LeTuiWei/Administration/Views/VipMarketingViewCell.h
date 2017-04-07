//
//  VipMarketingViewCell.h
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/6.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "ATCommonCell.h"

typedef NS_ENUM(NSUInteger, VipMarketingViewCellType) {
    VipMarketingViewCellTypeTitle = 0,
    VipMarketingViewCellTypeItemTitle,
    VipMarketingViewCellTypeSingleFunction,
    VipMarketingViewCellTypeVipSystem,
    VipMarketingViewCellTypeFunctionImages,

};


@interface VipMarketingViewCell : ATCommonCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withDataSource:(id)dataSource cellType:(VipMarketingViewCellType)type;


@property (nonatomic, copy) void (^immediateOpeningButtonBlock)();

@end
