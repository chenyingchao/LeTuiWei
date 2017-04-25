//
//  SiftView.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/24.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "SiftView.h"
#import "SiftViewCell.h"
#import "AllIncomeView.h"
@interface SiftView() <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate, AllIncomeDelegate>

@property (nonatomic, assign) NSInteger storeQuantity;

@property (nonatomic, assign) CGFloat interval;

@property (nonatomic, strong) UIView *maskView;

@property (nonatomic, assign) BOOL isShow;

@property (nonatomic, strong) AllIncomeView *allIncomeView;


@end

@implementation SiftView

-(instancetype)initWithFrame:(CGRect)frame storeQuantity:(NSInteger)storeQuantity{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.storeQuantity = storeQuantity;
        [self initData];
      
    }
    return self;
}

- (void)createTableView {
    WS(weakSelf);
    
    
    _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, -1000, kScreenWidth, kScreenHeight - CGRectGetMaxY(self.frame))];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    tap.delegate = self;
    [_maskView addGestureRecognizer:tap];

    _maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];;
   // _maskView.alpha =  0.8;
    [ATKeyWindow insertSubview:_maskView belowSubview:self];
    
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.maskView addSubview:_tableView];
    [_tableView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(weakSelf.maskView);
        make.top.equalTo(weakSelf.maskView);
        make.height.equalTo(@([Theme paddingWithSize:300]));
    }];
    
}

#pragma mark 创建全部收款View
- (void)createAllIncomeView {
    
    _allIncomeView = [[AllIncomeView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.frame), kScreenWidth, kScreenHeight)];
    _allIncomeView.allIncomeDelegate = self;
    [ATKeyWindow insertSubview:_allIncomeView belowSubview:self];

}

#pragma mark 创建全部收款View delegate
- (void)allIncomeView:(AllIncomeView *)allIncomeView didSelectData:(NSString *)selectData {
    
    UIButton *button = [self viewWithTag:SiftViewButtonTypeAllIncome];
    button.selected = NO;
    if (!selectData.length) {
        //点击遮罩 关闭视图 不刷新 筛选条件
        return;
    }
    
    [button setTitle:selectData forState:UIControlStateNormal];
    CGSize size = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) textFont: [Theme fontWithSize28] aimString:selectData];
    button.imageEdgeInsets = UIEdgeInsetsMake(0,size.width + _interval, 0, -(size.width + _interval));
    button.titleEdgeInsets = UIEdgeInsetsMake(0, -([UIImage imageNamed:@"down"].size.width + _interval), 0, [UIImage imageNamed:@"down"].size.width + _interval);
    
  
    
    if ([self.siftDelegate respondsToSelector:@selector(siftView:didSelectedData:)]) {
        NSMutableArray *siftArray = [[NSMutableArray alloc] init];
        for (UIView *view in self.subviews) {
            if ([view isKindOfClass:[UIButton class]]) {
                UIButton *button = (UIButton *)view;
                [siftArray addObject:button.titleLabel.text];
            }
        }
        //传递筛选条件
        [self.siftDelegate siftView:self didSelectedData:siftArray];
    }
        
    


}

- (void)showView {
    WS(weakSelf);
    
    if (!self.maskView) {
        [self createTableView];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.maskView.frame = CGRectMake(0, CGRectGetMaxY(weakSelf.frame), kScreenWidth, kScreenHeight - CGRectGetMaxY(self.frame));
        
        
    } completion:^(BOOL finished) {
    }];
    
}

