//
//  PaymentResultViewController.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/7.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "PaymentResultViewController.h"




@interface PaymentResultViewController ()<UITextViewDelegate>

@end

@implementation PaymentResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.paymentResultType == PaymentResultTypeSuccess) {
        self.navigationItem.title = @"开通成功";
    } else if (self.paymentResultType == PaymentResultTypeFailed) {
       self.navigationItem.title = @"支付失败";
    
    } else if (self.paymentResultType == PaymentResultTypeTimeOut) {
        
        
    }
    
    switch (self.paymentResultType) {
        case PaymentResultTypeSuccess: {
             self.navigationItem.title = @"开通成功";
        
        }
            
            break;
            
        case PaymentResultTypeFailed: {
              self.navigationItem.title = @"支付失败";
        }
            
            break;
            
        case PaymentResultTypeTimeOut: {
            
            switch (self.paymentType) {
                case PaymentTypeWechatPay: {
                 self.navigationItem.title = @"微信支付";
                
                }
                    
                    break;
                case PaymentTypeAliPay: {
                  self.navigationItem.title = @"支付宝支付";
                    
                }
                    
                    break;
                case PaymentTypeScanCodePay: {
                    self.navigationItem.title = @"兑换码支付";
                    
                }
                    
                    break;
                    
                default:
                    break;
            }
        }
            
            break;
            
        default:
            break;
    }
    [self creatViewWithResultType:self.paymentResultType paymentType:self.paymentType];
}

- (void)creatViewWithResultType:(PaymentResultType)resultType paymentType:(PaymentType)paymentType {
    WS(weakSelf);
    
    self.view.backgroundColor = [Theme colorForAppBackground];
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectZero];
    bgView.backgroundColor = [Theme colorWhite];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(weakSelf.view);
        make.height.equalTo(@(kScreenHeight / 2));
    }];

    UIImageView *resultImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [bgView addSubview:resultImageView];
    [resultImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgView);
        make.top.equalTo(bgView.mas_top).offset([Theme paddingWithSize100]);
        make.width.equalTo(@([UIImage imageNamed:@"paysucceed"].size.width));
        make.height.equalTo(@([UIImage imageNamed:@"paysucceed"].size.height));
    }];
    
    UILabel *resultLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    resultLabel.font = [Theme fontWithSize30];
    resultLabel.textColor = [Theme colorDarkGray];

    [bgView addSubview:resultLabel];
    [resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgView);
        make.top.equalTo(resultImageView.mas_bottom).offset([Theme paddingWithSize24]);
    }];
    
//    resultImageView.image = [UIImage imageNamed:@"paysucceed"];
//    resultLabel.text = @"开通成功！";
    

    
    switch (resultType) {
        case PaymentResultTypeSuccess: {
        
            resultImageView.image = [UIImage imageNamed:@"paysucceed"];
            resultLabel.text = @"开通成功！";
            
            UILabel *remarkLabel = [[UILabel alloc] initWithFrame:CGRectZero];
            remarkLabel.font = [Theme fontWithSize30];
            remarkLabel.numberOfLines = 0;
            remarkLabel.textColor = [Theme colorDarkGray];
            [bgView addSubview:remarkLabel];
            [remarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(bgView).offset([Theme paddingWithSize:84]);
                make.right.equalTo(bgView).offset(-[Theme paddingWithSize:84]);
                make.top.equalTo(resultLabel.mas_bottom).offset([Theme paddingWithSize:88]);
            }];
            remarkLabel.text = @"账号：xxxx已经开通\n使用期限：2020-1-1";
        }
            
            break;
        case PaymentResultTypeFailed: {
            
            resultImageView.image = [UIImage imageNamed:@"payerror"];
            resultLabel.text = @"支付失败";
            
            UILabel *remarkLabel = [[UILabel alloc] initWithFrame:CGRectZero];
            remarkLabel.font = [Theme fontWithSize30];
            remarkLabel.numberOfLines = 0;
            remarkLabel.textColor = [Theme colorDarkGray];
            [bgView addSubview:remarkLabel];
            [remarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(resultLabel);
                make.top.equalTo(resultLabel.mas_bottom).offset([Theme paddingWithSize24]);
            }];
            remarkLabel.text = @"您可以刷新再试";
            
            UIButton *againPayment = [[UIButton alloc] initWithFrame:CGRectZero];
            [againPayment setTitle:@"重新支付"forState:UIControlStateNormal];
            [againPayment setTitleColor:[Theme colorDarkGray] forState:UIControlStateNormal];
            againPayment.titleLabel.font = [Theme fontWithSize30];
            againPayment.layer.borderWidth= 1;
            againPayment.layer.borderColor = UIColorFromRGB(0xcccccc).CGColor;
            [bgView addSubview:againPayment];
            [againPayment  mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.height.equalTo(@([Theme paddingWithSize:86]));
                make.width.equalTo(@([Theme paddingWithSize:300]));
                make.centerX.equalTo(bgView);
                make.top.equalTo(remarkLabel.mas_bottom).offset([Theme paddingWithSize:50]);
            }];

            
            
            
        }
            
            break;
        case PaymentResultTypeTimeOut: {
            
            resultImageView.image = [UIImage imageNamed:@"payerror"];
            resultLabel.text = @"页面超时";
            
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"1、如果您尚未付款，请点此重新获取付款二维码\n\n2、如果您已付款成功，请点此刷新页面"];
            [attributedString addAttribute:NSLinkAttributeName
                                                 value:@"againGetCode://"
                                                 range:[[attributedString string] rangeOfString:@"点此重新获取"]];
            [attributedString addAttribute:NSLinkAttributeName
                                                 value:@"refreshPage://"
                                                 range:[[attributedString string] rangeOfString:@"点此刷新页面"]];
         
            UITextView *textView = [[UITextView alloc] initWithFrame:CGRectZero];
            textView.delegate = self;
            textView.editable = NO;
            textView.scrollEnabled = NO;
            textView.font = [Theme fontWithSize30];
            textView.textColor = [Theme colorDarkGray];
            
            [self.view addSubview:textView];
            textView.linkTextAttributes = @{NSForegroundColorAttributeName:
                                                [Theme colorForAppearance],
                NSUnderlineColorAttributeName:  [Theme colorForAppearance],
                NSUnderlineStyleAttributeName: @(NSUnderlinePatternSolid)};
            textView.attributedText = attributedString;
            [textView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(bgView).offset([Theme paddingWithSize:84]);
                make.right.equalTo(bgView).offset(-[Theme paddingWithSize:84]);
                make.top.equalTo(resultLabel.mas_bottom).offset([Theme paddingWithSize40]);
                make.height.equalTo(@([Theme paddingWithSize:150]));
            }];
        }
            
            break;
            
        default:
            break;
    }

}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    if ([[URL scheme] isEqualToString:@"againGetCode"]) {
             NSLog(@"重新获取");
             return NO;
    }
    
    if ([[URL scheme] isEqualToString:@"refreshPage"]) {
        NSLog(@"刷新页面");
        return NO;
    }

    return YES;
}
@end
