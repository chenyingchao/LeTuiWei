//
//  IncomeDataViewCell.h
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/26.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "ATCommonCell.h"

typedef NS_ENUM(NSUInteger, IncomeDataViewCellType){
    IncomeDataViewCellTypeHaveProductQuantity = 0,
    IncomeDataViewCellTypeNoProductQuantity,
    IncomeDataViewCellTypeVIpTopUp


};

@interface IncomeDataViewCell : ATCommonCell


- (void)creatCellView:(id)dataSource withCellType:(IncomeDataViewCellType)type;

@end
