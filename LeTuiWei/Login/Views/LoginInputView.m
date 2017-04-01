//
//  LoginInputView.m
//  OilInstalments
//
//  Created by 陈颖超 on 2017/2/9.
//  Copyright © 2017年 chenyingchao. All rights reserved.
//

#import "LoginInputView.h"


@interface LoginInputView ()<UITextFieldDelegate>


@end

@implementation LoginInputView

- (instancetype)initWithTitle:(NSString *)title placeHolder:(NSString *)placeHolder {
    
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, [Theme paddingWithSize:90])];
    if (self) {
        
        WS(weakSelf);
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        titleLabel.font = [Theme fontWithSize30];
        titleLabel.textColor = [Theme colorDarkGray];
        titleLabel.text = title;
        [self addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf).offset([Theme paddingWithSize:46]);
            make.centerY.equalTo(weakSelf.mas_centerY);
            
        

        }];
      CGFloat width =  [@"这是五个字" boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [Theme fontWithSize30]} context:nil].size.width;
      
        //textField
        _textField = [[UITextField alloc] initWithFrame:CGRectZero];
        _textField.clearButtonMode=UITextFieldViewModeWhileEditing;
        _textField.font = [Theme fontWithSize30];
        _textField.delegate = self;
        UIColor *textFieldColor = Color(204, 204, 204);
        _textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeHolder attributes:@{NSForegroundColorAttributeName: textFieldColor}];
        [self addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf).offset([Theme paddingWithSize:46]  + width + [Theme paddingWithSize32]);
            make.centerY.equalTo(weakSelf.mas_centerY);
            make.height.equalTo(@(weakSelf.frame.size.height));
            make.right.equalTo(weakSelf).offset(-[Theme paddingWithSize40]);
        }];
       
        [titleLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];



    }
    return self;
    
}


- (instancetype)initWithImageIcon:(UIImage *)icon placeHolder:(NSString *)placeHolder textFieldType:(TextFieldType)type {
    
    self = [super initWithFrame:CGRectMake([Theme paddingWithSize40], 0, kScreenWidth - [Theme paddingWithSize40] * 2, [Theme paddingWithSize:90])];
    
    if (self) {
        
        WS(weakSelf);
        self.backgroundColor = [Theme colorWhite];
        UIImageView *iconImageView = [[UIImageView alloc] initWithImage:icon];
        [self addSubview:iconImageView];
        _iconImageView = iconImageView;
        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf).offset([Theme paddingWithSize:46]);
            make.centerY.equalTo(weakSelf.mas_centerY);
            make.width.equalTo(@(icon.size.width));
            make.height.equalTo(@(icon.size.height));
        }];
        _iconImageView = iconImageView;
        
        //textField
        _textField = [[UITextField alloc] initWithFrame:CGRectZero];
        _textField.autocorrectionType = UITextAutocorrectionTypeNo;
        _textField.font = [Theme fontWithSize30];
        _textField.delegate = self;
        UIColor *textFieldColor = Color(204, 204, 204);
        _textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeHolder attributes:@{NSForegroundColorAttributeName: textFieldColor}];
        
        [self addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(iconImageView.mas_right).offset([Theme paddingWithSize20]);
            make.right.equalTo(weakSelf).offset(-[Theme paddingWithSize40]);
            make.centerY.equalTo(weakSelf.mas_centerY);
            make.height.equalTo(@(weakSelf.frame.size.height));
   
        }];
        
        
        
        if (type == TextFieldTypeCommon ) {
            
        } else if (type == TextFieldTypeAccount) {
            
            _textField.clearButtonMode=UITextFieldViewModeWhileEditing;
        
        } else if (type == TextFieldTypePassWord) {
            _textField.clearButtonMode=UITextFieldViewModeWhileEditing;
            
        } else if (type == TextFieldTypeCaptcha) {
            
            UIButton *verifyButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [verifyButton setTitle:@"获取验证码" forState:UIControlStateNormal];
     
            
            [verifyButton  setTitleColor:[Theme colorForAppearance] forState:UIControlStateNormal];
            
            verifyButton.titleLabel.font = [Theme fontWithSize30];
            
            [self addSubview:verifyButton];
            _verifyButton = verifyButton;
            
            [verifyButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.mas_centerY);
                make.right.equalTo(self.mas_right).offset(-[Theme paddingWithSize:37]);
                
            }];
            [verifyButton bk_whenTapped:^{
                if(weakSelf.verifyButtonClickedBlock){
                    weakSelf.verifyButtonClickedBlock();
                }
            }];
            
            UILabel * seperatorLabel = [[UILabel alloc] initWithFrame:CGRectZero];
            seperatorLabel.backgroundColor = [Theme colorBlackWithAlpha:0.3];
            [self addSubview:seperatorLabel];
     
            [seperatorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.right.equalTo(verifyButton.mas_left).offset(-[Theme paddingWithSize:46]);
                make.height.equalTo(@([Theme paddingWithSize:68]));
                make.width.equalTo(@(kSeparatorHeight));
            }];

            
            
        }
        
        
    }
    return self;
}



- (void)textFieldDidEndEditing:(UITextField *)textField {

    [self.delegate  inputViewTextFieldDidEndEditing:textField];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


@end
