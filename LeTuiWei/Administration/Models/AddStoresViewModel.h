//
//  AddStoresViewModel.h
//  LeTuiWei
//
//  Created by 陈营超 on 2017/3/31.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "BaseModel.h"

@interface AddStoresViewModel : BaseModel

@property (nonatomic, copy) NSString *termDepart;

@property (nonatomic, copy) NSString *storeName;

@property (nonatomic, copy) NSString *airportCodeFrom;

@property (nonatomic, copy) NSString *airportCodeTo;

@property (nonatomic, copy) NSString *cityCodeFrom;

@property (nonatomic, copy) NSString *cityCodeTo;


@end
