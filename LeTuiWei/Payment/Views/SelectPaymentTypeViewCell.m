//
//  SelectPaymentTypeViewCell.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/6.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "SelectPaymentTypeViewCell.h"
#import "CustomSegmentView.h"
#import "UIButton+text.h"
@implementation SelectPaymentTypeViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withDataSource:(id)dataSource cellType:(SelectPaymentCellType)type {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier components:ATCommenCellComponentEmpty];
    self.opaque = YES;
    if (self) {
        if (type == SelectPaymentCellTypeSegment) {
            [self createHeaderItems];
        } else if (type == SelectPaymentCellTypeThirdPartyPayment) {
            [self createThirdPartyPaymentView];
        
        } else if (type == SelectPaymentCellTypeScanCodePayment) {
            
            [self createScanCodePayment];
        }
        
    }
    return self;
}

- (void)createHeaderItems {
    WS(weakSelf);
    CustomSegmentView *headerTapView = [[CustomSegmentView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth,[Theme paddingWithSize100]) titles:@[@"扫码开通", @"兑换码开通"]];
    headerTapView.selectAtIndexBlock = ^(NSInteger index){

        if (index == 0) {
            weakSelf.segmentBlock(SelectPaymentCellTypeThirdPartyPayment);
        } else {
            weakSelf.segmentBlock(SelectPaymentCellTypeScanCodePayment);
        }
    };
    
    
    [self.contentView addSubview:headerTapView];

   [headerTapView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.right.top.bottom.equalTo(weakSelf.contentView);
       make.height.equalTo(@([Theme paddingWithSize100]));
   }];

}


- (void)createThirdPartyPaymentView {
    WS(weakSelf);
    UIView *tempView = nil;
    NSArray *titleArray = @[@"¥60/月",@"¥160/月",@"¥280/月",@"¥480/月"];

    CGFloat buttonHeight = [Theme paddingWithSize100];
    CGFloat buttonWeight = (kScreenWidth - 3 * [Theme paddingWithSize32])/2;
    CGFloat padding = [Theme paddingWithSize32];

    for (int i = 0; i < titleArray.count; i++) {
        CGFloat x = i % 2; // 01  01列
        CGFloat y = i / 2;// 00    11 行
        UIButton *itemButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [itemButton setTitle:titleArray[i] forState:UIControlStateNormal];
        [itemButton setTitleColor:[Theme colorDarkGray] forState:UIControlStateNormal];
        itemButton.titleLabel.font = [Theme fontWithSize30];
        itemButton.layer.borderWidth= 1;
        itemButton.layer.borderColor = UIColorFromRGB(0xcccccc).CGColor;
        [self.contentView addSubview:itemButton];
        [itemButton  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.contentView).offset(padding + (buttonWeight + padding) * x);
            make.top.equalTo(weakSelf.contentView).offset(padding + (padding + buttonHeight) * y);
            make.height.equalTo(@([Theme paddingWithSize100]));
            make.width.equalTo(@((kScreenWidth - 3 * [Theme paddingWithSize32])/2 ));
            
        }];
        
        if (i == titleArray.count - 1) {
            [itemButton  mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(weakSelf.contentView).offset(padding + (buttonWeight + padding) * x);
                make.top.equalTo(weakSelf.contentView).offset(padding + (padding + buttonHeight) * y);
                make.height.equalTo(@([Theme paddingWithSize100]));
                make.width.equalTo(@((kScreenWidth - 3 * [Theme paddingWithSize32])/2 ));
               // make.bottom.equalTo(weakSelf.contentView).offset(-[Theme paddingWithSize32]);
                
            }];
            
            tempView = itemButton;
        }
        
        [itemButton bk_whenTapped:^{
           
            for (UIView *view in weakSelf.contentView.subviews) {
                if ([view isKindOfClass:[UIButton class]]) {
                    UIButton *button = (UIButton *)view;
                    button.selected = NO;
                    button.layer.borderColor = UIColorFromRGB(0xcccccc).CGColor;
                }
            }
         itemButton.layer.borderColor = UIColorFromRGB(0xff9900).CGColor;
            
            weakSelf.selectLimitBlock(i);
        }];
    }
    
    UIButton *wexinButton = [[UIButton alloc] initWithFrame:CGRectZero];
    wexinButton.backgroundColor = UIColorFromRGB(0x00b222);
    [wexinButton setTitle:@"微信支付"forState:UIControlStateNormal];
    [wexinButton setImage:[UIImage imageNamed:@"wechatpay"] forState:UIControlStateNormal];
    [wexinButton setTitleColor:[Theme colorWhite] forState:UIControlStateNormal];
    wexinButton.titleLabel.font = [Theme fontWithSize32];
    [wexinButton setImageEdgeInsets:UIEdgeInsetsMake(0, -[Theme paddingWithSize10], 0, 0)];
    [wexinButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -[Theme paddingWithSize10])];
    [self.contentView addSubview:wexinButton];
    [wexinButton  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tempView.mas_bottom).offset([Theme paddingWithSize:50]);
        make.left.equalTo(weakSelf.contentView).offset([Theme paddingWithSize32]);
        make.right.equalTo(weakSelf.contentView).offset(-[Theme paddingWithSize32]);
        make.height.equalTo(@([Theme paddingWithSize:86]));
    }];

    UIButton *alipayButton = [[UIButton alloc] initWithFrame:CGRectZero];
    alipayButton.backgroundColor = UIColorFromRGB(0x00a4ea);
    [alipayButton setTitle:@"支付宝支付"forState:UIControlStateNormal];
    [alipayButton setImage:[UIImage imageNamed:@"zhifubao"] forState:UIControlStateNormal];
    [alipayButton setTitleColor:[Theme colorWhite] forState:UIControlStateNormal];
    alipayButton.titleLabel.font = [Theme fontWithSize32];
    [alipayButton setImageEdgeInsets:UIEdgeInsetsMake(0, -[Theme paddingWithSize10], 0, 0)];
    [alipayButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -[Theme paddingWithSize10])];
    [self.contentView addSubview:alipayButton];
    [alipayButton  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wexinButton.mas_bottom).offset([Theme paddingWithSize:26]);
        make.left.equalTo(weakSelf.contentView).offset([Theme paddingWithSize32]);
        make.right.equalTo(weakSelf.contentView).offset(-[Theme paddingWithSize32]);
        make.height.equalTo(@([Theme paddingWithSize:86]));
        make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-[Theme paddingWithSize:160]);
    }];
    
    [wexinButton bk_whenTapped:^{
        weakSelf.selectPaymentTypeBlock(SelectPaymentTypeWechatPay);
    }];
    
    [alipayButton bk_whenTapped:^{
        weakSelf.selectPaymentTypeBlock(SelectPaymentTypeAliPay);
    }];
    
}

