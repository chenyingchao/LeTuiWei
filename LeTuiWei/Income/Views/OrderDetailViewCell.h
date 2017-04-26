//
//  OrderDetailViewCell.h
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/26.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "ATCommonCell.h"

typedef  NS_ENUM(NSUInteger, OrderDetailViewCellType){
    OrderDetailViewCellTypeOrderNumber = 0,
    OrderDetailViewCellTypeOrderProduct,
    OrderDetailViewCellTypeOrderMoney,
    OrderDetailViewCellTypeSecondSection,
    
    
};

@interface OrderDetailViewCell : ATCommonCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withDataSource:(id)dataSource withCellType:(OrderDetailViewCellType)cellType;





@end
