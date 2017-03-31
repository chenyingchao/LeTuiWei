//
//  ATCommonCell.h
//  AsiaTravel
//
//  Created by wangxinxin on 16/2/24.
//  Copyright © 2016年 asiatravel. All rights reserved.
//

#import <UIKit/UIKit.h>

extern const CGFloat kSubViewLeftMargin;

typedef NS_OPTIONS (NSUInteger, ATCommonCellComponent) {
    ATCommonCellComponentTitleLabel = 1,
    ATCommonCellComponentSubtitleLabel           = 1 << 1,
    ATCommonCellComponentInputTextField          = 1 << 2,
    ATCommonCellComponentSupplementeryTextField  = 1 << 3,
    ATCommonCellComponentAccessaryButton         = 1 << 4,
    ATCommonCellComponentCellIcon                = 1 << 5,
    ATCommenCellComponentEmpty                   = 1 << 6,
    ATCommonCellComponentDefault                 = ATCommonCellComponentTitleLabel | ATCommonCellComponentSubtitleLabel,
};

typedef NS_ENUM(NSUInteger, ATCommonCellSeparatorStyle) {
    ATCommonCellSeparatorStyleDefault,
    ATCommonCellSeparatorStyleFullLength,
    ATCommonCellSeparatorStyleHalfLength,
    ATCommonCellSeparatorStyleSymmetricalDefault,
    ATCommonCellSeparatorStyleHalfWithRight,
    ATCommonCellSeparatorStyleNone,
};

@class ATCommonCell;
@protocol ATCommonCellDelegate <NSObject>

@optional

- (ATCommonCellSeparatorStyle)separatorStyleOfCommmonCell:(ATCommonCell*)cell;

- (void)didClickaccessaryButtonOfCommmonCell:(ATCommonCell*)cell;

- (void)commonCell:(ATCommonCell *)cell didEndEditingOnInputTextField:(UITextField *)textField;

- (void)commonCell:(ATCommonCell *)cell didEndEditingOnSupplementeryTextField:(UITextField *)textField;

@end

@interface ATCommonCell : UITableViewCell

@property(nonatomic, strong) UIView *bottomSeparator;

@property (nonatomic, strong) NSDictionary *componentsMap;

@property (nonatomic, weak) id<ATCommonCellDelegate> delegate;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, assign, readonly) CGFloat intrinsicCellHeight;

@property (nonatomic, copy) NSString *cellIcon;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSAttributedString *attributedTitle;

@property (nonatomic, copy) NSString *subTitle;

@property (nonatomic, copy) NSAttributedString *attributedSubTitle;

@property (nonatomic, copy) NSString *inputTextFieldText;

@property (nonatomic, copy) NSString *supplementeryTextFieldText;

@property (nonatomic, copy) NSString *inputTextFieldPlaceHolder;

@property (nonatomic, copy) NSString *supplementeryTextFieldPlaceHolder;

@property (nonatomic, copy) NSString *accessaryButtonTitle;

@property (nonatomic, copy) NSString *accessaryButtonNormalImage;

@property (nonatomic, copy) NSString *accessaryButtonHighlightImage;

@property(nonatomic, strong) UILabel *subTitleLabel;

@property (nonatomic, assign) ATCommonCellSeparatorStyle topSeparatorStyle;

@property (nonatomic, assign) ATCommonCellSeparatorStyle bottomSeparatorStyle;

@property (nonatomic, assign) UIColor *defaultTextColor;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier components:(ATCommonCellComponent)components;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

- (void)updateUI;

// custmize layout, key is wrapped NSObject of `ATCommonCellComponent`, value is an instance of UIView.
- (void)customizeLayout:(NSDictionary *)components;

@end
