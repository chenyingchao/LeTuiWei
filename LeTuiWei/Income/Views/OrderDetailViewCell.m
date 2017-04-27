//
//  OrderDetailViewCell.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/26.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "OrderDetailViewCell.h"



@implementation OrderDetailViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withDataSource:(id)dataSource withCellType:(OrderDetailViewCellType)cellType {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier components:ATCommenCellComponentEmpty];
    self.opaque = YES;
    if (self) {

        switch (cellType) {
            case OrderDetailViewCellTypeOrderNumber:{
                [self creatHeaderView:dataSource];
            }
        
                break;
            case OrderDetailViewCellTypeOrderProduct:{
                [self creatOrderProductsView:dataSource];
            }
                
                break;
                
            case OrderDetailViewCellTypeOrderMoney:{
                [self creatOrderMoneyView:dataSource];
            }
                
                break;
                
            case OrderDetailViewCellTypeSecondSection: {
            
                [self createSecondSectionView:dataSource];
            }
                
                break;
        }
    }
    return self;
}


- (void)creatOrderMoneyView:(id)dataSource {

    WS(weakSelf);
    UILabel *totalMoneyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    totalMoneyLabel.font = [Theme fontWithSize28];
    totalMoneyLabel.textColor = [Theme colorGray];
    [self.contentView addSubview:totalMoneyLabel];
    totalMoneyLabel.text = @"总金额:1000";
    [totalMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakSelf.contentView).offset(-[Theme paddingWithSize40]);
        make.top.equalTo(weakSelf.contentView).offset([Theme paddingWithSize40]);

    }];
    
    BOOL haveDiscount = YES;
    UIView *temp = totalMoneyLabel;
    if (haveDiscount) {
        
        UILabel *discountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        discountLabel.font = [Theme fontWithSize28];
        discountLabel.textColor = [Theme colorGray];
        [self.contentView addSubview:discountLabel];
        discountLabel.text = @"会员8.5折:-20";
        [discountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(weakSelf.contentView).offset(-[Theme paddingWithSize40]);
            make.top.equalTo(totalMoneyLabel.mas_bottom).offset([Theme paddingWithSize10]);
            
        }];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageView.image = [UIImage imageNamed:@"VIPlogo"];
        [self.contentView addSubview:imageView];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(discountLabel.mas_left).offset(-[Theme paddingWithSize10]);
            make.centerY.equalTo(discountLabel);
            
        }];
        
        temp = discountLabel;
    }
    
    
    UILabel *realityMoneyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    realityMoneyLabel.font = [Theme fontWithSize28];
    realityMoneyLabel.textColor = [Theme colorGray];
    [self.contentView addSubview:realityMoneyLabel];
    realityMoneyLabel.text = @"实际金额:400";
    [realityMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakSelf.contentView).offset(-[Theme paddingWithSize40]);
        make.top.equalTo(temp.mas_bottom).offset([Theme paddingWithSize10]);
        make.bottom.equalTo(weakSelf.contentView).offset(-[Theme paddingWithSize40]);
    }];

    

}

- (void)creatOrderProductsView:(id)dataSource {
    WS(weakSelf);
    
    UIView *tempView = nil;
    
    for (NSInteger i = 0; i < 3; i++ ) {
        
        UILabel *productNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        productNameLabel.font = [Theme fontWithSize28];
        productNameLabel.textColor = [Theme colorDarkGray];
        [self.contentView addSubview:productNameLabel];
        productNameLabel.text = @"可乐";
        [productNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(weakSelf.contentView).offset([Theme paddingWithSize40]);
            if (!tempView) {
               make.top.equalTo(weakSelf.contentView).offset([Theme paddingWithSize40]);
            } else {
               make.top.equalTo(tempView.mas_bottom).offset([Theme paddingWithSize20]);
            }
        }];
        
        UILabel *productQuantityLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        productQuantityLabel.font = [Theme fontWithSize28];
        productQuantityLabel.textColor = [Theme colorDarkGray];
        [self.contentView addSubview:productQuantityLabel];
        productQuantityLabel.text = @"x1";
        [productQuantityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(weakSelf.contentView).offset([Theme paddingWithSize40]);
            make.centerY.equalTo(productNameLabel);
            
        }];
        
        UILabel *productPriceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        productPriceLabel.font = [Theme fontWithSize28];
        productPriceLabel.textColor = [Theme colorDarkGray];
        [self.contentView addSubview:productPriceLabel];
        productPriceLabel.text = @"100";
        [productPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(weakSelf.contentView).offset(-[Theme paddingWithSize40]);
            make.centerY.equalTo(productNameLabel);
            
        }];
        
        tempView = productNameLabel;
        
    }
    
    BOOL haveTableMoney = YES;
    if (!haveTableMoney) {
        [tempView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf.contentView).offset(-[Theme paddingWithSize40]);
        }];
        return;
    }
    
    UILabel *line = [[UILabel  alloc] initWithFrame:CGRectZero];
    line.backgroundColor = [Theme colorForSeparatorLine];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf);
        make.top.equalTo(tempView.mas_bottom).offset([Theme paddingWithSize40]);
        make.height.equalTo(@(kSeparatorHeight));
    }];
    
    
    UILabel *tableLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    tableLabel.font = [Theme fontWithSize28];
    tableLabel.textColor = [Theme colorDarkGray];
    [self.contentView addSubview:tableLabel];
    tableLabel.text = @"桌台110";
    [tableLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.contentView).offset([Theme paddingWithSize40]);
        make.top.equalTo(line.mas_bottom).offset([Theme paddingWithSize40]);
    
    }];
    
    UILabel *tableDateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    tableDateLabel.font = [Theme fontWithSize28];
    tableDateLabel.textColor = [Theme colorDarkGray];
    tableDateLabel.numberOfLines = 0;
    [self.contentView addSubview:tableDateLabel];
    tableDateLabel.text = @"  2017/12/12 12:10\n至2017/12/12 14:12";
    [tableDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(tableLabel);
        make.centerX.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf.contentView).offset(-[Theme paddingWithSize40]);
        
    }];
    
    UILabel *tablePriceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    tablePriceLabel.font = [Theme fontWithSize28];
    tablePriceLabel.textColor = [Theme colorDarkGray];
    [self.contentView addSubview:tablePriceLabel];
    tablePriceLabel.text = @"100";
    [tablePriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tableLabel);
        make.right.equalTo(weakSelf.contentView).offset(-[Theme paddingWithSize40]);
    }];
    
  

    
 
    
}

