//
//  StoresListViewCell.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/3/31.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "StoresListViewCell.h"

@interface StoresListViewCell()

@property (nonatomic, strong) UILabel *storeNameLabel;

@property (nonatomic, strong) UIImageView *editImageView;

@property (nonatomic, strong) UILabel *operateCategoriesLabel;

@property (nonatomic, strong) UILabel *personCapitaLabel;

@property (nonatomic, strong) UILabel *phoneNumLabel;

@property (nonatomic, strong) UIImageView *coordinateImageView;

@property (nonatomic, strong) UILabel *detailAddressLabel;


@property (nonatomic, strong) UIImageView *arrowImageView;



@end

@implementation StoresListViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier components:ATCommenCellComponentEmpty];
    self.opaque = YES;
    if (self) {
        [self creatOrderView];
    }
    return self;
}

- (void)creatOrderView {
    WS(weakSelf);
    self.storeNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.storeNameLabel.text = @"麻辣香锅";
    self.storeNameLabel.font = [Theme fontWithSize30];
    self.storeNameLabel.textColor = [Theme colorDarkGray];
    [self.contentView addSubview:self.storeNameLabel];
    [self.storeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).offset([Theme paddingWithSize32]);
        make.top.equalTo(weakSelf.contentView).offset([Theme paddingWithSize32]);
    }];
    
    self.editImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.editImageView.image = [UIImage imageNamed:@"edit"];
    [self.contentView addSubview:self.editImageView];
    
    [self.editImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.contentView).offset(-[Theme paddingWithSize32]);
        make.top.equalTo(weakSelf.contentView).offset([Theme paddingWithSize32]);
   
    }];

    self.operateCategoriesLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.operateCategoriesLabel.text = @"香菜 羊肉 黄瓜";
    self.operateCategoriesLabel.font = [Theme fontWithSize28];
    self.operateCategoriesLabel.textColor = [Theme colorDimGray];
    [self.contentView addSubview:self.operateCategoriesLabel];
    [self.operateCategoriesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).offset([Theme paddingWithSize32]);
        make.top.equalTo(weakSelf.storeNameLabel.mas_bottom).offset([Theme paddingWithSize24]);
    }];
    
    self.personCapitaLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.personCapitaLabel.text = @"人均80元";
    self.personCapitaLabel.font = [Theme fontWithSize28];
    self.personCapitaLabel.textColor = [Theme colorDimGray];
    [self.contentView addSubview:self.personCapitaLabel];
    [self.personCapitaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).offset([Theme paddingWithSize32]);
        make.top.equalTo(weakSelf.operateCategoriesLabel.mas_bottom).offset([Theme paddingWithSize24]);
    }];
    
    self.phoneNumLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.phoneNumLabel.text = @"18500106512";
    self.phoneNumLabel.font = [Theme fontWithSize28];
    self.phoneNumLabel.textColor = [Theme colorDimGray];
    [self.contentView addSubview:self.phoneNumLabel];
    [self.phoneNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.personCapitaLabel.mas_right).offset([Theme paddingWithSize32]);
        make.top.equalTo(weakSelf.operateCategoriesLabel.mas_bottom).offset([Theme paddingWithSize24]);
    }];
    
    UILabel * seperatorLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    seperatorLabel.backgroundColor = [Theme colorBlackWithAlpha:0.3];
    [self.contentView addSubview:seperatorLabel];

    [seperatorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).offset([Theme paddingWithSize32]);
        make.right.equalTo(weakSelf.contentView).offset(-[Theme paddingWithSize32]);
        make.height.equalTo(@(kSeparatorHeight));
        make.top.equalTo(weakSelf.personCapitaLabel.mas_bottom).offset([Theme paddingWithSize24]);
    }];
    
    self.coordinateImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.coordinateImageView.image = [UIImage imageNamed:@"location"];
    [self.contentView addSubview:self.coordinateImageView];
    
    [self.coordinateImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).offset([Theme paddingWithSize32]);
        
        make.top.equalTo(seperatorLabel.mas_bottom).offset([Theme paddingWithSize24]);
        make.height.equalTo(@([UIImage imageNamed:@"location"].size.height));
        make.width.equalTo(@([UIImage imageNamed:@"location"].size.width));

    }];
//    

    
    self.detailAddressLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.detailAddressLabel.text = @"北京人民大会堂b-2 北京人民大会堂b-2北京人民大会堂b-2北京人民大会堂b-2北京人民大会堂b-2北京人民大会堂b-2";
    self.detailAddressLabel.font = [Theme fontWithSize28];
    self.detailAddressLabel.numberOfLines = 0;
    self.detailAddressLabel.textColor = [Theme colorDimGray];
    [self.contentView addSubview:self.detailAddressLabel];
    [self.detailAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.coordinateImageView.mas_right).offset([Theme paddingWithSize24]);
        make.right.equalTo(weakSelf.contentView.mas_right).offset(-[Theme paddingWithSize:60] - [UIImage imageNamed:@"arrow"].size.width);
        make.top.equalTo(seperatorLabel.mas_bottom).offset([Theme paddingWithSize24]);
        make.bottom.equalTo(weakSelf.contentView).offset(-[Theme paddingWithSize32]);
    }];
    
    self.arrowImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.arrowImageView.image = [UIImage imageNamed:@"arrow"];
    [self.contentView addSubview:self.arrowImageView];
    
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.contentView).offset(-[Theme paddingWithSize32]);
        make.centerY.equalTo(weakSelf.detailAddressLabel);
    }];

}

@end
