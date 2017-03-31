//
//  ATCommonCell.m
//  AsiaTravel
//
//  Created by wangxinxin on 16/2/24.
//  Copyright © 2016年 asiatravel. All rights reserved.
//

#import "ATCommonCell.h"

const CGFloat kSubViewLeftMargin = 190 / 2.0;

static const CGFloat kDefautlIconRightMargin = 6;

@interface ATCommonCell ()<UITextFieldDelegate>

@property(nonatomic, strong) UIButton *cellIconButton;

@property(nonatomic, strong) UILabel *titleLabel;

//@property(nonatomic, strong) UILabel *subTitleLabel;

@property(nonatomic, strong) UITextField *inputTextField;

@property(nonatomic, strong) UITextField *supplementeryTextField;

@property(nonatomic, strong) UIButton *accessaryButton;

@property(nonatomic, strong) UIView *topSeparator;

@end

@implementation ATCommonCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier components:(ATCommonCellComponent)components{
    
    if (!components) {
        components = ATCommonCellComponentDefault;
    }
    
    if (components & ATCommenCellComponentEmpty) {
        
    }
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        WS(weakSelf);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (components & ATCommonCellComponentCellIcon) {
            self.cellIconButton = [UIButton buttonWithType:UIButtonTypeCustom];
            self.cellIconButton.userInteractionEnabled = NO;
            [self.contentView addSubview:self.cellIconButton];
            [self.cellIconButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(weakSelf).offset([Theme paddingWithSize28]);
                make.centerY.height.equalTo(weakSelf);
            }];
        }
        
        if (components & ATCommonCellComponentTitleLabel ) {
            self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
            self.titleLabel.font = [Theme fontWithSize28];
            self.titleLabel.textColor = self.defaultTextColor;
            [self.contentView addSubview:self.titleLabel];
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                if (components & ATCommonCellComponentCellIcon) {
                    make.left.equalTo(weakSelf.cellIconButton.mas_right).offset(kDefautlIconRightMargin);
                } else {
                    make.left.equalTo(weakSelf).offset([Theme paddingWithSize28]);
                }
                make.centerY.height.equalTo(weakSelf);
            }];
        }
        if (components & ATCommonCellComponentSubtitleLabel ) {
            self.subTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
            self.subTitleLabel.font = [Theme fontWithSize28];
            self.subTitleLabel.textColor = self.defaultTextColor;
            [self.contentView addSubview:self.subTitleLabel];
            [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(weakSelf).offset(kSubViewLeftMargin * kDeviceScaleFactor);
                make.centerY.height.equalTo(weakSelf);
            }];
        }
        if (components & ATCommonCellComponentInputTextField) {
            self.inputTextField = [[UITextField alloc] initWithFrame:CGRectZero];
            self.inputTextField.font = [Theme fontWithSize28];
            self.inputTextField.returnKeyType = UIReturnKeyDone;
            self.inputTextField.delegate = self;
            self.inputTextField.textColor = self.defaultTextColor;
            [self.contentView addSubview:self.inputTextField];
            [self.inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(weakSelf).offset((components & ATCommonCellComponentTitleLabel) ? kSubViewLeftMargin * kDeviceScaleFactor : [Theme paddingWithSize28]);
                make.centerY.height.equalTo(weakSelf);
                make.width.greaterThanOrEqualTo(@((kScreenWidth / 2.0) - [Theme paddingWithSize28]));
            }];
            
            self.inputTextField.bk_didEndEditingBlock = ^(UITextField *textField) {
                if ([weakSelf.delegate respondsToSelector:@selector(commonCell:didEndEditingOnInputTextField:)]) {
                    [weakSelf.delegate commonCell:weakSelf didEndEditingOnInputTextField:textField];
                }
            };
        }
        
        if (components & ATCommonCellComponentSupplementeryTextField) {
            self.supplementeryTextField = [[UITextField alloc] initWithFrame:CGRectZero];
            self.supplementeryTextField.font = [Theme fontWithSize28];
            self.supplementeryTextField.returnKeyType = UIReturnKeyDone;
            self.supplementeryTextField.delegate = self;
            self.supplementeryTextField.textColor = self.defaultTextColor;
            [self.contentView addSubview:self.supplementeryTextField];
            [self.supplementeryTextField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(weakSelf).offset(kScreenWidth / 2.0 + [Theme paddingWithSize28]);
                make.centerY.height.equalTo(weakSelf);
            }];
            
            self.supplementeryTextField.bk_didEndEditingBlock = ^(UITextField *textField) {
                if ([weakSelf.delegate respondsToSelector:@selector(commonCell:didEndEditingOnSupplementeryTextField:)]) {
                    [weakSelf.delegate commonCell:weakSelf didEndEditingOnSupplementeryTextField:textField];
                }
            };
        }
        
        if (components & ATCommonCellComponentInputTextField && components & ATCommonCellComponentSupplementeryTextField ) {
            //centerX separator
            UIView *verticalSeparator = [[UIView alloc] initWithFrame:CGRectZero];
            [self.contentView addSubview:verticalSeparator];
            [verticalSeparator mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@(kSeparatorHeight));
                make.height.equalTo(verticalSeparator.mas_width).multipliedBy(26);
                make.centerX.centerY.equalTo(weakSelf.contentView);
            }];
            verticalSeparator.backgroundColor = [Theme colorForSeparatorLine];
        }
        
        if (components & ATCommonCellComponentAccessaryButton) {
            self.accessaryButton = [UIButton buttonWithType:UIButtonTypeCustom];
            self.accessaryButton.titleLabel.font = [Theme fontWithSize28];
            [self.accessaryButton setTitleColor:self.defaultTextColor forState:UIControlStateNormal];
            [self.contentView addSubview:self.accessaryButton];
            [self.accessaryButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(weakSelf).offset(-[Theme paddingWithSize28]);
                make.centerY.height.equalTo(weakSelf);
            }];
            [self.accessaryButton setImage:[UIImage imageNamed:self.accessaryButtonNormalImage] forState:UIControlStateNormal];
            if (!self.accessaryButtonHighlightImage) {
                [self.accessaryButton setImage:[UIImage imageNamed:self.accessaryButtonNormalImage] forState:UIControlStateHighlighted];
            }
            [self.accessaryButton bk_whenTapped:^{
                if ([weakSelf.delegate respondsToSelector:@selector(didClickaccessaryButtonOfCommmonCell:)]) {
                    [weakSelf.delegate didClickaccessaryButtonOfCommmonCell:weakSelf];
                }
            }];
        }

        self.bottomSeparator = [[UIView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:self.bottomSeparator];
        self.bottomSeparator.backgroundColor = [Theme colorForSeparatorLine];
        [self.bottomSeparator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.contentView).offset([Theme paddingWithSize28]);
            make.height.equalTo(@(kSeparatorHeight));;
            make.right.bottom.equalTo(weakSelf.contentView);
        }];
        
        self.topSeparator = [[UIView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:self.topSeparator];
        self.topSeparator.backgroundColor = [Theme colorForSeparatorLine];
        [self.topSeparator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(kSeparatorHeight));;
            make.right.top.equalTo(weakSelf.contentView);
            make.left.equalTo(weakSelf.contentView).offset(kScreenWidth);
        }];
        
        NSDictionary *componentsMap = @{@(ATCommonCellComponentCellIcon) : self.cellIconButton ? self.cellIconButton : [NSNull null],
                                        @(ATCommonCellComponentTitleLabel) : self.titleLabel ? self.titleLabel : [NSNull null],
                                        @(ATCommonCellComponentSubtitleLabel) : self.subTitleLabel ? self.subTitleLabel : [NSNull null],
                                        @(ATCommonCellComponentInputTextField) : self.inputTextField ? self.inputTextField : [NSNull null],
                                        @(ATCommonCellComponentSupplementeryTextField) : self.supplementeryTextField ? self.supplementeryTextField : [NSNull null],
                                        @(ATCommonCellComponentAccessaryButton) : self.accessaryButton ? self.accessaryButton : [NSNull null]
                                        };
        self.componentsMap = componentsMap;
        [self customizeLayout:componentsMap];
    }
    return self;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    return [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier components:ATCommonCellComponentDefault];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateUI];
}

