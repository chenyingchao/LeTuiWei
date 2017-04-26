//
//  AllIncomeView.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/25.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "AllIncomeView.h"

@interface AllIncomeView()<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

@property (strong, nonatomic)  UITableView *leftTableView;

@property (strong, nonatomic)  UITableView *rightTableView;

@property (strong, nonatomic)  UIView *tabBgView;

@property (nonatomic, strong) UIView *maskView;

@property (nonatomic, assign) CGFloat originY;

@property (nonatomic, strong) NSArray *leftArray;

@property (nonatomic, strong) NSArray *rightArray;;

@end

@implementation AllIncomeView

-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.originY = self.frame.origin.y;
        self.frame = CGRectMake(0,-1000, kScreenWidth, kScreenHeight);
        
        self.backgroundColor =  [[UIColor blackColor] colorWithAlphaComponent:0.5];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];

        [self initData];
    }
    return self;
}

#pragma mark 创建二级联动tabview
- (void)createTableView {

    _leftArray = [[NSArray alloc] initWithObjects:@"第一类",@"第二类",@"第三类",@"第四类",@"第五类",@"第六类",@"第七类",@"第八类", nil];
    
    _rightArray = [[NSArray alloc] initWithObjects:@"一",@"二",@"三",@"四",@"五",@"六", nil];
    
    
    self.tabBgView = [[UIView alloc] initWithFrame:CGRectMake(0,-1000, kScreenWidth, 200)];
    self.tabBgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.tabBgView];
    [self sendSubviewToBack:self.tabBgView];
    
    
    CGFloat width = kScreenWidth / 4;
    _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width, 200) style:UITableViewStyleGrouped];
    _leftTableView.delegate = self;
    _leftTableView.dataSource = self;
    _leftTableView.showsVerticalScrollIndicator = NO;
    _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _leftTableView.backgroundColor = [UIColor whiteColor];
    [self.tabBgView addSubview:_leftTableView];
    
    _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenWidth / 4, 0, width * 3, 200) style:UITableViewStyleGrouped];
    _rightTableView.delegate = self;
    _rightTableView.dataSource = self;
    _rightTableView.showsVerticalScrollIndicator = NO;
    _rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _rightTableView.backgroundColor = [UIColor whiteColor];
    [self.tabBgView addSubview:_rightTableView];
    
    [_leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];

}

