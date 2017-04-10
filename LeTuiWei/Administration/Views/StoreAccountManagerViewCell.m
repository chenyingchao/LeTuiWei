//
//  StoreAccountManagerViewCell.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/1.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "StoreAccountManagerViewCell.h"

@interface StoreAccountManagerViewCell()

@property(nonatomic, strong) UILabel *storeNameLabel;

@property(nonatomic, strong) UILabel *accountLabel;

@property(nonatomic, strong) UILabel *contentLabel;

@property(nonatomic, strong) UIImageView *arrowImageView;

@property(nonatomic, strong) UILabel *changeLabel;

@property(nonatomic, strong) UILabel *marketingLabel;

@property(nonatomic, strong) UILabel *explainLabel;

@property(nonatomic, strong) UIButton *openButton;

@property(nonatomic, strong)  UILabel *expiredLabel;

@property(nonatomic, strong) UILabel *titleLabel;

@property(nonatomic, assign) BOOL isOpenFunction;

@property(nonatomic, assign) BOOL isExpireFunction;

@property(nonatomic, strong) UIButton *renewButton;



@end

@implementation StoreAccountManagerViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withDataSource:(id)dataSource cellType:(AccountManagerCellType)type {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier components:ATCommenCellComponentEmpty];
    self.opaque = YES;
    if (self) {
       
        switch (type) {
            case AccountManagerCellTypeStoreName:
                [self storeNameView:dataSource];
                break;
            case AccountManagerCellTypeAccount:
                [self accountViewWithDataScource:dataSource cellType:type];
                break;
            case AccountManagerCellTypePassword:
                [self accountViewWithDataScource:dataSource cellType:type];
                break;
            case AccountManagerCellTypeMarketing:
                [self paymentFunctionWithCellType:type];
                break;
            case AccountManagerCellTypeOrderTaking:
                [self paymentFunctionWithCellType:type];
                break;
                
            default:
                [self BasicFunctionView:type withDataSource:dataSource];
                break;
        }
    }
    return self;
}

- (void)storeNameView:(NSString *)storeName {
    WS(weakSelf);
    self.storeNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.storeNameLabel.text = storeName;
    self.storeNameLabel.font = [Theme fontWithSize30];
    self.storeNameLabel.textColor = [Theme colorDarkGray];
    [self.contentView addSubview:self.storeNameLabel];
    [self.storeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(weakSelf.contentView);
        make.height.equalTo(@([Theme paddingWithSize:84]));
    }];
    self.unfoldButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.unfoldButton setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
    [self.unfoldButton setImage:[UIImage imageNamed:@"up"] forState:UIControlStateSelected];
    [self.contentView addSubview:self.unfoldButton];
    [self.unfoldButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.storeNameLabel.mas_right).offset([Theme paddingWithSize10]);
        make.centerY.equalTo(weakSelf.storeNameLabel);
    }];
    
//    [self.unfoldButton bk_whenTapped:^{
//        weakSelf.unfoldButton.selected = !weakSelf.unfoldButton.selected;
//    }];
    

}

- (void)accountViewWithDataScource:(id)dataScource cellType:(AccountManagerCellType)type {
    WS(weakSelf);
    self.accountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.accountLabel.text = type == AccountManagerCellTypeAccount ? @"当前账号: ":@"密码:";
    self.accountLabel.font = [Theme fontWithSize30];
    self.accountLabel.textColor = [Theme colorDimGray];
    [self.contentView addSubview:self.accountLabel];
    [self.accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.height.equalTo(@([Theme paddingWithSize:100]));
        make.left.equalTo(weakSelf.contentView).offset([Theme paddingWithSize32]);
    }];
    
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.contentLabel.text = @"xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
    self.contentLabel.font = [Theme fontWithSize30];
    self.contentLabel.textColor = [Theme colorDarkGray];
    [self.contentView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.height.equalTo(@([Theme paddingWithSize:100]));
        make.left.equalTo(weakSelf.accountLabel.mas_right).offset([Theme paddingWithSize20]);

    }];
    
    self.arrowImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    self.arrowImageView.image = [UIImage imageNamed:@"arrow"];
    [self.contentView addSubview:self.arrowImageView];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.right.equalTo(weakSelf.contentView).offset(-[Theme paddingWithSize32]);
        make.height.equalTo(@([UIImage imageNamed:@"arrow"].size.height));
        make.width.equalTo(@([UIImage imageNamed:@"arrow"].size.width));
        
    }];
    
    self.changeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.changeLabel.text = type == AccountManagerCellTypeAccount ? @"切换账号" : @"修改密码";
    self.changeLabel.userInteractionEnabled = YES;
    self.changeLabel.font = [Theme fontWithSize24];
    self.changeLabel.textColor = [Theme colorDimGray];
    [self.contentView addSubview:self.changeLabel];
    [self.changeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.right.equalTo(weakSelf.arrowImageView.mas_left).offset(-[Theme paddingWithSize20]);
        make.left.equalTo(weakSelf.contentLabel.mas_right).offset([Theme paddingWithSize40]);
    }];
    
    [self.accountLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    [self.changeLabel bk_whenTapped:^{
        
        if (weakSelf.changeButtonClickedBlock) {
            weakSelf.changeButtonClickedBlock(type);
        }
    }];
    
    
}

