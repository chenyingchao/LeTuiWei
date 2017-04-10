//
//  SelectAccountViewCell.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/10.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "SelectAccountViewCell.h"

@implementation SelectAccountViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier components:ATCommenCellComponentEmpty];
    self.opaque = YES;
    if (self) {
        WS(weakSelf);
        self.accountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.accountLabel.text = @"当前显示账号: ";
        self.accountLabel.font = [Theme fontWithSize30];
        self.accountLabel.textColor = [Theme colorDimGray];
        [self.contentView addSubview:self.accountLabel];
        [self.accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.contentView).offset([Theme paddingWithSize32]);
            make.top.equalTo(weakSelf.contentView).offset([Theme paddingWithSize20]);
     
        }];
        
        self.passwordLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.passwordLabel.text = @"密码: ";
        self.passwordLabel.font = [Theme fontWithSize30];
        self.passwordLabel.textColor = [Theme colorDimGray];
        [self.contentView addSubview:self.passwordLabel];
        [self.passwordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.contentView).offset([Theme paddingWithSize32]);
            make.top.equalTo(weakSelf.accountLabel.mas_bottom).offset([Theme paddingWithSize20]);
            
        }];
        
        
        self.accountValueLabel = [[UILabel alloc] initWithFrame:CGRectZero];
     
        self.accountValueLabel.font = [Theme fontWithSize30];
        self.accountValueLabel.textColor = [Theme colorDarkGray];
        [self.contentView addSubview:self.accountValueLabel];
        [self.accountValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.accountLabel.mas_right).offset([Theme paddingWithSize10]);
            make.top.equalTo(weakSelf.contentView).offset([Theme paddingWithSize20]);
            make.right.equalTo(weakSelf.contentView).offset(-[Theme paddingWithSize32]);
            
        }];
        
        
        self.passwordValueLabel = [[UILabel alloc] initWithFrame:CGRectZero];

        self.passwordValueLabel.font = [Theme fontWithSize30];
        self.passwordValueLabel.textColor = [Theme colorDarkGray];
        [self.contentView addSubview:self.passwordValueLabel];
        [self.passwordValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.passwordLabel.mas_right).offset([Theme paddingWithSize10]);
            make.top.equalTo(weakSelf.accountLabel.mas_bottom).offset([Theme paddingWithSize20]);
            make.right.equalTo(weakSelf.contentView).offset(-[Theme paddingWithSize32]);
            
        }];


    }
    return self;
}


@end
