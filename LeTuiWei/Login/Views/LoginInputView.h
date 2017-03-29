//
//  LoginInputView.h
//  OilInstalments
//
//  Created by 陈颖超 on 2017/2/9.
//  Copyright © 2017年 chenyingchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol inputViewDelegate<NSObject>

- (void) inputViewTextFieldDidEndEditing:(UITextField *)textField;

@end

typedef NS_ENUM(NSUInteger, TextFieldType) {
    TextFieldTypeCommon,
    TextFieldTypeAccount,
    TextFieldTypePassWord,
    TextFieldTypeCaptcha,
    

};

@interface LoginInputView : UIView

@property (nonatomic, weak) UIImageView *iconImageView;

@property (nonatomic, strong) UIImageView *captchaImageView;

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, copy) NSString *placeHolder;

@property (nonatomic, strong) UIButton *verifyButton;

@property (nonatomic,copy) void (^verifyButtonClickedBlock)();

@property (nonatomic, weak) id <inputViewDelegate> delegate;

- (instancetype)initWithTitle:(NSString *)title placeHolder:(NSString *)placeHolder;

- (instancetype)initWithImageIcon:(UIImage *)icon placeHolder:(NSString *)placeHolder textFieldType:(TextFieldType)type;

@end
