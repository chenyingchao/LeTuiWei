//
//  IncomeHeaderView.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/21.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "IncomeHeaderView.h"
#import "CustomSegmentView.h"
#import "CalendarView.h"

@interface IncomeHeaderView()

@property (nonatomic, assign) BOOL isOpenWisdomStore;

@property (nonatomic, strong) UILabel * seperatorLabel;

@property (nonatomic, strong) UIButton *headerLeftButton;

@property (nonatomic, strong) UIButton *headerRightButton;

@property (nonatomic, strong) UILabel *remarkLabel;

@property (nonatomic, strong) UIView *indicator;

@property (nonatomic, strong) UIView *lineH;

@property (nonatomic, assign) CGFloat interval;

@property (nonatomic, strong) CalendarView *calendarView;

@property (nonatomic, strong) UIView *bgSegmentView;

@end


@implementation IncomeHeaderView

-(instancetype)initWithFrame:(CGRect)frame isOpenWisdomStorm:(BOOL)isOpenWisdomStore storeQuantity:(NSInteger)storeQuantity{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.isOpenWisdomStore = isOpenWisdomStore;
       
        [self footerView];
        
    }
    return self;
}
- (void)setCalendarTitle:(NSString *)calendarTitle {
    [self.calendarButton setTitle:calendarTitle forState:UIControlStateNormal];
    CGSize size = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) textFont: [Theme fontWithSize28] aimString:calendarTitle];
    self.calendarButton.imageEdgeInsets = UIEdgeInsetsMake(0,size.width + _interval, 0, -(size.width + _interval));
    self.calendarButton.titleEdgeInsets = UIEdgeInsetsMake(0, -([UIImage imageNamed:@"down"].size.width + _interval), 0, [UIImage imageNamed:@"down"].size.width + _interval);
}

