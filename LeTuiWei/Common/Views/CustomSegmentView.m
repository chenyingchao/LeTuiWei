//
//  CustomSegmentView.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/6.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "CustomSegmentView.h"


static const CGFloat kIndicatorHeight = 2.0f;

static const int kButtonTag = 1000;

@interface CustomSegmentView()

@property (nonatomic, strong) UIColor *normalColor;     //default is gray

@property (nonatomic, strong) UIFont *normalFont;

@property (nonatomic, strong) UIColor *highLightColor;

@property (nonatomic, strong) NSArray<NSString *> *titles;

@property (nonatomic, strong) UIView *wrapperView;

@property (nonatomic, strong) UIView *indicator;

@property (nonatomic, assign) CGFloat tabWidth;

@end

@implementation CustomSegmentView

#pragma mark - init
- (id)initWithFrame:(CGRect)frame titles:(NSArray *)titles {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
        self.normalColor = [Theme colorDimGray];
        self.highLightColor = [Theme colorForAppearance];
        self.titles = titles;
        [self loadComponents];
    }
    
    return self;
}

- (void)reloadTabs {
    // create tabs according to self.titles
    WS(weakSelf);
    if (_wrapperView) {
        [_wrapperView removeFromSuperview];
    }
    _wrapperView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:_wrapperView];
    [_wrapperView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    UIView *separatorLine = [[UIView alloc] initWithFrame:CGRectZero];
    separatorLine.backgroundColor = [Theme colorForAppearance];
    [_wrapperView addSubview:separatorLine];
    [separatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(_wrapperView);
        make.width.equalTo(@(1));
        make.height.equalTo(@([Theme paddingWithSize28]));
    }];
    
    
    // create tabs
    CGFloat tabWidth = self.tabWidth;
    for (NSInteger i = 0, count = _titles.count; i < count; i++) {
        NSString *title = _titles[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(tabWidth * i, 0, tabWidth, self.frame.size.height);
        button.titleLabel.font = [Theme fontWithSize32];
        [button setTitle:title forState:UIControlStateNormal];
        [button bk_whenTapped:^{
            [weakSelf selectTabAtIndex:i];
            if (weakSelf.selectAtIndexBlock) {
                weakSelf.selectAtIndexBlock(i);
            }
        }];
        [button setTitleColor:self.normalColor forState:UIControlStateNormal];
        button.tag = kButtonTag + i;
        [_wrapperView addSubview:button];
    }
    [self selectTabAtIndex:_selectedIndex];
    
}

- (void)selectTabAtIndex:(NSInteger)index {
    UIButton *previousButton = [_wrapperView viewWithTag:kButtonTag + _selectedIndex];
    if (previousButton) {
        [previousButton setTitleColor:self.normalColor forState:UIControlStateNormal];
    }
    _selectedIndex = index;
    // update button color;
    UIButton *selected = [_wrapperView viewWithTag:kButtonTag + index];
    if (selected) {
        // set color
        [selected setTitleColor:self.highLightColor forState:UIControlStateNormal];
        // initial select
        BOOL isInitialSelect = NO;
        if (_indicator.frame.size.width == 0) {
            //
            isInitialSelect = YES;
        }
        // update indicator position
        CGFloat indicatorLeft = self.tabWidth * index;
        CGRect targetFrame = CGRectMake(indicatorLeft, self.frame.size.height - kIndicatorHeight, self.tabWidth, kIndicatorHeight);
        if (isInitialSelect) {
            _indicator.frame = targetFrame;
        } else {
            [UIView animateWithDuration:0.33 animations:^{
                _indicator.frame = targetFrame;
            }];
        }
    }
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    [self selectTabAtIndex:_selectedIndex];
}


- (void)loadComponents {
    // create tabs
    [self reloadTabs];
    // create indicator
    _indicator = [[UIView alloc] initWithFrame:CGRectZero];
    _indicator.backgroundColor = self.highLightColor;
    [self addSubview:_indicator];
}

- (void)setNormalColor:(UIColor *)normalColor {
    _normalColor = normalColor;
    for (UIView *subView in self.wrapperView.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton *otherButton = (UIButton *)subView;
            [otherButton setTitleColor: _normalColor forState:UIControlStateNormal];
        }
    }
}

- (void)setNormalFont:(UIFont *)normalFont {
    _normalFont = normalFont;
    for (UIView *subView in self.wrapperView.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton *otherButton = (UIButton *)subView;
            otherButton.titleLabel.font = normalFont;
        }
    }
}


#pragma mark - public

- (void)enableTabAtIndex:(NSInteger)index {
    UIButton *targetButton = [_wrapperView viewWithTag:kButtonTag + index];
    if (targetButton) {
        targetButton.enabled = YES;
    }
}

- (void)disableTabAtIndex:(NSInteger)index {
    UIButton *targetButton = [_wrapperView viewWithTag:kButtonTag + index];
    if (targetButton) {
        targetButton.enabled = NO;
        if (_selectedIndex == index) {
            // move to the next one;
            NSInteger next = (index + 1) % self.titles.count;
            [self selectTabAtIndex:next];
        }
    }
}

- (void)setTitles:(NSArray<NSString *> *)titles {
    _titles = titles;
    [self reloadTabs];
    [self selectTabAtIndex:0];
}


#pragma mark -private

- (CGFloat)tabWidth {
    if (self.titles.count) {
        return (self.frame.size.width / self.titles.count);
    } else {
        return self.self.frame.size.width;
    }
}

@end
