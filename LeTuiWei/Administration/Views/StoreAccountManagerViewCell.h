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
    AccountManagerCellTypeBasicFunction,
    
};

@interface StoreAccountManagerViewCell : ATCommonCell


@property (nonatomic, strong) UIButton *unfoldButton;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withDataSource:(id)dataSource cellType:(AccountManagerCellType)type;


@property (nonatomic, copy) void (^changeButtonClickedBlock)(AccountManagerCellType type);

@property (nonatomic, copy) void (^openButtonClickedBlock)(AccountManagerCellType type);

@end
