//
//  SiftViewCell.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/24.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "SiftViewCell.h"

@implementation SiftViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.opaque = YES;
    if (self) {
        WS(weakSelf);
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.contentLabel.font = [Theme fontWithSize28];
        self.contentLabel.textColor =  [Theme colorDarkGray];;
        [self.contentView addSubview: self.contentLabel];
        [ self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf);
            make.centerY.height.equalTo(weakSelf);
            
        }];
        
        self.seperatorLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.seperatorLabel.backgroundColor = [Theme colorForSeparatorLine];
        [self.contentView addSubview: self.seperatorLabel];
        [self.seperatorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.contentView).offset([Theme paddingWithSize32]);
            make.right.equalTo(weakSelf.contentView).offset(-[Theme paddingWithSize32]);
            make.height.equalTo(@(0.5));
            make.bottom.equalTo(weakSelf.mas_bottom);
        }];
        
    }
    return self;
}


@end