- (void)updateUI {
    
    WS(weakSelf);
    
    if (self.cellIcon) {
        [self.cellIconButton setImage:[UIImage imageNamed:self.cellIcon] forState:UIControlStateNormal];
    }
    
    if (self.attributedTitle) {
        self.titleLabel.attributedText = self.attributedTitle;
    } else if (self.title) {
        self.titleLabel.text = self.title;
    }
    
    if (self.attributedSubTitle) {
        self.subTitleLabel.attributedText = self.attributedSubTitle;
    } else if (self.subTitle) {
        self.subTitleLabel.text = self.subTitle;
    }
    
    if (self.inputTextFieldPlaceHolder) {
        self.inputTextField.placeholder = self.inputTextFieldPlaceHolder;
    }
    
    if (self.inputTextFieldText) {
        self.inputTextField.text = self.inputTextFieldText;
    }
    
    if (self.supplementeryTextFieldPlaceHolder) {
        self.supplementeryTextField.placeholder = self.supplementeryTextFieldPlaceHolder;
    }
    
    if (self.supplementeryTextFieldText) {
        self.supplementeryTextField.text = self.supplementeryTextFieldText;
    }
    
    if (self.accessaryButtonTitle) {
        [self.accessaryButton setTitle:self.accessaryButtonTitle forState:UIControlStateNormal];
        [self.accessaryButton setTitle:self.accessaryButtonTitle forState:UIControlStateHighlighted];
    }
    
    if (self.accessaryButtonNormalImage) {
        [self.accessaryButton setImage:[UIImage imageNamed:self.accessaryButtonNormalImage] forState:UIControlStateNormal];
        if (!self.accessaryButtonHighlightImage) {
            [self.accessaryButton setImage:[UIImage imageNamed:self.accessaryButtonNormalImage] forState:UIControlStateHighlighted];
        }
    }
    
    if (self.accessaryButtonHighlightImage) {
        [self.accessaryButton setImage:[UIImage imageNamed:self.accessaryButtonHighlightImage] forState:UIControlStateHighlighted];
    }
    
    ATCommonCellSeparatorStyle separatorStyle = self.bottomSeparatorStyle;
    if ([weakSelf.delegate respondsToSelector:@selector(separatorStyleOfCommmonCell:)]) {
        separatorStyle = [weakSelf.delegate separatorStyleOfCommmonCell:weakSelf];
    }
    [self setCellSeparatorStyle:separatorStyle view:self.bottomSeparator];
}