- (void)creatHeaderView:(id)dataSource {
    WS(weakSelf);
    UILabel *orderNumLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    orderNumLabel.font = [Theme fontWithSize30];
    orderNumLabel.textColor = [Theme colorDarkGray];
    [self.contentView addSubview:orderNumLabel];
    orderNumLabel.text = @"订单A1";
    [orderNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.contentView).offset([Theme paddingWithSize40]);
        make.top.bottom.equalTo(weakSelf.contentView);
        make.height.equalTo(@([Theme paddingWithSize:85]));
        
    }];

}

- (void)createSecondSectionView:(id)dataSource {
    WS(weakSelf);
    UILabel *orderDateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    orderDateLabel.font = [Theme fontWithSize28];
    orderDateLabel.textColor = [Theme colorGray];
    [self.contentView addSubview:orderDateLabel];
    orderDateLabel.text = @"下单时间:";
    [orderDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(weakSelf.contentView).offset([Theme paddingWithSize40]);
        make.top.equalTo(weakSelf.contentView).offset([Theme paddingWithSize40]);
        
    }];

    
    UILabel *orderDateValueLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    orderDateValueLabel.font = [Theme fontWithSize28];
    orderDateValueLabel.textColor = [Theme colorDarkGray];
    [self.contentView addSubview:orderDateValueLabel];
    orderDateValueLabel.text = @"2017-04-23 16:12:12";
    [orderDateValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(orderDateLabel.mas_right).offset([Theme paddingWithSize10]);
        make.centerY.equalTo(orderDateLabel);
        
    }];
    
    UILabel *moneyDateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    moneyDateLabel.font = [Theme fontWithSize28];
    moneyDateLabel.textColor = [Theme colorGray];
    [self.contentView addSubview:moneyDateLabel];
    moneyDateLabel.text = @"结账时间:";
    [moneyDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.contentView).offset([Theme paddingWithSize40]);
        make.top.equalTo(orderDateLabel.mas_bottom).offset([Theme paddingWithSize20]);
        
    }];
    
    UILabel *moneyDateValueLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    moneyDateValueLabel.font = [Theme fontWithSize28];
    moneyDateValueLabel.textColor = [Theme colorDarkGray];
    [self.contentView addSubview:moneyDateValueLabel];
    moneyDateValueLabel.text = @"2017-04-23 18:12:12";
    [moneyDateValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(moneyDateLabel.mas_right).offset([Theme paddingWithSize10]);
        make.centerY.equalTo(moneyDateLabel);
        
    }];
    
    UILabel *orderNumberLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    orderNumberLabel.font = [Theme fontWithSize28];
    orderNumberLabel.textColor = [Theme colorGray];
    [self.contentView addSubview:orderNumberLabel];
    orderNumberLabel.text = @"商户单号:";
    [orderNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.contentView).offset([Theme paddingWithSize40]);
        make.top.equalTo(moneyDateLabel.mas_bottom).offset([Theme paddingWithSize20]);
        
    }];
    
    UILabel *orderNumberValueLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    orderNumberValueLabel.font = [Theme fontWithSize28];
    orderNumberValueLabel.textColor = [Theme colorDarkGray];
    [self.contentView addSubview:orderNumberValueLabel];
    orderNumberValueLabel.text = @"123454465634223423";
    [orderNumberValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(orderNumberLabel.mas_right).offset([Theme paddingWithSize10]);
        make.centerY.equalTo(orderNumberLabel);
        
    }];
    
    UILabel *paymentTypeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    paymentTypeLabel.font = [Theme fontWithSize28];
    paymentTypeLabel.textColor = [Theme colorGray];
    [self.contentView addSubview:paymentTypeLabel];
    paymentTypeLabel.text = @"付款方式:";
    [paymentTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.contentView).offset([Theme paddingWithSize40]);
        make.top.equalTo(orderNumberLabel.mas_bottom).offset([Theme paddingWithSize20]);
        make.bottom.equalTo(weakSelf.contentView).offset(-[Theme paddingWithSize:300]);
        
    }];
    
    UILabel *paymentTypeValueLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    paymentTypeValueLabel.font = [Theme fontWithSize28];
    paymentTypeValueLabel.textColor = [Theme colorDarkGray];
    [self.contentView addSubview:paymentTypeValueLabel];
    paymentTypeValueLabel.text = @"微信支付";
    [paymentTypeValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(paymentTypeLabel.mas_right).offset([Theme paddingWithSize10]);
        make.centerY.equalTo(paymentTypeLabel);
        
    }];

}

@end
