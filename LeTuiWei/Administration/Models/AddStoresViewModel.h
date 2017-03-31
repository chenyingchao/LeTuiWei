//
//  AddStoresViewModel.h
//  LeTuiWei
//
//  Created by 陈营超 on 2017/3/31.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "BaseModel.h"

@interface AddStoresViewModel : BaseModel

@property (nonatomic, copy) NSString *MerchantName;

@property (nonatomic, copy) NSString *storeName;

@property (nonatomic, copy) NSString *personCapita;

@property (nonatomic, copy) NSString *phoneNum;

@property (nonatomic, copy) NSString *operateCategories;

@property (nonatomic, copy) NSString *storeArea;

@property (nonatomic, copy) NSString *detailAddress;

@property (nonatomic, copy) NSString *storeCoordinate;


@end
