//
//  AdministrationViewCell.h
//  LeTuiWei
//
//  Created by 陈营超 on 2017/3/30.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "ATCommonCell.h"

typedef NS_ENUM(NSUInteger, AdministrationViewCellType) {
    AdministrationViewCellTypeCommon = 0,
    AdministrationViewCellTypeRightLabel,
};

@interface AdministrationViewCell : ATCommonCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withDataSource:(id)dataSource withCellType:(AdministrationViewCellType)cellType;

- (void)creatCommonCellWithData:(id)dataSource;

@end
