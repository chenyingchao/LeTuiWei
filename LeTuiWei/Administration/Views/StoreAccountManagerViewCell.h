//
//  StoreAccountManagerViewCell.h
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/1.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "ATCommonCell.h"

typedef NS_ENUM(NSUInteger,AccountManagerCellType) {
    AccountManagerCellTypeStoreName = 0,
    AccountManagerCellTypeAccount,
    AccountManagerCellTypePassword,
    AccountManagerCellTypeMarketing,
    AccountManagerCellTypeOrderTaking,
    
};

@interface StoreAccountManagerViewCell : ATCommonCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withDataSource:(id)dataSource cellType:(AccountManagerCellType)type;

@end
