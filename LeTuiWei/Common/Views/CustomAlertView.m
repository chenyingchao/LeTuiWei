//
//  CustomAlertView.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/3/30.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "CustomAlertView.h"
#import "UIView+Frame.h"

@interface CustomAlertView()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *seperatorLabel;

@property (nonatomic, strong) UILabel *seperatorLabel1;

@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong) UIButton *confirmButton;

@end


@implementation CustomAlertView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self creatAlertView];
    }
    return self;
}

- (void)creatAlertView {

    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 8;
    self.clipsToBounds = YES;
    WS(weakSelf)
    
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    backImageView.image = [UIImage imageNamed:@"password"];
    backImageView.userInteractionEnabled = YES;
    [self addSubview:backImageView];
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset([Theme paddingWithSize20]);
        make.right.equalTo(weakSelf).offset(-[Theme paddingWithSize20]);
        
    }];
    
    [backImageView bk_whenTapped:^{
        [weakSelf closeView];
    }];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [Theme fontWithSize30];
    [self addSubview:_titleLabel];
    
    _seperatorLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _seperatorLabel.backgroundColor = [Theme colorBlackWithAlpha:0.3];
    [self addSubview:_seperatorLabel];
    
    _seperatorLabel1 = [[UILabel alloc] initWithFrame:CGRectZero];
    _seperatorLabel1.backgroundColor = [Theme colorBlackWithAlpha:0.3];
    [self addSubview:_seperatorLabel1];
    
    _cancelButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelButton setTitleColor:[Theme colorForAppearance] forState:UIControlStateNormal];
    [self addSubview:_cancelButton];
    
    _confirmButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [_confirmButton setTitle:@"确认" forState:UIControlStateNormal];
    [_confirmButton setTitleColor:[Theme colorForAppearance] forState:UIControlStateNormal];
    [self addSubview:_confirmButton];
   
}


- (void)showAlertView:(NSString *)title withType:(AlertViewType)type {
    WS(weakSelf);
    _titleLabel.text = title;
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.top.equalTo(weakSelf);
        make.bottom.equalTo(_seperatorLabel.mas_top);
    }];
    
    [_seperatorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf);
        make.right.equalTo(weakSelf);
        make.height.equalTo(@(kSeparatorHeight));
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-[Theme paddingWithSize100]);
    }];
    
    [_seperatorLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_seperatorLabel.mas_bottom);
        make.centerX.equalTo(weakSelf);
        make.width.equalTo(@(kSeparatorHeight));
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
    
    [_cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf);
        make.top.equalTo(_seperatorLabel.mas_bottom);
        make.right.equalTo(_seperatorLabel1.mas_right);
        make.bottom.equalTo(weakSelf);
        
    }];
    
    [_confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf);
        make.top.equalTo(_seperatorLabel.mas_bottom);
        make.left.equalTo(_seperatorLabel1.mas_left);
        make.bottom.equalTo(weakSelf);
        
    }];
    
    if (type == AlertViewTypeIKnow) {
        [_seperatorLabel1 removeFromSuperview];
        [_confirmButton removeFromSuperview];
        
        [_cancelButton setTitle:@"我知道了" forState:UIControlStateNormal];
        [_cancelButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf);
            make.top.equalTo(_seperatorLabel.mas_bottom);
            make.left.equalTo(weakSelf);
            make.bottom.equalTo(weakSelf);
        }];
    }
    
    if (type == AlertViewTypeAddStores) {
        
    }

    
    
    //点击取消 点击我知道了
    [_cancelButton bk_whenTapped:^{
        [weakSelf closeView];
    }];
    //点击确定
   
    [_confirmButton bk_whenTapped:^{
        if ([weakSelf.delegate respondsToSelector:@selector(requestEventAction:withAlertTitle:)]) {
            [weakSelf.delegate requestEventAction:_confirmButton withAlertTitle:weakSelf.titleLabel.text];
        }
    }];

    //设置背景
    if (self.bgView) {
        return;
    }
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.bgView addGestureRecognizer:tap];
    self.bgView.userInteractionEnabled = YES;
    self.bgView.backgroundColor = [UIColor blackColor];
    self.bgView.alpha =  0.4;
    [window addSubview:self.bgView];
    [window addSubview:self];
}


- (void)tap:(UIGestureRecognizer *)gr {
    
    [self.bgView removeFromSuperview];
    self.bgView = nil;
    [self removeFromSuperview];
}


- (void)closeView {
    [self.bgView removeFromSuperview];
    self.bgView = nil;
    [self removeFromSuperview];
}

@end
