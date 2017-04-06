//
//  UnfoldTabView.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/5.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "UnfoldTabView.h"
#import "ATCommonCell.h"

static CGFloat kContentBackgroundHeight = 472;

@interface UnfoldTabView() <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataSourceArray;

@property (nonatomic, strong) UIView *bgView;

@end

@implementation UnfoldTabView


- (id)initWithDataSource:(id<UnfoldTableViewDataSource>)dataSource andHeight:(CGFloat)height {
    if (self = [super init]) {
        
        [ATKeyWindow addSubview:self];
        self.clipsToBounds = YES;
        self.frame = CGRectMake(0, 64, kScreenWidth, height);
 
        WS(weakSelf);
        UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight)];
        maskView.backgroundColor = [Theme colorForToolbarBackground];
        [self addSubview:maskView];
        [maskView bk_whenTapped:^{
            [weakSelf dismissWithFinishBlock];
        }];
        
        if (dataSource) {
            self.dataSource = dataSource;
            self.tag = 5001;
          
            
            UITableView *detailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, [Theme paddingWithSize:300])];
            [self addSubview:detailTableView];
            detailTableView.tag = 1002;
            detailTableView.delegate = self;
            detailTableView.dataSource = self;
            detailTableView.scrollEnabled = false;
            detailTableView.showsVerticalScrollIndicator = NO;
            detailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            detailTableView.rowHeight = [Theme paddingWithSize:80];
            detailTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, detailTableView.frame.size.width, [Theme paddingWithSize:40 - 32 / 2.0])];

        }
        
    }
    
    return self;
}

#pragma mark - getter
- (CGFloat)contentHeight {
    return [Theme paddingWithSize:kContentBackgroundHeight];
}


- (void)show {
    [self showTipViewAtBottom];

    UITableView *detailTableView = [self viewWithTag:1002];
    [UIView animateWithDuration:0.25 animations:^{
        
        CGRect newframe = detailTableView.frame;
        newframe.origin.y = [Theme paddingWithSize:86];
        detailTableView.frame = newframe;

        
    } completion:^(BOOL finished) {
    }];
    

    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)dismissWithFinishBlock {
    
    WS(weakSelf);
    UITableView *detailTableView = [self viewWithTag:1002];
    [UIView animateWithDuration:0.25 animations:^{
        CGRect newframe = detailTableView.frame;
        newframe.origin.y = -1000;
        detailTableView.frame = newframe;
        weakSelf.alpha = 0;
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
        if (weakSelf.dismissBlock) {
            weakSelf.dismissBlock();
        }
    }];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)dismiss {
    
    WS(weakSelf);
    UITableView *detailTableView = [self viewWithTag:1002];
    [UIView animateWithDuration:0.25 animations:^{
        CGRect newframe = detailTableView.frame;
        newframe.origin.y = -1000;
        detailTableView.frame = newframe;
        weakSelf.alpha = 0;
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)showTipViewAtBottom {
    if ([self.dataSource respondsToSelector:@selector(tipNoteAtBottom)]) {
        NSString *tip = [self.dataSource tipNoteAtBottom];
        UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        tipLabel.text = tip;
        tipLabel.textColor = [OIAppTheme colorForTextNotes];
        tipLabel.textAlignment = NSTextAlignmentCenter;
        tipLabel.font = [OIAppTheme fontWithSize24];
        [self  addSubview:tipLabel];
        WS(weakSelf);
        [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(weakSelf);
            make.height.equalTo(@([OIAppTheme fontWithSize24].lineHeight));
            make.bottom.equalTo(weakSelf).offset(-[OIAppTheme paddingWithSize32]);
        }];
    }
}

#pragma mark - UITableViewDataSource


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    id title = [self.dataSource dataForRowAtIndexPath:indexPath];
    [self.dataSource dataForRowAtIndexPath:title didSelectRowAtIndexPath:indexPath];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.dataSource respondsToSelector:@selector(numberOfRowsInOrderDetailsView)]) {
        return [self.dataSource numberOfRowsInOrderDetailsView];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ATCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ATCommonCell class])];
    if (!cell) {
        cell = [[ATCommonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([ATCommonCell class]) components:ATCommonCellComponentDefault];
       
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    id title = [self.dataSource dataForRowAtIndexPath:indexPath];
    
    UILabel *titleLabel = cell.componentsMap[@(ATCommonCellComponentTitleLabel)];
    titleLabel.textColor = [OIAppTheme colorForTextTitle];
    titleLabel.font = [OIAppTheme fontWithSize28];
    
   [titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
       make.centerX.centerY.equalTo(cell.contentView);
   }];
    
    titleLabel.text = title;
    cell.bottomSeparatorStyle = ATCommonCellSeparatorStyleSymmetricalDefault;
    if (indexPath.row == 0) {
        cell.topSeparatorStyle = ATCommonCellSeparatorStyleFullLength;
    }
    

    return cell;
    
}


@end