- (void)paymentFunctionWithCellType:(AccountManagerCellType)type {
    WS(weakSelf);
    
    self.isOpenFunction = type == AccountManagerCellTypeMarketing ? YES:YES;
    self.isExpireFunction = type == AccountManagerCellTypeMarketing ? NO:YES;
    
    self.marketingLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.marketingLabel.text = type == AccountManagerCellTypeMarketing ? @"会员营销: ":@"外卖多平台接单";
    self.marketingLabel.font = [Theme fontWithSize30];
    self.marketingLabel.textColor = [Theme colorDarkGray];
    [self.contentView addSubview:self.marketingLabel];
    [self.marketingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView).offset([Theme paddingWithSize36]);
        make.left.equalTo(weakSelf.contentView).offset([Theme paddingWithSize32]);
    }];
    
    
    self.explainLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.explainLabel.text = type == AccountManagerCellTypeMarketing ? @"可在收银机端为顾客下单、顾客支付及成为会员 ":@"实现多平台同时自动接单打印";
    self.explainLabel.font = [Theme fontWithSize24];
    self.explainLabel.textColor = [Theme colorDimGray];
    self.explainLabel.numberOfLines = 0;
    [self.contentView addSubview:self.explainLabel];
    [self.explainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.marketingLabel.mas_bottom).offset([Theme paddingWithSize20]);
        make.left.equalTo(weakSelf.contentView).offset([Theme paddingWithSize32]);
        if (!weakSelf.isOpenFunction) {
            make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-[Theme paddingWithSize36]);
        }
        make.width.equalTo(@([Theme paddingWithSize:350]));
    }];

    self.openButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.openButton setTitle:@"查看并开通" forState:UIControlStateNormal];
    [self.openButton setTitleColor:UIColorFromRGB(0x3f88cd) forState:UIControlStateNormal];
    self.openButton.titleLabel.font = [Theme fontWithSize24];
    self.openButton.layer.cornerRadius = 5;
    self.openButton.layer.masksToBounds = YES;
    self.openButton.layer.borderWidth = 1;
    self.openButton.layer.borderColor = UIColorFromRGB(0x3f88cd).CGColor;
    [self.contentView addSubview:self.openButton];
    [self.openButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.explainLabel);
        make.right.equalTo(weakSelf.contentView.mas_right).offset(-[Theme paddingWithSize32]);
        make.width.equalTo(@([Theme paddingWithSize:160]));
        make.height.equalTo(@([Theme paddingWithSize:54]));
    }];
    
    
   
    self.expiredLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.expiredLabel.text = self.isExpireFunction ? @"已经过期 请及时续费" : @"一开通过，有限期到2020-11-11";

    self.expiredLabel.font = [Theme fontWithSize24];
    self.expiredLabel.textColor = UIColorFromRGB(0x31c07a);
    self.expiredLabel.numberOfLines = 0;
    [self.contentView addSubview:self.expiredLabel];
    [self.expiredLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.explainLabel.mas_bottom).offset([Theme paddingWithSize20]);
        make.left.equalTo(weakSelf.contentView).offset([Theme paddingWithSize32]);
        make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-[Theme paddingWithSize36]);
        make.width.equalTo(@([Theme paddingWithSize:350]));
    }];
    self.explainLabel.hidden = YES;
   //如果已经开通
    if (self.isOpenFunction) {
      self.explainLabel.hidden = NO;

        //过期
        if (self.isExpireFunction) {
            self.expiredLabel.textColor = UIColorFromRGB(0xff6600);
           [self.openButton setTitle:@"续费开通" forState:UIControlStateNormal];
        } else {
        
            
            self.renewButton = [[UIButton alloc] initWithFrame:CGRectZero];
            [self.renewButton setTitle:@"点此续费" forState:UIControlStateNormal];
            [self.renewButton setTitleColor:UIColorFromRGB(0x3f88cd) forState:UIControlStateNormal];
            self.renewButton.titleLabel.font = [Theme fontWithSize24];
            self.renewButton.layer.borderColor = UIColorFromRGB(0x3f88cd).CGColor;
            [self.contentView addSubview:self.renewButton];
            [self.renewButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(weakSelf.expiredLabel);
                make.left.equalTo(weakSelf.expiredLabel.mas_right).offset([Theme paddingWithSize32]);
            }];
            
        
        }
    }
    

    [self.openButton bk_whenTapped:^{
        weakSelf.openButtonClickedBlock(type);
    }];
    
    
    
}

- (void)BasicFunctionView:(AccountManagerCellType)type withDataSource:(id)dataSource{
    WS(weakSelf);
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.text = dataSource[@"title"];
    self.titleLabel.font = [Theme fontWithSize30];
    self.titleLabel.textColor = [Theme colorDarkGray];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView).offset([Theme paddingWithSize36]);
        make.left.equalTo(weakSelf.contentView).offset([Theme paddingWithSize32]);
    }];
    
    
    self.explainLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.explainLabel.text = dataSource[@"content"];
    self.explainLabel.font = [Theme fontWithSize24];
    self.explainLabel.textColor = [Theme colorDimGray];
    self.explainLabel.numberOfLines = 0;
    [self.contentView addSubview:self.explainLabel];
    [self.explainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset([Theme paddingWithSize20]);
        make.left.equalTo(weakSelf.contentView).offset([Theme paddingWithSize32]);
        make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-[Theme paddingWithSize36]);
        make.width.equalTo(@([Theme paddingWithSize:350]));
    }];

}


@end
