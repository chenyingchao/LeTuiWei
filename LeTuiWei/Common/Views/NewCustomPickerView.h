//
//  NewCustomPickerView.h
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/18.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "ATCommonCell.h"

typedef void(^determineBtnActionBlock)(NSString *selectName);

typedef void(^pickerViewStatusBlock)(BOOL willOpen);

@interface NewCustomPickerView : ATCommonCell

@property (copy, nonatomic) determineBtnActionBlock determineBtnBlock;

@property (copy, nonatomic) pickerViewStatusBlock statusBlock;

- (void)show;

- (void)dismiss;


@property (strong, nonatomic) NSArray *dataSource;

@end
