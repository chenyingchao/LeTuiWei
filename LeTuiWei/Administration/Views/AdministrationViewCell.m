//
//  AdministrationViewCell.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/3/30.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "AdministrationViewCell.h"
#import "AdministrationViewModel.h"
@implementation AdministrationViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withDataSource:(id)dataSource withCellType:(AdministrationViewCellType)cellType {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier components:ATCommenCellComponentEmpty];
    self.opaque = YES;
    if (self) {
        [self creatCommonCellWithData:dataSource];
    }
    return self;
}

- (void)creatCommonCellWithData:(id)dataSource {
    
    WS(weakSelf);
    AdministrationViewModel *model = dataSource;
    UIImageView *headerImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    headerImageView.image = [UIImage imageNamed:model.headerImage];
    [self.contentView addSubview:headerImageView];
    [headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).offset([Theme paddingWithSize32]);
        make.centerY.equalTo(weakSelf.contentView);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.text = model.headerTitle;
    titleLabel.font = [Theme fontWithSize30];
    titleLabel.textColor = [Theme colorDarkGray];
    [self.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerImageView.mas_right).offset([Theme paddingWithSize20]);
        make.centerY.equalTo(weakSelf.contentView);
    }];
    
    
    UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    arrowImageView.image = [UIImage imageNamed:@"arrow"];
    [self.contentView addSubview:arrowImageView];
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.contentView).offset(-[Theme paddingWithSize40]);
        make.centerY.equalTo(weakSelf.contentView);
    }];
    
    
    if (model.rightLabel.length > 0) {
        UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        rightLabel.text = model.rightLabel;
        rightLabel.font = [Theme fontWithSize28];
        rightLabel.textColor = [Theme colorDimGray];
        [self.contentView addSubview:rightLabel];
        [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(arrowImageView.mas_left).offset(-[Theme paddingWithSize20]);
            make.centerY.equalTo(weakSelf.contentView);
        }];
    }
    

}


@end
