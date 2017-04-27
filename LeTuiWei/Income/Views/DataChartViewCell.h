//
//  DataChartViewCell.h
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/27.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "ATCommonCell.h"
typedef NS_ENUM(NSUInteger, DataChartViewCellType){
    DataChartViewCellTypeTrendChart = 0,
    DataChartViewCellTypeTop5,

    
    
    
};
@interface DataChartViewCell : ATCommonCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withDataSource:(id)dataSource withCellType:(DataChartViewCellType)cellType;


@property (nonatomic, copy) void (^openWisdomStoreBlock)(void);

@property (nonatomic, copy) void (^segmentIndexBlock)(NSInteger index);


@end