- (void)footerView {
    WS(weakSelf);

    self.lineH = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:self.lineH];
    self.lineH.tag = 200;
    self.lineH.backgroundColor = [Theme colorForSeparatorLine];
    [self.lineH mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf);
        make.height.equalTo(@(kSeparatorHeight));
        
    }];

    _interval = 3.0;
    self.calendarButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [self addSubview: self.calendarButton];
    self.calendarButton.backgroundColor = [Theme colorWhite];
    
    self.calendarButton.titleLabel.font = [Theme fontWithSize28];
    [self.calendarButton setTitle:@"1121313" forState:UIControlStateNormal];
    [self.calendarButton setTitleColor:[Theme colorDarkGray] forState:UIControlStateNormal];
    [self.calendarButton setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
    [self.calendarButton setImage:[UIImage imageNamed:@"up"] forState:UIControlStateSelected];

    [self.calendarButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(weakSelf);
        make.height.equalTo(@([Theme paddingWithSize:84]));
        make.bottom.equalTo(weakSelf).offset(-kSeparatorHeight);
        
    }];
    
    CGSize size = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) textFont: [Theme fontWithSize28] aimString:@"1121313"];
    self.calendarButton.imageEdgeInsets = UIEdgeInsetsMake(0,size.width + _interval, 0, -(size.width + _interval));
    self.calendarButton.titleEdgeInsets = UIEdgeInsetsMake(0, -([UIImage imageNamed:@"down"].size.width + _interval), 0, [UIImage imageNamed:@"down"].size.width + _interval);
    self.calendarButton.tag = 1000;

    [self.calendarButton bk_whenTapped:^{
        weakSelf.calendarButton.selected = ! weakSelf.calendarButton.selected;

        if ([weakSelf.incomeHeaderViewDelegate respondsToSelector:@selector(incomeHeaderView:didSelectCalendarButton:buttonStatus:)]) {
            
            [weakSelf.incomeHeaderViewDelegate incomeHeaderView:weakSelf didSelectCalendarButton:weakSelf.calendarButton buttonStatus:weakSelf.calendarButton.selected];
        }
    
    }];
    
    if (!_isOpenWisdomStore) {
        return;
    }
    
    
    self.bgSegmentView = [[UIView alloc] initWithFrame:CGRectZero];
    self.bgSegmentView.backgroundColor = [Theme  colorForAppBackground];
    [self addSubview:self.bgSegmentView];
    [self.bgSegmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf);
        make.height.equalTo(@([Theme paddingWithSize:154]));
        make.bottom.equalTo(weakSelf.calendarButton.mas_top);
        
    }];

    self.headerLeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bgSegmentView addSubview: self.headerLeftButton];
    self.headerLeftButton.tag = IncomeHeaderViewTopButtonLeft;
    self.headerLeftButton.backgroundColor = [UIColor whiteColor];
    self.headerLeftButton.titleLabel.font = [Theme fontWithSize30];
    [self.headerLeftButton setTitle:@"按收入统计" forState:UIControlStateNormal];
    [self.headerLeftButton setTitleColor:[Theme colorDarkGray] forState:UIControlStateNormal];
    [self.headerLeftButton setTitleColor:UIColorFromRGB(0x3f88cd) forState:UIControlStateSelected];
    [self.headerLeftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgSegmentView);
        make.right.equalTo(weakSelf.bgSegmentView).multipliedBy(0.5);
        make.top.equalTo(weakSelf.bgSegmentView);
        make.height.equalTo(@([Theme paddingWithSize:84]));
        
    }];
    
    self.headerRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bgSegmentView addSubview: self.headerRightButton];
    self.headerRightButton.tag = IncomeHeaderViewTopButtonRight;
    self.headerRightButton.backgroundColor = [UIColor whiteColor];
    self.headerRightButton.titleLabel.font = [Theme fontWithSize30];
    [self.headerRightButton setTitle:@"按订单统计" forState:UIControlStateNormal];
    [self.headerRightButton setTitleColor:[Theme colorDarkGray] forState:UIControlStateNormal];
    [self.headerRightButton setTitleColor:UIColorFromRGB(0x3f88cd) forState:UIControlStateSelected];
    [self.headerRightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.bgSegmentView);
        make.left.equalTo(weakSelf.bgSegmentView).offset(kScreenWidth / 2);
        make.top.equalTo(weakSelf.bgSegmentView);
        make.height.equalTo(@([Theme paddingWithSize:84]));
        
    }];
    
    self.remarkLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.remarkLabel.font = [Theme fontWithSize24];
    self.remarkLabel.textColor = [Theme colorDimGray];
    self.remarkLabel.text = @"     以收入为统计标准,包括会员卡充值收入,会员卡消费不计入";
    [self.bgSegmentView addSubview:self.remarkLabel];
    [self.remarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgSegmentView).offset([Theme paddingWithSize32]);
        make.right.equalTo(weakSelf.bgSegmentView).offset(-[Theme paddingWithSize32]);
        make.top.equalTo(weakSelf.headerLeftButton.mas_bottom);
        make.height.equalTo(@([Theme paddingWithSize:70]));
        
    }];
    
    self.indicator = [[UIView alloc] initWithFrame:CGRectZero];
    self.indicator.backgroundColor = UIColorFromRGB(0x3f88cd);
    [self.bgSegmentView addSubview: self.indicator];
    
    [self.headerLeftButton bk_whenTapped:^{
        [weakSelf selectTabAtIndex:IncomeHeaderViewTopButtonLeft];
        weakSelf.remarkLabel.text = @"     以收入为统计标准,包括会员卡充值收入,会员卡消费不计入";
        
        
    }];
    [self.headerRightButton bk_whenTapped:^{
        [weakSelf selectTabAtIndex:IncomeHeaderViewTopButtonRight];
        weakSelf.remarkLabel.text = @"     以售出商品为统计标准,即订单流水,不包括会员充值收入";
    }];
    
    //默认选择左边
    [self selectTabAtIndex:IncomeHeaderViewTopButtonLeft];
}

- (void)selectTabAtIndex:(NSInteger)index {

    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            if ((button.tag != IncomeHeaderViewTopButtonLeft) && (button.tag !=IncomeHeaderViewTopButtonRight)) {
                
                break;
            }
            if (view.tag != index) {
                
                button.selected = NO;
            }else {
                
                button.selected = YES;
                
            }
        }
        
    }
    
    UIButton *selectButton = [self viewWithTag:index];
    CGFloat indicatorSpace = 20;
    
    if (selectButton) {

        BOOL isInitialSelect = NO;
        if (_indicator.frame.size.width == 0) {
            isInitialSelect = YES;
        }
        // update indicator position
        CGFloat indicatorLeft = kScreenWidth / 2 * (index - 500);
        CGRect targetFrame = CGRectMake(indicatorLeft + indicatorSpace, [Theme paddingWithSize:84] - 3,  kScreenWidth / 2 - 2 * indicatorSpace, 3);
        
        if (isInitialSelect) {
            _indicator.frame = targetFrame;
        } else {
            [UIView animateWithDuration:0.33 animations:^{
                _indicator.frame = targetFrame;
            }];
        }
    }


}

#pragma mark 返回字符串尺寸
- (CGSize)sizeOfStringWithMaxSize:(CGSize)maxSize textFont:(UIFont *)fontSize aimString:(NSString *)aimString{
    
    
    return [[NSString stringWithFormat:@"%@",aimString] boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:fontSize} context:nil].size;
    
}




@end
