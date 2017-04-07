//
//  CustomAlertView.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/3/30.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "CustomAlertView.h"
#import "UIView+Frame.h"
#import "ATCommonCell.h"
@interface CustomAlertView() <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *seperatorLabel;

@property (nonatomic, strong) UILabel *seperatorLabel1;

@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong) UIButton *confirmButton;

@property (nonatomic, strong) UIButton *spaceConfirmButton;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataSourceArray;

@property (nonatomic, copy) NSString *title;
@end


@implementation CustomAlertView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 8;
        self.clipsToBounds = YES;
    }
    return self;
}


- (void)showAlertView:(NSString *)title withType:(AlertViewType)type {

    WS(weakSelf)
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    backImageView.image = [UIImage imageNamed:@"close"];
    backImageView.userInteractionEnabled = YES;
    [self addSubview:backImageView];
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset([Theme paddingWithSize20]);
        make.right.equalTo(weakSelf).offset(-[Theme paddingWithSize20]);
        make.width.equalTo(@([UIImage imageNamed:@"close"].size.width));
        make.height.equalTo(@([UIImage imageNamed:@"close"].size.height));
        
    }];

    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [Theme fontWithSize30];
    _titleLabel.numberOfLines = 0;
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
    _cancelButton.titleLabel.font = [Theme fontWithSize30];
    [self addSubview:_cancelButton];
    
    _confirmButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [_confirmButton setTitle:@"确认" forState:UIControlStateNormal];
    [_confirmButton setTitleColor:[Theme colorForAppearance] forState:UIControlStateNormal];
    _confirmButton.titleLabel.font = [Theme fontWithSize30];
    [self addSubview:_confirmButton];
    
    _spaceConfirmButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [_spaceConfirmButton setTitle:@"站位确认建" forState:UIControlStateNormal];
    [_spaceConfirmButton setTitleColor:[Theme colorForAppearance] forState:UIControlStateNormal];
    _spaceConfirmButton.titleLabel.font = [Theme fontWithSize30];
    [self addSubview:_spaceConfirmButton];
    
    //根据类别 开始布局
    _titleLabel.text = title;
    CGSize size = [title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[Theme fontWithSize30]} context:nil].size;
    if (size.width > [UIScreen mainScreen].bounds.size.width - [Theme paddingWithSize100] * 2 - [Theme paddingWithSize40] * 2) {
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    if (type == AlertViewTypeCommon) {
        self.frame = CGRectMake([Theme paddingWithSize100], 200, [UIScreen mainScreen].bounds.size.width - [Theme paddingWithSize100] * 2,[Theme paddingWithSize:300]);
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf).offset([Theme paddingWithSize40]);
            make.right.equalTo(weakSelf).offset(-[Theme paddingWithSize40]);
            make.top.equalTo(backImageView.mas_bottom);
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

    }
    
    if (type == AlertViewTypeIKnow) {
        self.frame = CGRectMake([Theme paddingWithSize100], 200, [UIScreen mainScreen].bounds.size.width - [Theme paddingWithSize100] * 2,[Theme paddingWithSize:300]);
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf).offset([Theme paddingWithSize40]);
            make.right.equalTo(weakSelf).offset(-[Theme paddingWithSize40]);
            make.top.equalTo(backImageView.mas_bottom);
            make.bottom.equalTo(_seperatorLabel.mas_top);
        }];
        
        [_seperatorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf);
            make.right.equalTo(weakSelf);
            make.height.equalTo(@(kSeparatorHeight));
            make.bottom.equalTo(weakSelf.mas_bottom).offset(-[Theme paddingWithSize100]);
        }];
        
        [_cancelButton setTitle:@"我知道了" forState:UIControlStateNormal];
        [_cancelButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf);
            make.top.equalTo(_seperatorLabel.mas_bottom);
            make.left.equalTo(weakSelf);
            make.bottom.equalTo(weakSelf);
        }];
    }
    
    if (type == AlertViewTypeAddAccount) {
        self.frame = CGRectMake([Theme paddingWithSize100], 200, [UIScreen mainScreen].bounds.size.width - [Theme paddingWithSize100] * 2,[Theme paddingWithSize:450]);

        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf).offset([Theme paddingWithSize40]);
            make.right.equalTo(weakSelf).offset(-[Theme paddingWithSize40]);
            make.top.equalTo(backImageView.mas_bottom);
            make.bottom.equalTo(_seperatorLabel1.mas_top);
        }];
        
        [_seperatorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf);
            make.right.equalTo(weakSelf);
            make.height.equalTo(@(kSeparatorHeight));
            make.bottom.equalTo(weakSelf.mas_bottom).offset(-[Theme paddingWithSize100]);
        }];
        
        [_seperatorLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
       
            make.left.equalTo(weakSelf);
            make.right.equalTo(weakSelf);
            make.height.equalTo(@(kSeparatorHeight));
            make.bottom.equalTo(_seperatorLabel.mas_bottom).offset(-[Theme paddingWithSize100]);
        }];
        
        
        [_confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf);
            make.top.equalTo(_seperatorLabel.mas_bottom);
            make.left.equalTo(weakSelf);
            make.bottom.equalTo(weakSelf);
            
        }];
        [_confirmButton setTitle:@"未购买，点击了解门派店收银机" forState:UIControlStateNormal];
        [_spaceConfirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf);
            make.top.equalTo(_seperatorLabel1.mas_bottom);
            make.left.equalTo(weakSelf);
            make.bottom.equalTo(_seperatorLabel.mas_top);
            
        }];
        
        [_spaceConfirmButton setTitle:@"知道了，我已购买" forState:UIControlStateNormal];
        
    }
    
    if (type == AlertViewTypeAddStores) {
        _titleLabel.textColor = [Theme colorForAppearance];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf).offset([Theme paddingWithSize40]);
            make.right.equalTo(weakSelf).offset(-[Theme paddingWithSize40]);
            make.top.equalTo(weakSelf).offset([Theme paddingWithSize20]);
            make.bottom.equalTo(_seperatorLabel1.mas_top);
        }];
    }
    
    
    [backImageView bk_whenTapped:^{
         [weakSelf closeView];
    }];
    
    
    //点击退出
    [backImageView bk_whenTapped:^{
        [weakSelf closeView];
    }];
    //点击取消 点击我知道了
    [_cancelButton bk_whenTapped:^{
        
        [weakSelf closeView];
    }];
    //点击确定
    
    [_confirmButton bk_whenTapped:^{
        if ([weakSelf.delegate respondsToSelector:@selector(requestEventAction:withAlertTitle:)]) {
            [weakSelf.delegate requestEventAction:_confirmButton withAlertTitle:weakSelf.titleLabel.text];
        }
         [weakSelf closeView];
    }];
    
    [_spaceConfirmButton bk_whenTapped:^{
        if ([weakSelf.delegate respondsToSelector:@selector(requestEventAction:withAlertTitle:)]) {
            [weakSelf.delegate requestEventAction:_spaceConfirmButton withAlertTitle:weakSelf.titleLabel.text];
        }
         [weakSelf closeView];
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


- (void)showAlertView:(NSString *)title withDataScoure:(id)dataScoure {
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    self.dataSourceArray = dataScoure;
    self.title = title;
    
    [self tabVieHeaderView];
    
    WS(weakSelf);

    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_tableView];
    [_tableView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.equalTo(weakSelf);
        make.top.equalTo(weakSelf).offset([Theme paddingWithSize:96]);
    }];
    
    [self addSubview:self.tableView];
    
    self.frame = CGRectMake([Theme paddingWithSize100], 200, [UIScreen mainScreen].bounds.size.width - [Theme paddingWithSize100] * 2,[Theme paddingWithSize:450]);
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

- (void)tabVieHeaderView {
    
    WS(weakSelf);
    
    UILabel * seperatorLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    seperatorLabel.backgroundColor = [Theme colorBlackWithAlpha:0.3];
    [self addSubview:seperatorLabel];
    [seperatorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf);
        make.height.equalTo(@(kSeparatorHeight));
        make.top.equalTo(weakSelf.mas_top).offset([Theme paddingWithSize:96]);
    }];
    
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    backImageView.image = [UIImage imageNamed:@"close"];
    backImageView.userInteractionEnabled = YES;
    [self addSubview:backImageView];
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset([Theme paddingWithSize20]);
        make.right.equalTo(weakSelf).offset(-[Theme paddingWithSize20]);
        make.width.equalTo(@([UIImage imageNamed:@"close"].size.width));
        make.height.equalTo(@([UIImage imageNamed:@"close"].size.height));
    }];


    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [Theme fontWithSize30];
    _titleLabel.textColor = [Theme colorForAppearance];
    _titleLabel.numberOfLines = 0;
    _titleLabel.text = self.title;
    [self addSubview:_titleLabel];

    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf);
        make.left.equalTo(weakSelf).offset([Theme paddingWithSize20]);
        make.right.equalTo(backImageView.mas_left).offset(-[Theme paddingWithSize20]);
        make.bottom.equalTo(seperatorLabel);
    }];
    
    [backImageView bk_whenTapped:^{
        [weakSelf closeView];
    }];
    

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSourceArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [Theme paddingWithSize:80];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self closeView];
    [self.delegate alertView:self didSelectRowAtIndexPath:indexPath];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ATCommonCell *cell = nil;

    cell = [tableView dequeueReusableCellWithIdentifier:@"stores"];
    
    if (!cell) {
        cell = [[ATCommonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"stores" components:ATCommonCellComponentSubtitleLabel];
        
    }
    cell.subTitleLabel.text = self.dataSourceArray[indexPath.row];
    

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.bottomSeparatorStyle = ATCommonCellSeparatorStyleSymmetricalDefault;
    if (indexPath.row == self.dataSourceArray.count - 1) {
        cell.bottomSeparatorStyle = ATCommonCellSeparatorStyleNone;

    }
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
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
