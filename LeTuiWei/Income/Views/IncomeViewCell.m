//
//  IncomeViewCell.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/21.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "IncomeViewCell.h"

@interface IncomeViewCell()


@property (nonatomic, strong) UILabel * seperatorLabel;

@property (nonatomic, strong) UILabel * seperatorLabel1;

@end

@implementation IncomeViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withDataSource:(id)dataSource withCellType:(IncomeViewCellType)cellType {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier components:ATCommenCellComponentEmpty];
    self.opaque = YES;
    if (self) {
        [self creatCellView:dataSource withCellType:cellType];
           
    }
    return self;
}

-(void)creatCellView:(id)dataSource withCellType:(IncomeViewCellType)type {
    WS(weakSelf);
    self.seperatorLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.seperatorLabel .backgroundColor = [Theme colorBlackWithAlpha:0.3];
    [self.contentView addSubview:self.seperatorLabel ];
    
    
    [self.seperatorLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).offset([Theme paddingWithSize32]);
        make.right.equalTo(weakSelf.contentView).offset(-[Theme paddingWithSize32]);
        make.height.equalTo(@(kSeparatorHeight));
        make.centerY.equalTo(weakSelf.contentView.mas_centerY);
    }];
    
    self.seperatorLabel1 = [[UILabel alloc] initWithFrame:CGRectZero];

    self.seperatorLabel1 .backgroundColor = [Theme colorBlackWithAlpha:0.3];
    [self.contentView addSubview:self.seperatorLabel1 ];
    
    
    [self.seperatorLabel1  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.seperatorLabel.mas_bottom).offset([Theme paddingWithSize20]);
        make.centerX.equalTo(weakSelf.contentView);
        make.bottom.equalTo(weakSelf.contentView).offset(-[Theme paddingWithSize20]);
        make.width.equalTo(@(kSeparatorHeight));
    }];
    
    UIButton *clickButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [clickButton setTitle:@"明细" forState:UIControlStateNormal];
    [clickButton setTitleColor:[Theme colorDimGray] forState:UIControlStateNormal];
    clickButton.titleLabel.font = [Theme fontWithSize24];
    [clickButton setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
    [self.contentView addSubview:clickButton];
    [clickButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.contentView).offset(-[Theme paddingWithSize40]);
        make.centerY.equalTo(weakSelf.contentView.mas_centerY).multipliedBy(0.5);
    }];
    CGSize size = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) textFont: [Theme fontWithSize28] aimString:@"明细"];
    clickButton.imageEdgeInsets = UIEdgeInsetsMake(0,size.width , 0, -(size.width));
    clickButton.titleEdgeInsets = UIEdgeInsetsMake(0, -([UIImage imageNamed:@"arrow"].size.width), 0, [UIImage imageNamed:@"arrow"].size.width);
    

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView.image = [UIImage imageNamed:@"income_fill"];
    [self.contentView addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).offset([Theme paddingWithSize32]);
        make.centerY.equalTo(weakSelf.contentView.mas_centerY).multipliedBy(0.5);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.textColor = [Theme colorDarkGray];
    titleLabel.font = [Theme fontWithSize28];
    [self.contentView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(imageView);
        make.left.equalTo(imageView.mas_right).offset([Theme paddingWithSize20]);
        
    }];
    
    
    UILabel *orderQuantity = [[UILabel alloc] initWithFrame:CGRectZero];
    orderQuantity.textColor = [Theme colorDarkGray];
    orderQuantity.font = [Theme fontWithSize28];
    [self.contentView addSubview:orderQuantity];
    
    [orderQuantity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).offset([Theme paddingWithSize32]);
        make.centerY.equalTo(weakSelf.contentView.mas_centerY).multipliedBy(1.5);
    }];
    
    UILabel *moneyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    moneyLabel.textColor = [Theme colorDarkGray];
    moneyLabel.font = [Theme fontWithSize28];
    [self.contentView addSubview:moneyLabel];
    
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.contentView).offset(-[Theme paddingWithSize32]);
        make.centerY.equalTo(weakSelf.contentView.mas_centerY).multipliedBy(1.5);
    }];
    
    NSString *orderQuantityTitle = nil;
    NSString *orderQuantityValue = nil;
    NSString *moneyTitle = nil;
    NSString *moneyValue = nil;
    
    switch (type) {
        case IncomeViewCellLineBottomStore: {
             titleLabel.text = @"线下门店";
             orderQuantityTitle = @"收入笔数:";
             orderQuantityValue = @"123";
             moneyTitle = @"金额:";
             moneyValue = @"23435";
        }
            
            break;
        case IncomeViewCellLineUpH5Object: {
             titleLabel.text = @"线上H5电商实物类";
             orderQuantityTitle = @"订单数:";
             orderQuantityValue = @"123";
             moneyTitle = @"金额:";
             moneyValue = @"23435";
            
        }
            
            break;
        case IncomeViewCellLineUpH5Serve: {
             titleLabel.text = @"线上H5电商服务类";
             orderQuantityTitle = @"订单数:";
             orderQuantityValue = @"123";
             moneyTitle = @"收入金额:";
             moneyValue = @"23435";
        }
            
            break;
    }
    
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@", orderQuantityTitle, orderQuantityValue]];
    
    [attrStr setAttributes:@{NSForegroundColorAttributeName : [Theme colorForAppearance]} range:NSMakeRange(orderQuantityTitle.length, orderQuantityValue.length)];
    orderQuantity.attributedText = attrStr;
    
    
    NSMutableAttributedString *attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@", moneyTitle, moneyValue]];
    
    [attrStr1 setAttributes:@{NSForegroundColorAttributeName : [Theme colorForAppearance]} range:NSMakeRange(moneyTitle.length, moneyValue.length)];
    moneyLabel.attributedText = attrStr1;
    
}


#pragma mark 返回字符串尺寸
- (CGSize)sizeOfStringWithMaxSize:(CGSize)maxSize textFont:(UIFont *)fontSize aimString:(NSString *)aimString{
    
    
    return [[NSString stringWithFormat:@"%@",aimString] boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:fontSize} context:nil].size;
    
}

@end