#pragma mark - getter / setter

- (void)setTopSeparatorStyle:(ATCommonCellSeparatorStyle)topSeparatorStyle {
    _topSeparatorStyle = topSeparatorStyle;
    [self setCellSeparatorStyle:topSeparatorStyle view:self.topSeparator];
}

- (void)setBottomSeparatorStyle:(ATCommonCellSeparatorStyle)bottomSeparatorStyle {
    _bottomSeparatorStyle = bottomSeparatorStyle;
    [self setCellSeparatorStyle:bottomSeparatorStyle view:self.bottomSeparator];
}

- (void)setCellSeparatorStyle:(ATCommonCellSeparatorStyle)separatorStyle view:(UIView*)Separator{
    CGFloat leftMargin = [Theme paddingWithSize28];
     WS(weakSelf);
    switch (separatorStyle) {
        case ATCommonCellSeparatorStyleFullLength:
            leftMargin = 0;
            break;
            
        case ATCommonCellSeparatorStyleHalfLength:
            leftMargin = kSubViewLeftMargin;
            break;
            
        case ATCommonCellSeparatorStyleDefault:
            leftMargin = [Theme paddingWithSize28];
            break;
            
        case ATCommonCellSeparatorStyleSymmetricalDefault:{
            leftMargin = [Theme paddingWithSize28];
            [Separator mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(weakSelf.contentView).offset(-[Theme paddingWithSize28]);
            }];
        }
            break;
        case ATCommonCellSeparatorStyleHalfWithRight:{
            leftMargin = kSubViewLeftMargin;
            [Separator mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(weakSelf.contentView).offset(-[Theme paddingWithSize28]);
            }];
        }
            break;
        case ATCommonCellSeparatorStyleNone:
            leftMargin = self.frame.size.width;
            break;
            
        default:
            break;
    }
    [Separator mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).offset(leftMargin);
    }];
    [self.contentView bringSubviewToFront:Separator];
}

- (CGFloat)intrinsicCellHeight {
    return [Theme defaultCellHeight];
}

- (UIColor *)defaultTextColor {
    if (!_defaultTextColor) {
        _defaultTextColor = [Theme colorForTextTitle];
    }
    return _defaultTextColor;
}

- (NSString *)accessaryButtonNormalImage {
    if (!_accessaryButtonNormalImage) {
        _accessaryButtonNormalImage = @"common_arrowRightGray";
    }
    return _accessaryButtonNormalImage;
}


#pragma mark - TextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)customizeLayout:(NSArray *)components {
    // default do nothing
}

@end
