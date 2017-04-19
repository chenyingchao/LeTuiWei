//
//  CoustomPopUpView.h
//  弹窗demo
//
//  Created by 陈营超 on 2017/4/10.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PopUpViewType) {

    PopUpViewTypeWithComment = 0,
    PopUpViewTypeWithTabView,
    PopUpViewTypeWithTextField


};

typedef NS_OPTIONS (NSUInteger,PopUpViewComponent) {
    PopUpViewComponentCentreButton = 1,
    PopUpViewComponentLeftButton          = 1 << 1,
    PopUpViewComponentRightButton         = 1 << 2,
    PopUpViewComponentCentreUpButton         = 1 << 3,

   

};


@interface CoustomPopUpView : UIView

- (void)PopUpViewComponent:(PopUpViewType)type withTitle:(NSString *)title withContent:(NSString *)content andButtonType:(PopUpViewComponent)components;

- (void)PopUpViewComponent:(PopUpViewType)type withTitle:(NSString *)title withDataScoure:(id)dataScoure;

@property (nonatomic, copy) void (^centreButtonClickedBlock)(UIButton *button, NSString *tempParameter );

@property (nonatomic, copy) void (^centreUpButtonClickedBlock)(UIButton *button);

@property (nonatomic, copy) void (^leftButtonClickedBlock)(UIButton *button);

@property (nonatomic, copy) void (^rightButtonClickedBlock)(UIButton *button);


@property (nonatomic, copy) void (^tabViewCellClickedBlock)(NSIndexPath *indexPath);

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSMutableAttributedString *attributeContent;

@property (nonatomic, copy) NSString *content;


@property (nonatomic, copy) NSString *centreButtonTitle;


@property (nonatomic, copy) NSString *centreUpButtonTitle;

@property (nonatomic, copy) NSString *leftButtonTitle;

@property (nonatomic, copy) NSString *rightButtonTitle;

@property (nonatomic, strong) NSArray *dataSourceArray;


- (void)closeView;

@end
