//
//  StoreCoordinateViewController.h
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/10.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "BaseViewController.h"
#import <QMapKit/QMapKit.h>

@interface StoreCoordinateViewController : BaseViewController


@property (nonatomic, copy) void (^storeLocationBlock)(CLLocationCoordinate2D storeCoordinate);

@end
