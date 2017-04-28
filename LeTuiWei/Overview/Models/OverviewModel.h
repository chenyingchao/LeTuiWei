//
//  OverviewModel.h
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/28.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "BaseModel.h"
#import "StoreModel.h"
@interface OverviewModel : BaseModel

@property (nonatomic, copy) NSString *checkInDateStr;

@property (nonatomic, copy) NSString *checkOutDateStr;

@property (nonatomic, strong) NSArray <StoreModel *> *storeArray;



@property (nonatomic, assign) BOOL isSegmentFirst;

@end