- (void)closeView {
    WS(weakSelf);
    
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.maskView.frame = CGRectMake(0, -1000, kScreenWidth, kScreenHeight - CGRectGetMaxY(self.frame));
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)selectButtonStatus:(UIButton *)button {
    
    button.selected = !button.selected;
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *otherButton = (UIButton *)view;
            
            if (otherButton.tag == button.tag) {
                continue;
            }
            otherButton.selected = NO;
            
        }
    }
    
    if (button.tag == SiftViewButtonTypeAllIncome) {
        
        if (button.selected) {
            [self closeView];
            if (!_allIncomeView) {
               [self createAllIncomeView]; 
            }
            
            [_allIncomeView showAllIncomeHeaderView];
        } else {
            [_allIncomeView dissmisAllIncomeHeaderView];
        
        }
        
        
        return;
    }
    
    
    if (button.selected) {
        self.buttonType = button.tag;
        [self showView];
         [_allIncomeView dissmisAllIncomeHeaderView];
        
    } else {
        [self closeView];
    }
    
     //传递筛选的选择button
    if ([self.siftDelegate respondsToSelector:@selector(siftView:didSelectedButtonType:buttonStatus:)]) {
        [self.siftDelegate siftView:self didSelectedButtonType:button.tag buttonStatus:button.selected];
    }

}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.siftDelegate respondsToSelector:@selector(numberOfRowsInOrderDetailsView)]) {
        WS(weakSelf);
        [tableView  mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.left.equalTo(weakSelf.maskView);
            make.top.equalTo(weakSelf.maskView);
            if ([self.siftDelegate numberOfRowsInOrderDetailsView] < 5) {
                make.height.equalTo(@( [Theme paddingWithSize:84] * [self.siftDelegate numberOfRowsInOrderDetailsView] ));
            } else {
                make.height.equalTo(@([Theme paddingWithSize:300]));
            }
       
        }];

        [tableView setContentOffset:CGPointMake(0, 0) animated:YES];

        return [self.siftDelegate numberOfRowsInOrderDetailsView];
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return [Theme paddingWithSize:84];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   // 只负责 全部门店、 全部渠道、 全部工具 筛选条件的更新
    UIView *view = [self viewWithTag:self.buttonType];
    if ([view isKindOfClass:[UIButton class]]) {
        UIButton *button = (UIButton *)view;
    
        [button setTitle:[self.siftDelegate dataForRowAtIndexPath:indexPath] forState:UIControlStateNormal];
        CGSize size = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) textFont: [Theme fontWithSize28] aimString:[self.siftDelegate dataForRowAtIndexPath:indexPath] ];
        button.imageEdgeInsets = UIEdgeInsetsMake(0,size.width + _interval, 0, -(size.width + _interval));
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -([UIImage imageNamed:@"down"].size.width + _interval), 0, [UIImage imageNamed:@"down"].size.width + _interval);
        button.selected = NO;
        [self closeView];
        
        
        if ([self.siftDelegate respondsToSelector:@selector(siftView:didSelectedData:)]) {
            NSMutableArray *siftArray = [[NSMutableArray alloc] init];
            for (UIView *view in self.subviews) {
                if ([view isKindOfClass:[UIButton class]]) {
                    UIButton *button = (UIButton *)view;
                    [siftArray addObject:button.titleLabel.text];
                }
            }
            //传递筛选条件
            [self.siftDelegate siftView:self didSelectedData:siftArray];
        }
        
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    SiftViewCell *cell = nil;
    if (!cell) {
        cell = [[SiftViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    NSString *str = [self.siftDelegate dataForRowAtIndexPath:indexPath];
    
    UIView *view = [self viewWithTag:self.buttonType];
    if ([view isKindOfClass:[UIButton class]]) {
        UIButton *button = (UIButton *)view;
        NSString *titleStr = button.titleLabel.text;
        if ([str isEqualToString:titleStr]) {
            cell.contentLabel.textColor = UIColorFromRGB(0x3f88cd);
        }
    }
    
    cell.contentLabel.text = str;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return CGFLOAT_MIN;
}


- (void)tap:(UIGestureRecognizer *)gr {
    [self closeView];
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *otherButton = (UIButton *)view;
            otherButton.selected = NO;
            
        }
    }

}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if ([touch.view isDescendantOfView:self.tableView]) {
        
        return NO;
        
    }
    
    
    
    return YES;
    
}


- (void)initData {
    WS(weakSelf);
    
    _interval = 3.0;
    NSArray *titleArray = self.storeQuantity > 1 ?  @[@"全部门店", @"全部收款",@"全部渠道",@"全部工具"] :  @[@"全部收款",@"全部渠道",@"全部工具"];
    CGFloat width = kScreenWidth / titleArray.count;
    for (NSInteger i = 0; i < titleArray.count; i++) {
        
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"up"] forState:UIControlStateSelected];
        [button setTitleColor:[Theme colorGray] forState:UIControlStateNormal];
        button.titleLabel.font = [Theme fontWithSize28];
        
        
        [self addSubview:button];
        button.tag = i + 100;
        CGSize size = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) textFont: [Theme fontWithSize28] aimString:titleArray[i]];
        button.imageEdgeInsets = UIEdgeInsetsMake(0,size.width + _interval, 0, -(size.width + _interval));
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -([UIImage imageNamed:@"down"].size.width + _interval), 0, [UIImage imageNamed:@"down"].size.width + _interval);
        
        
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf.mas_bottom);
            make.height.equalTo(@([Theme paddingWithSize:84]));
            make.left.equalTo(weakSelf).offset(width * i);
            make.width.equalTo(@(width));
            
        }];
        
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectZero];
        [self addSubview:line];
        line.backgroundColor = [Theme colorForSeparatorLine];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf).offset(width *( i + 1));
            make.bottom.equalTo(weakSelf.mas_bottom).offset(-[Theme paddingWithSize20]);
            make.height.equalTo(@([Theme paddingWithSize:84] - 2 * [Theme paddingWithSize20]));
            make.width.equalTo(@(kSeparatorHeight));
        }];
        
        
        [button bk_whenTapped:^{
            
            [weakSelf selectButtonStatus:button];
            
        }];
    }
    
}

#pragma mark 返回字符串尺寸
- (CGSize)sizeOfStringWithMaxSize:(CGSize)maxSize textFont:(UIFont *)fontSize aimString:(NSString *)aimString{
    
    
    return [[NSString stringWithFormat:@"%@",aimString] boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:fontSize} context:nil].size;
    
}

@end
