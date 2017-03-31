//
//  AddStoresViewCell.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/3/30.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "AddStoresViewCell.h"

@interface AddStoresViewCell()<UITextFieldDelegate>

@end

@implementation AddStoresViewCell

- (UILabel *)cellTitleLabel {
    if (!_cellTitleLabel) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [Theme fontWithSize28];
        titleLabel.textColor = [Theme colorDarkGray];
        _cellTitleLabel = titleLabel;
        [self.contentView addSubview:titleLabel];
        WS(weakSelf);
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).offset([Theme paddingWithSize40]);
            make.centerY.equalTo(weakSelf.mas_centerY);
        }];
        
    }
    return _cellTitleLabel;
}


- (UITextField *)cellTextField {
    if (!_cellTextField) {
        UITextField *textField = [[UITextField alloc] init];
        textField.font = [Theme fontWithSize28];
        textField.textAlignment = NSTextAlignmentRight;
        textField.returnKeyType = UIReturnKeyDone;
        textField.delegate = self;
        _cellTextField = textField;
        [self.contentView addSubview:textField];
        
        WS(weakSelf);
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).offset(105);
            make.centerY.equalTo(weakSelf.mas_centerY);
            make.right.equalTo(weakSelf.mas_right).offset(-[Theme paddingWithSize40]);
            make.height.equalTo(weakSelf.mas_height).offset([Theme paddingWithSize10]);
        }];
    }
    return _cellTextField;
}

- (UITextField *)cellTextFieldMoney {
    if (!_cellTextFieldMoney) {
        UITextField *textField = [[UITextField alloc] init];
        textField.font = [Theme fontWithSize28];
        textField.textAlignment = NSTextAlignmentRight;
        textField.returnKeyType = UIReturnKeyDone;
        textField.delegate = self;
        _cellTextFieldMoney = textField;
        [self.contentView addSubview:textField];
        
        WS(weakSelf);
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).offset(105);
            make.centerY.equalTo(weakSelf.mas_centerY);
            //make.right.equalTo(weakSelf.mas_right).offset(-[Theme paddingWithSize:70]);
            make.height.equalTo(weakSelf.mas_height).offset([Theme paddingWithSize10]);
        }];
        
        
        UILabel *moneyLabel = [[UILabel alloc] init];
        moneyLabel.font = [Theme fontWithSize28];
        moneyLabel.textColor = [Theme colorDarkGray];
        moneyLabel.text = @"元";
        [self.contentView addSubview:moneyLabel];
     
        [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.mas_right).offset(-[Theme paddingWithSize40]);
            make.centerY.equalTo(weakSelf.mas_centerY);
            make.left.equalTo(textField.mas_right).offset([Theme paddingWithSize12]);
        }];
   
        [moneyLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        
    }
    return _cellTextFieldMoney;
}

- (UILabel *)cellContentLabel {
    if (!_cellContentLabel) {
        
        WS(weakSelf);
        UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        arrowImageView.image = [UIImage imageNamed:@"arrow"];
        [self.contentView addSubview:arrowImageView];
        [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf).offset(-[Theme paddingWithSize40]);
            make.centerY.equalTo(weakSelf.contentView);
        }];
        
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [Theme fontWithSize28];
        titleLabel.textColor = [Theme colorForTextPlaceHolder];
        _cellContentLabel = titleLabel;
        [self.contentView addSubview:_cellContentLabel];
      
        [_cellContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(arrowImageView.mas_left).offset(-[Theme paddingWithSize12]);
            make.centerY.equalTo(weakSelf.mas_centerY);
        }];
        
    }
    return _cellContentLabel;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


@end