- (void)createScanCodePayment {
    WS(weakSelf);
    
    UITextField *codeTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:codeTextField];
    codeTextField.placeholder = @"   请填写兑换码";
    codeTextField.layer.borderWidth= 1;
    codeTextField.layer.borderColor = UIColorFromRGB(0xcccccc).CGColor;
    [codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(weakSelf.contentView).offset([Theme paddingWithSize32]);
        make.right.equalTo(weakSelf.contentView).offset(-[Theme paddingWithSize32 ]);
        make.top.equalTo(weakSelf.contentView).offset([Theme paddingWithSize:80]);
        make.height.equalTo(@([Theme paddingWithSize100]));
    }];
    

    UIButton *convertButton = [[UIButton alloc] initWithFrame:CGRectZero];
    convertButton.backgroundColor = [Theme colorForAppearance];
    [convertButton setTitle:@"兑换"forState:UIControlStateNormal];
    [convertButton setTitleColor:[Theme colorWhite] forState:UIControlStateNormal];
    convertButton.titleLabel.font = [Theme fontWithSize32];
    [self.contentView addSubview:convertButton];
    [convertButton  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(codeTextField.mas_bottom).offset([Theme paddingWithSize:50]);
        make.left.equalTo(weakSelf.contentView).offset([Theme paddingWithSize32]);
        make.right.equalTo(weakSelf.contentView).offset(-[Theme paddingWithSize32]);
        make.height.equalTo(@([Theme paddingWithSize:86]));
       // make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-[Theme paddingWithSize:160]);
    }];
    
    UIButton *getCodeButton = [[UIButton alloc] initWithFrame:CGRectZero withTitle:@"如何获得兑换码？" withTitleColor:[Theme colorDimGray] withFont: [Theme fontWithSize30] andButtonClickedBlock:^(UIButton *button) {
     
        
    }];
    [self.contentView addSubview:getCodeButton];
    [getCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.contentView);
        make.top.equalTo(convertButton.mas_bottom).offset([Theme paddingWithSize40]);
        make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-[Theme paddingWithSize:160]);
    }];
    
    
    [convertButton bk_whenTapped:^{
        weakSelf.selectPaymentTypeBlock(SelectPaymentTypeScanCodePay);
    }];


}

@end