#pragma mark  delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (tableView == _rightTableView) {
        
        return [_leftArray count];
    }
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.leftTableView) {
        
        return _leftArray.count;
        
    }
    
    else if (tableView == self.rightTableView) {
        
        return _rightArray.count;
        
    }
    
    return 1;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (tableView == self.leftTableView) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leftCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"leftCell"];
        }
        
        cell.textLabel.text = [_leftArray objectAtIndex:indexPath.row];
        cell.textLabel.font = [Theme fontWithSize28];
        cell.textLabel.textColor = [Theme colorDarkGray];
        cell.textLabel.highlightedTextColor = UIColorFromRGB(0x3f88cd);
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
        
        return cell;
        
    } else {
        

        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rightCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"rightCell"];
        }
        
        
        cell.textLabel.text = [_rightArray objectAtIndex:indexPath.row];
        cell.contentView.backgroundColor = [Theme colorForAppBackground];
        cell.textLabel.font = [Theme fontWithSize28];
        cell.textLabel.textColor = [Theme colorDarkGray];
        cell.textLabel.highlightedTextColor = UIColorFromRGB(0x3f88cd);
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
        
        return cell;
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == _leftTableView) {
        
        [_rightTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.row] animated:YES scrollPosition:UITableViewScrollPositionTop];
        
    } else {
        
        [_leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.section inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
        [self dissmisTabView];
        [self dissmisAllIncomeHeaderView];
        
        if ([self.allIncomeDelegate respondsToSelector:@selector(allIncomeView:didSelectData:)]) {
            
            [self.allIncomeDelegate allIncomeView:self didSelectData:_rightArray[indexPath.row]];
        }
        
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {

    if (scrollView == _rightTableView) {
        
        NSIndexPath *indexPath = [[_rightTableView indexPathsForVisibleRows ] objectAtIndex:0];
        
        [_leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.section inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
        
    }
    
}

//滑动停止时执行
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    
    if (scrollView == _rightTableView) {
        
        NSIndexPath *indexPath = [[_rightTableView indexPathsForVisibleRows ] objectAtIndex:0];
        
        [_leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.section inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
        
    }
    
}

- (void)showAllIncomeHeaderView {
    WS(weakSelf)
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.frame = CGRectMake(0, weakSelf.originY, kScreenWidth, kScreenHeight );
        
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)dissmisAllIncomeHeaderView {
    WS(weakSelf)
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.frame = CGRectMake(0, -1000, kScreenWidth, kScreenHeight);
        
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)showTabView {
    WS(weakSelf)
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.tabBgView.frame = CGRectMake(0, [Theme paddingWithSize:84], kScreenWidth, 200);
        
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)dissmisTabView {
    WS(weakSelf)
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.tabBgView.frame = CGRectMake(0, -1000, kScreenWidth, 200);
        
        
    } completion:^(BOOL finished) {
        
    }];
    
    
}

#pragma 创建收款的筛选框
- (void)initData {
    WS(weakSelf);
 
    NSArray *titleArray =  @[@"全部收款", @"含商品订单",@"无商品订单",@"会员充值"];
    CGFloat width = kScreenWidth / titleArray.count;
    for (NSInteger i = 0; i < titleArray.count; i++) {
        
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor whiteColor];
        [button setTitleColor:[Theme colorGray] forState:UIControlStateNormal];
        [button setTitleColor:UIColorFromRGB(0x3f88cd) forState:UIControlStateSelected];
        button.titleLabel.font = [Theme fontWithSize28];
        [self addSubview:button];
        button.tag = i + 300;
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.mas_top);
            make.height.equalTo(@([Theme paddingWithSize:84]));
            make.left.equalTo(weakSelf).offset(width * i);
            make.width.equalTo(@(width));
            
        }];

        [button bk_whenTapped:^{

            [weakSelf selectButtonStatus:button];
            
        }];
        
    }
    
    UIView *view = [self viewWithTag:300];
    UIButton *button = (UIButton *)view;
    
    [self selectButtonStatus:button];
    
}

- (void)selectButtonStatus:(UIButton *)button {
    
    button.selected = !button.selected;

    switch (button.tag) {
        case IncomeButtonTypeAllIncome: {
            [self dissmisTabView];
            [self dissmisAllIncomeHeaderView];
       
            if ([self.allIncomeDelegate respondsToSelector:@selector(allIncomeView:didSelectData:)]) {
                [self.allIncomeDelegate allIncomeView:self didSelectData:@"全部收款"];
            }
            
        }
            
            break;
        case IncomeButtonTypeOrderProduct: {
            
            if (!self.leftTableView) {
                [self createTableView];
            }
               [self showTabView];
        }
            
            break;
        case IncomeButtonTypeOrderNoProduct: {
            [self dissmisTabView];
            [self dissmisAllIncomeHeaderView];
            
            if ([self.allIncomeDelegate respondsToSelector:@selector(allIncomeView:didSelectData:)]) {
                [self.allIncomeDelegate allIncomeView:self didSelectData:@"无商品订单"];
            }

        }
            
            break;
        case IncomeButtonTypeOrderVipTopUp: {
        
            [self dissmisTabView];
            [self dissmisAllIncomeHeaderView];
            
            if ([self.allIncomeDelegate respondsToSelector:@selector(allIncomeView:didSelectData:)]) {
                [self.allIncomeDelegate allIncomeView:self didSelectData:@"会员充值"];
            }

        }
            
            break;

    }
    
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *otherButton = (UIButton *)view;
            
            if (otherButton.tag != button.tag) {
                otherButton.selected = NO;
            } else {
            
                if (button.selected == NO) {
                    button.selected = YES;
                }
            }
           
            
        }
    }
    
}

- (void)tap:(UIGestureRecognizer *)gr  {
    
    [self dissmisTabView];
    [self dissmisAllIncomeHeaderView];
    
    if ([self.allIncomeDelegate respondsToSelector:@selector(allIncomeView:didSelectData:)]) {
        
        [self.allIncomeDelegate allIncomeView:self didSelectData:@""];
    }
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if ([touch.view isDescendantOfView:self.leftTableView]) {
        
        return NO;
        
    }
    
    if ([touch.view isDescendantOfView:self.rightTableView]) {
        
        return NO;
        
    }
    
    return YES;
    
}

@end
