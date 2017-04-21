//
//  NavigitionHeaderView.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/13.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "NavigitionHeaderView.h"

@interface NavigitionHeaderView()

@property (nonatomic, strong) UIView *indicator;

@property (nonatomic, strong) NSArray<NSString *> *titles;

@property (nonatomic, assign) CGFloat tabWidth;

@property (nonatomic, assign) CGFloat interval;

@property (nonatomic, strong) UILabel * seperatorLabel;

@property (nonatomic, strong) UILabel * seperatorLabel1;


@property (nonatomic, assign) NaviHeaderViewType viewType;

@end

@implementation NavigitionHeaderView

-(instancetype)initWithFrame:(CGRect)frame withTitles:(NSArray *)titles withViewType:(NaviHeaderViewType)type {
    
    if (self = [super initWithFrame:frame]) {
       
        self.viewType = type;
        self.titles = titles;
        [self drawLine];
        WS(weakSelf);
        _interval = 3.0;
        self.calendarButton = [[UIButton alloc] initWithFrame:CGRectZero];
        self.calendarButton.titleLabel.font = [Theme fontWithSize28];
        
        NSString *title = self.calendarTitle;
        [self.calendarButton setTitle:title forState:UIControlStateNormal];
        [self.calendarButton setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
        [self.calendarButton setImage:[UIImage imageNamed:@"up"] forState:UIControlStateSelected];
        [self addSubview: self.calendarButton];
        [self.calendarButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(weakSelf);
            if (type == NaviHeaderViewOverView) {
                make.top.equalTo(weakSelf).offset([Theme paddingWithSize:60]);
            } else {
                make.top.equalTo(weakSelf).offset([Theme paddingWithSize28]);
            }
            
        }];
        
        CGSize size = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) textFont: [Theme fontWithSize28] aimString:_calendarTitle];
        self.calendarButton.imageEdgeInsets = UIEdgeInsetsMake(0,size.width + _interval, 0, -(size.width + _interval));
        self.calendarButton.titleEdgeInsets = UIEdgeInsetsMake(0, -([UIImage imageNamed:@"down"].size.width + _interval), 0, [UIImage imageNamed:@"down"].size.width + _interval);
        self.calendarButton.tag = 1000;
        [self.calendarButton bk_whenTapped:^{
            self.calendarButton.selected = ! self.calendarButton.selected;
            
            [weakSelf selectTabAtIndex:  self.calendarButton.tag];
            if (weakSelf.selectAtIndexBlock) {
                weakSelf.selectAtIndexBlock( self.calendarButton.tag, self.calendarButton.selected);
            }
        }];
        
        // create tabs
        _tabWidth = kScreenWidth / _titles.count;
        for (NSInteger i = 0, count = _titles.count; i < count; i++) {
            NSString *title = _titles[i];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [self addSubview:button];
            
            button.titleLabel.font = [Theme fontWithSize30];
            [button setTitle:title forState:UIControlStateNormal];
            button.tag = 1001 + i;
            [button bk_whenTapped:^{
                [weakSelf selectTabAtIndex:button.tag];
                if (weakSelf.selectAtIndexBlock) {
                    weakSelf.selectAtIndexBlock(button.tag,nil);
                }
            }];
            
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(weakSelf).offset(_tabWidth * i);
                make.top.equalTo(weakSelf.calendarButton.mas_bottom).offset([Theme paddingWithSize32]);
                make.bottom.equalTo(weakSelf).offset(-[Theme paddingWithSize24]);
                make.width.equalTo(@(_tabWidth));
            }];
            
            
        }
        
        _indicator = [[UIView alloc] initWithFrame:CGRectZero];
        _indicator.backgroundColor = UIColorFromRGB(0x3f88cd);
        [self addSubview:_indicator];
        
        [self selectTabAtIndex:1001];
    
    
    }
    return self;
}

- (void)setIsHideLine:(BOOL)isHideLine {

    self.seperatorLabel.hidden = isHideLine;
    self.seperatorLabel1.hidden = isHideLine;

}

- (void)upDateView {

    NSString *title = self.calendarTitle;
    [self.calendarButton setTitle:title forState:UIControlStateNormal];
    CGSize size = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) textFont: [Theme fontWithSize28] aimString:_calendarTitle];
    self.calendarButton.imageEdgeInsets = UIEdgeInsetsMake(0,size.width + _interval, 0, -(size.width + _interval));
    self.calendarButton.titleEdgeInsets = UIEdgeInsetsMake(0, -([UIImage imageNamed:@"down"].size.width + _interval), 0, [UIImage imageNamed:@"down"].size.width + _interval);

}


- (void)selectTabAtIndex:(NSInteger)index {

    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            if (view.tag != index) {
              
                if (self.viewType == NaviHeaderViewOverView) {
                    [button setTitleColor:UIColorFromRGB(0xc5cae9) forState:UIControlStateNormal];
                } else {
                    [button setTitleColor:[Theme colorDarkGray] forState:UIControlStateNormal];
                }
                
            }else {
            
                [button setTitleColor:UIColorFromRGB(0x3f88cd) forState:UIControlStateNormal];
                
            }
        }

    }
    UIButton *selectButton = [self viewWithTag:index];
    CGFloat indicatorSpace = 20;
    
    if (selectButton) {
        // set color
        // initial select
        
        if (selectButton.tag == 1000) {
            _indicator.hidden = YES;
            CGRect targetFrame = CGRectMake(-CGFLOAT_MAX,self.frame.size.height - 3, self.tabWidth - 2 * indicatorSpace, 3);
            _indicator.frame = targetFrame;
        } else {
            _indicator.hidden = NO;
        }
        
        
        BOOL isInitialSelect = NO;
        if (_indicator.frame.size.width == 0) {
            //
            isInitialSelect = YES;
        }
        // update indicator position
        CGFloat indicatorLeft = self.tabWidth * (index - 1001);
        CGRect targetFrame = CGRectMake(indicatorLeft + indicatorSpace, self.frame.size.height - 3, self.tabWidth - 2 * indicatorSpace, 3);

        if (isInitialSelect) {
            _indicator.frame = targetFrame;
        } else {
            [UIView animateWithDuration:0.33 animations:^{
                _indicator.frame = targetFrame;
            }];
        }
    }
    
    
}

- (void)drawLine {
    WS(weakSelf);
    self.seperatorLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.seperatorLabel.hidden = YES;
    self.seperatorLabel .backgroundColor = [Theme colorBlackWithAlpha:0.3];
    [self addSubview:self.seperatorLabel ];
    
    
    [self.seperatorLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf);
        make.height.equalTo(@(kSeparatorHeight));
        make.centerY.equalTo(weakSelf);
    }];
    
    self.seperatorLabel1 = [[UILabel alloc] initWithFrame:CGRectZero];
    self.seperatorLabel1.hidden = YES;
    self.seperatorLabel1 .backgroundColor = [Theme colorBlackWithAlpha:0.3];
    [self addSubview:self.seperatorLabel1 ];
    
    
    [self.seperatorLabel1  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf);
        make.height.equalTo(@(kSeparatorHeight));
        make.bottom.equalTo(weakSelf);
    }];
    
    
}


#pragma mark 返回字符串尺寸
- (CGSize)sizeOfStringWithMaxSize:(CGSize)maxSize textFont:(UIFont *)fontSize aimString:(NSString *)aimString{
    
    
    return [[NSString stringWithFormat:@"%@",aimString] boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:fontSize} context:nil].size;
    
}

@end
