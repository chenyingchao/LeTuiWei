//
//  VipMarketingViewCell.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/6.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "VipMarketingViewCell.h"
#import "ConfirmButtonView.h"

@interface VipMarketingViewCell()

@property(nonatomic, strong) UILabel *titleLabel;

@property(nonatomic, strong) UILabel *contentLabel;

@property(nonatomic, strong) UIButton *openButton;

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation VipMarketingViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withDataSource:(id)dataSource cellType:(VipMarketingViewCellType)type{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier components:ATCommenCellComponentEmpty];
    self.opaque = YES;
    if (self) {
        if (type == VipMarketingViewCellTypeTitle) {
            [self createTitleSetcion:dataSource];
        } else if (type == VipMarketingViewCellTypeItemTitle) {
        
            [self createItemTitle:dataSource];
        } else if (type == VipMarketingViewCellTypeSingleFunction) {
            
            [self itemContentView:type];
        } else if (type == VipMarketingViewCellTypeVipSystem) {
            
            [self itemContentView:type];
        } else if (type == VipMarketingViewCellTypeFunctionImages) {
            
            [self itemContentOnlyIamgesView:type];
        }
 
    }
    return self;
}


- (void)createTitleSetcion:(id)dataSource {
    
    WS(weakSelf);
    NSArray *dataAarry = dataSource;
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.text = dataAarry.firstObject ;
    self.titleLabel.font = [Theme fontWithSize30];
    self.titleLabel.textColor = [Theme colorDarkGray];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).offset([Theme paddingWithSize32]);
        make.top.equalTo(weakSelf.contentView).offset([Theme paddingWithSize40]);
    }];
    
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.contentLabel.text = dataAarry.lastObject;
    self.contentLabel.font = [Theme fontWithSize24];
    self.contentLabel.textColor = [Theme colorDimGray];
    self.contentLabel.numberOfLines = 0;
    [self.contentView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).offset([Theme paddingWithSize32]);
        make.right.equalTo(weakSelf.contentView).offset(-[Theme paddingWithSize32]);
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset([Theme paddingWithSize32]);
    }];

    ConfirmButtonView *submitView = [ConfirmButtonView confirmButtonViewWithTitle:@"立即开通" andButtonClickedBlock:^(UIButton *button) {
        weakSelf.immediateOpeningButtonBlock();
    }];
    [self.contentView addSubview:submitView];
    [submitView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(weakSelf.contentView).offset([Theme paddingWithSize32]);
        make.right.equalTo(weakSelf.contentView).offset(-[Theme paddingWithSize32]);
        make.top.equalTo(weakSelf.contentLabel.mas_bottom).offset([Theme paddingWithSize40]);
        make.bottom.equalTo(weakSelf.contentView).offset(-[Theme paddingWithSize40]);
        make.height.equalTo(@([Theme paddingWithSize:96]));
    }];
}


- (void)createItemTitle:(NSString *)title {
    WS(weakSelf);
    UIView *logoView = [[UIView alloc] initWithFrame:CGRectZero];
    logoView.backgroundColor = [Theme colorForAppearance];
    [self.contentView addSubview:logoView];
    [logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView);
        make.centerY.equalTo(weakSelf.contentView);
        make.width.equalTo(@([Theme paddingWithSize:6]));
        make.height.equalTo(@([Theme paddingWithSize:48]));
    }];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.text = title;
    self.titleLabel.font = [Theme fontWithSize30];
    self.titleLabel.textColor = [Theme colorForAppearance];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).offset([Theme paddingWithSize32]);
        make.centerY.equalTo(weakSelf.contentView);
        make.height.equalTo(@([Theme paddingWithSize:80]));
    }];
    
}

- (void)itemContentView:(VipMarketingViewCellType)type {

    WS(weakSelf);
    
    NSString *titleStr = type == VipMarketingViewCellTypeSingleFunction ? @"不仅收银，还提供具体商品下单（例如餐饮行业的点菜）。账单不仅提供收款流水，还提供商品详细信息，并依次数据分析消费偏好。适合行业全面广泛（如餐饮、商超、旅游住宿等）。" : @"根据商品消费数据分析，进行精准会员营销，提高客单价和复购率。";
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.text = titleStr;
    self.titleLabel.font = [Theme fontWithSize30];
    self.titleLabel.textColor = [Theme colorDimGray];
    self.titleLabel.numberOfLines = 0;
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).offset([Theme paddingWithSize32]);
        make.right.equalTo(weakSelf.contentView).offset(-[Theme paddingWithSize32]);
        make.top.equalTo(weakSelf.contentView).offset([Theme paddingWithSize40]);
       
    }];
    
    NSArray *imageArray = type == VipMarketingViewCellTypeSingleFunction?@[@"case_order1",@"case_order2",@"case_order3"] :  @[@"case_vip1",@"case_vip2",@"case_vip3"];;
    
   
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.contentView addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.contentView);
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset([Theme paddingWithSize40]);
        make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-[Theme paddingWithSize40]);
        make.height.equalTo(@([UIImage imageNamed:@"case_order1"].size.height));
    }];
    
    
    self.scrollView.contentSize = CGSizeMake([UIImage imageNamed:@"case_order1"].size.width * imageArray.count + [Theme paddingWithSize28] * imageArray.count - 1, [UIImage imageNamed:@"case_order1"].size.height);
    
    for (int i = 0; i < imageArray.count; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        
        imageView.frame = CGRectMake(i * [UIImage imageNamed:@"case_order1"].size.width + i * [Theme paddingWithSize28] , 0, [UIImage imageNamed:@"case_order1"].size.width, [UIImage imageNamed:@"case_order1"].size.height);
   
        imageView.image = [UIImage imageNamed:imageArray[i]];
        
        [self.scrollView addSubview:imageView];
        
    }
    
}

- (void)itemContentOnlyIamgesView:(VipMarketingViewCellType)type {
    
    WS(weakSelf);

    
    NSArray *imageArray = @[@"case_takeout1",@"case_takeout2",@"case_takeout3"];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.contentView addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.contentView);
        make.top.equalTo(weakSelf.contentView.mas_top).offset([Theme paddingWithSize40]);
        make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-[Theme paddingWithSize40]);
        make.height.equalTo(@([UIImage imageNamed:@"case_order1"].size.height));
    }];
    
    
    self.scrollView.contentSize = CGSizeMake([UIImage imageNamed:@"case_order1"].size.width * imageArray.count + [Theme paddingWithSize28] * imageArray.count - 1, [UIImage imageNamed:@"case_order1"].size.height);
    
    for (int i = 0; i < imageArray.count; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        
        imageView.frame = CGRectMake(i * [UIImage imageNamed:@"case_order1"].size.width + i * [Theme paddingWithSize28] , 0, [UIImage imageNamed:@"case_order1"].size.width, [UIImage imageNamed:@"case_order1"].size.height);
        
        imageView.image = [UIImage imageNamed:imageArray[i]];
        
        [self.scrollView addSubview:imageView];
        
    }
    
}

@end
