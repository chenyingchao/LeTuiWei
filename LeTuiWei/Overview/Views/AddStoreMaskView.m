//
//  AddStoreMaskView.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/19.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "AddStoreMaskView.h"
#import "ConfirmButtonView.h"
@interface AddStoreMaskView ()

@property (nonatomic, strong) UIView *maskView;

@end

@implementation AddStoreMaskView


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 8;
        self.clipsToBounds = YES;


    }
    return self;
}

- (void)showView {
    WS(weakSelf);
    UIImageView *closeImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    closeImageView.image = [UIImage imageNamed:@"close"];
    closeImageView.userInteractionEnabled = YES;
    [self addSubview:closeImageView];
    [closeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset([Theme paddingWithSize32]);
        make.right.equalTo(weakSelf).offset(-[Theme paddingWithSize32]);
    }];
    
    [closeImageView bk_whenTapped:^{
        [weakSelf closeView];
    }];
    
    UIImageView *headerImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    headerImageView.image = [UIImage imageNamed:@"imgstore_" ];
    [self addSubview:headerImageView];
    [headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.top.equalTo(weakSelf).offset([Theme paddingWithSize:90]);
    }];
    
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    contentLabel.font = [Theme fontWithSize28];
    contentLabel.textColor = [Theme colorDarkGray];
    contentLabel.numberOfLines = 0;
    contentLabel.textAlignment = NSTextAlignmentCenter;
    contentLabel.text = @" 当前账号还没有门店信息\n请添加门店才可以进行操作";
    [self addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(weakSelf);
        make.top.equalTo(headerImageView.mas_bottom).offset([Theme paddingWithSize:60]);
    }];
    
    ConfirmButtonView *submitView = [ConfirmButtonView confirmButtonViewWithTitle:@"立即添加" andButtonClickedBlock:^(UIButton *button) {
        if (weakSelf.addStoreButtonBlock) {
            weakSelf.addStoreButtonBlock(button);
        }
        [weakSelf closeView];
    }];
    [self addSubview:submitView];
    submitView.layer.cornerRadius = [Theme paddingWithSize40];
    submitView.layer.masksToBounds = YES;
    [submitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.top.equalTo(contentLabel.mas_bottom).offset([Theme paddingWithSize:56]);
        make.height.equalTo(@([Theme paddingWithSize:80]));
        make.width.equalTo(@([Theme paddingWithSize:300]));
    }];
    
    [ATKeyWindow addSubview:self.maskView];
    [ATKeyWindow addSubview:self];

}


-(UIView *)maskView {
    
    if (!_maskView) {
        WS(weakSelf);
        _maskView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];

         [_maskView bk_whenTapped:^{
             [weakSelf closeView];
             
         }];
        
        _maskView.userInteractionEnabled = YES;
        _maskView.backgroundColor = UIColorFromRGB(0x424242);
       // _maskView.alpha =  0.9;
        
    }
    
    return _maskView;
}

- (void)closeView {
    [self.maskView removeFromSuperview];
    self.maskView = nil;
    [self removeFromSuperview];
}


@end
