//
//  SiftView.h
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/24.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SiftView;


typedef NS_ENUM(NSUInteger, SiftViewButtonType){
    SiftViewButtonTypeAllStores =100,
    SiftViewButtonTypeAllIncome,
    SiftViewButtonTypeAllChannel,
    SiftViewButtonTypeAllTool,
};


@protocol SiftViewDelegate<NSObject>

@required

- (NSInteger)numberOfRowsInOrderDetailsView;

- (NSString *)dataForRowAtIndexPath:(NSIndexPath *)indexPath;


- (void)siftView:(SiftView *)siftView didSelectedData:(NSArray *)data;

- (void)siftView:(SiftView *)siftView didSelectedButtonType:(SiftViewButtonType )type buttonStatus:(BOOL)selected;

@optional



@end



@interface SiftView : UIView

@property (nonatomic, weak) id<SiftViewDelegate> siftDelegate;

-(instancetype)initWithFrame:(CGRect)frame storeQuantity:(NSInteger)storeQuantity;

- (void)createAllIncomeView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) SiftViewButtonType buttonType;

@end
