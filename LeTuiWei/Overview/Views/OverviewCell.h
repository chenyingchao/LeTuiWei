//
//  OverviewCell.h
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/17.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "ATCommonCell.h"

typedef NS_ENUM(NSUInteger, OverviewCellType){
    OverviewCellTypeStoreDate = 0,
    OverviewCellTypeOrderMoneyStatistics,
    OverviewCellTypePayTypeProportion,
    OverviewCellTypeProductTop5,
    OverviewCellTypeOrderDistributionMap,
    //OverviewCellTypeH5Date,
    OverviewCellTypeVipDate,
    OverviewCellTypeWeixinPayFuns,
    OverviewCellTypeTakeOutDate,
    OverviewCellTypeTakeOutProportion
    
    

};

@interface OverviewCell : ATCommonCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withDataSource:(id)dataSource withCellType:(OverviewCellType)cellType;


@property (nonatomic, copy) void (^openWisdomStoreBlock)(void);

@property (nonatomic, copy) void (^segmentIndexBlock)(NSInteger index);

@end
