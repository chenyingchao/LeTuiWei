//
//  IncomeViewCell.h
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/21.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "ATCommonCell.h"

typedef  NS_ENUM(NSUInteger, IncomeViewCellType){
        IncomeViewCellLineBottomStore = 0,
        IncomeViewCellLineUpH5Object,
        IncomeViewCellLineUpH5Serve,

};


@interface IncomeViewCell : ATCommonCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withDataSource:(id)dataSource withCellType:(IncomeViewCellType)cellType;


@end
