//
//  IncomeDataViewCell.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/26.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "IncomeDataViewCell.h"

@interface IncomeDataViewCell()

@property (nonatomic, strong) UIImageView *headerImageView;

@property (nonatomic, strong) UILabel *moneyLabel;

@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, strong) UILabel *channelLabel;

@property (nonatomic, strong) UILabel *orderNumberLabel;

@property (nonatomic, strong) UILabel *productQuantityLabel;

@property (nonatomic, strong) UILabel *vipTopUpLabel;


@end

@implementation IncomeDataViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier components:ATCommenCellComponentEmpty];
    self.opaque = YES;
    if (self) {
        [self initCellView];
        
    }
    return self;
}

- (void)initCellView {
    WS(weakSelf);
    self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:self.headerImageView];
    self.headerImageView.image = [UIImage imageNamed:@"weixin"];
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.left.equalTo(weakSelf.contentView).offset([Theme paddingWithSize40]);
    }];
    
    self.moneyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.moneyLabel.font = [Theme fontWithSize28];
    self.moneyLabel.textColor = [Theme colorDarkGray];
    [self.contentView addSubview:self.moneyLabel];
    self.moneyLabel.text = @"￥3004.0";
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.headerImageView.mas_right).offset([Theme  paddingWithSize28]);
        make.top.equalTo(weakSelf.headerImageView);
        
    }];
    
    self.dateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.dateLabel.font = [Theme fontWithSize20];
    self.dateLabel.textColor = [Theme colorDimGray];
    [self.contentView addSubview:self.dateLabel];
    self.dateLabel.text = @"10:12:00";
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.headerImageView.mas_right).offset([Theme  paddingWithSize28]);
        make.top.equalTo(weakSelf.moneyLabel.mas_bottom).offset([Theme paddingWithSize10]);
        
    }];
    
    self.channelLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.channelLabel.font = [Theme fontWithSize20];
    self.channelLabel.textColor = [Theme colorDimGray];
    [self.contentView addSubview:self.channelLabel];
    self.channelLabel.text = @"来自收银机";
    [self.channelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.dateLabel.mas_right).offset([Theme  paddingWithSize20]);
        make.top.equalTo(weakSelf.moneyLabel.mas_bottom).offset([Theme paddingWithSize10]);
        
    }];
    
    self.orderNumberLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.orderNumberLabel.font = [Theme fontWithSize28];
    self.orderNumberLabel.textColor = [Theme colorDarkGray];
    [self.contentView addSubview:self.orderNumberLabel];
    self.orderNumberLabel.text = @"订单A1";
    [self.orderNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.contentView.mas_right).offset(-[Theme  paddingWithSize32]);
        make.top.equalTo(weakSelf.contentView).offset([Theme paddingWithSize32]);
        
    }];
    
    self.productQuantityLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.productQuantityLabel.font = [Theme fontWithSize20];
    self.productQuantityLabel.textColor = [Theme colorDimGray];
    [self.contentView addSubview:self.productQuantityLabel];
    self.productQuantityLabel.text = @"含2个商品";
    [self.productQuantityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.contentView.mas_right).offset(-[Theme  paddingWithSize32]);
        make.top.equalTo(weakSelf.orderNumberLabel.mas_bottom).offset([Theme paddingWithSize10]);
        
    }];

}

- (void)creatCellView:(id)dataSource withCellType:(IncomeDataViewCellType)type {
    WS(weakSelf);
    switch (type) {
        case IncomeDataViewCellTypeHaveProductQuantity: {
        
             self.productQuantityLabel.hidden = NO;
            [self.orderNumberLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(weakSelf.contentView.mas_right).offset(-[Theme  paddingWithSize32]);
                make.top.equalTo(weakSelf.contentView).offset([Theme paddingWithSize32]);
                
            }];
            self.orderNumberLabel.text = @"订单A1";
        
        }
            
            break;
            
        case IncomeDataViewCellTypeNoProductQuantity: {
        
            self.productQuantityLabel.hidden = YES;
            [self.orderNumberLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(weakSelf.contentView.mas_right).offset(-[Theme  paddingWithSize32]);
                make.centerY.equalTo(weakSelf.contentView);
                
            }];
            self.orderNumberLabel.text = @"订单A1";
        }
            
            break;
            
        case IncomeDataViewCellTypeVIpTopUp: {
            self.productQuantityLabel.hidden = YES;
            [self.orderNumberLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(weakSelf.contentView.mas_right).offset(-[Theme  paddingWithSize32]);
                make.centerY.equalTo(weakSelf.contentView);
                
            }];
            self.orderNumberLabel.text = @"会员充值";
            
        }
            
            break;
            
        default:
            break;
    }


}

@end
