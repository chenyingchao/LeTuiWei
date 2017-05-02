//
//  DataChartViewCell.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/27.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "DataChartViewCell.h"
#import "LineChartView.h"
#import "RingChartView.h"
#import "ColumnChartView.h"

@interface DataChartViewCell()<UITextViewDelegate>

@end


@implementation DataChartViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withDataSource:(id)dataSource withCellType:(DataChartViewCellType)cellType {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier components:ATCommenCellComponentEmpty];
    self.opaque = YES;
    if (self) {
        
        switch (cellType) {
          
            case DataChartViewCellTypeTrendChart: {
                
                [self createOrderMoneyStatisticView:dataSource];
            }
                
                break;
                
            case DataChartViewCellTypeTop5: {
                
                [self createProductTop5:dataSource];
            }
                
                break;
                
        }
        
        
    }
    return self;
}

#pragma  mark 门店订单金额统计
- (void)createOrderMoneyStatisticView:(id)dataSource {
    WS(weakSelf);
    UILabel *titleNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleNameLabel.font = [Theme fontWithSize30];
    titleNameLabel.textColor = [Theme colorDarkGray];
    titleNameLabel.text = @"趋势图";
    [self.contentView addSubview:titleNameLabel];
    
    [titleNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.contentView).offset([Theme paddingWithSize32]);
        make.top.equalTo(weakSelf.contentView).offset([Theme paddingWithSize32]);;
    }];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectZero];
    lineView.backgroundColor = [Theme colorForSeparatorLine];
    
    [self.contentView addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).offset([Theme paddingWithSize32]);
        make.right.equalTo(weakSelf.contentView).offset(-[Theme paddingWithSize32]);
        make.top.equalTo(titleNameLabel.mas_bottom).offset([Theme paddingWithSize32]);
        make.height.equalTo(@(kSeparatorHeight));
    }];
    
    UILabel *moneyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    moneyLabel.font = [Theme fontWithSize30];
    moneyLabel.textColor = [Theme colorGray];
    moneyLabel.text = @"金额84000.90";
    [self.contentView addSubview:moneyLabel];
    
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(lineView.mas_bottom).offset([Theme paddingWithSize32]);
        make.right.equalTo(weakSelf.contentView.mas_centerX).offset(-[Theme paddingWithSize40]);
    }];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    timeLabel.font = [Theme fontWithSize30];
    timeLabel.textColor = [Theme colorGray];
    timeLabel.text = @"时间84000.90";
    [self.contentView addSubview:timeLabel];
    
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(lineView.mas_bottom).offset([Theme paddingWithSize32]);
        make.left.equalTo(weakSelf.contentView.mas_centerX).offset([Theme paddingWithSize40]);
    }];
    
    
    LineChartView *lineChart = [[LineChartView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, [Theme paddingWithSize:270])];
    lineChart.contentInsets = UIEdgeInsetsMake([Theme paddingWithSize40], [Theme paddingWithSize100], [Theme paddingWithSize40], [Theme paddingWithSize100]);
    
    lineChart.checkInDateStr = @"2017-04-02";
    lineChart.checkOutDateStr = @"2017-04-06";
    
    //假数据
    NSDate *checkIndate = [NSDate at_dateFromString: lineChart.checkInDateStr];
    NSDate *checkOutdate = [NSDate at_dateFromString: lineChart.checkOutDateStr];
    NSInteger days = [checkIndate daysBetween:checkOutdate];
    NSMutableArray *mockArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < days; i++) {
        
        CGFloat num = arc4random() % 10000;
        [mockArray addObject:[NSNumber numberWithFloat:num]];
        
    }
    NSComparisonResult result = [checkIndate compare:checkOutdate];
    if (result == NSOrderedSame) {
        lineChart.valueArr = @[@100.5,@2123,@789.951,@1232.1,@1000,@300,@1000];
    } else {
        lineChart.valueArr = mockArray;
        
        
    }

    lineChart.showYLine = NO;
    lineChart.showYLevelLine = YES;
    lineChart.isDataChartView = YES;
    lineChart.xTextColor = [Theme colorGray];
    lineChart.yTextColor = [Theme colorGray];
    lineChart.yLineColor = [Theme colorForSeparatorLine];
    lineChart.gradientColor = UIColorFromRGB(0xe3eaf9);
    [lineChart showAnimation];
    [self.contentView addSubview:lineChart];
    [lineChart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf);
        make.top.equalTo(moneyLabel.mas_bottom).offset([Theme paddingWithSize32]);
        make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-[Theme paddingWithSize:65]);
        make.height.equalTo(@([Theme paddingWithSize:270]));
        
    }];
    
    lineChart.didSelectPointBlock = ^(NSString *dateStr, NSString *moneyStr){
        
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"金额%@元",moneyStr]];
        
        [attrStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xf9d542) range:NSMakeRange(2, moneyStr.length + 1)];
        
        moneyLabel.attributedText = attrStr;
        
        
        NSMutableAttributedString *attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"时间%@",dateStr]];
        
        [attrStr1 addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xf9d542) range:NSMakeRange(2, dateStr.length)];
        
        timeLabel.attributedText = attrStr1;
        
    };

    
}

#pragma mark 明星产品top5
- (void)createProductTop5:(id)dataSource {
    WS(weakSelf);

    UILabel *titleNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleNameLabel.font = [Theme fontWithSize30];
    titleNameLabel.textColor = [Theme colorDarkGray];
    titleNameLabel.text = @"明星产品TOP5";
    [self.contentView addSubview:titleNameLabel];
    
    [titleNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.contentView).offset([Theme paddingWithSize32]);
        make.top.equalTo(weakSelf.contentView).offset([Theme paddingWithSize32]);;
    }];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectZero];
    lineView.backgroundColor = [Theme colorForSeparatorLine];
    
    [self.contentView addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).offset([Theme paddingWithSize32]);
        make.right.equalTo(weakSelf.contentView).offset(-[Theme paddingWithSize32]);
        make.top.equalTo(titleNameLabel.mas_bottom).offset([Theme paddingWithSize32]);
        make.height.equalTo(@(kSeparatorHeight));
    }];
    
    NSArray *array = [NSArray arrayWithObjects:@"按销量",@"按销售额", nil];
    
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:array];
    segment.backgroundColor = [Theme colorWhite];
    segment.apportionsSegmentWidthsByContent = YES;
    segment.layer.masksToBounds = YES;
    segment.layer.borderWidth = CGFLOAT_MIN;
    segment.layer.cornerRadius = 5;
    segment.tintColor = UIColorFromRGB(0xdfdfdf);
    segment.selectedSegmentIndex = 0;
    [segment setTitleTextAttributes:@{NSForegroundColorAttributeName :[Theme colorDarkGray]} forState:UIControlStateSelected];
    [segment setTitleTextAttributes:@{NSForegroundColorAttributeName : [Theme colorGray]} forState:UIControlStateNormal];
    [segment addTarget:self action:@selector(segmentSelected:) forControlEvents:UIControlEventValueChanged];
    
    [self.contentView addSubview:segment];
    [segment mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(titleNameLabel);
        make.right.equalTo(weakSelf.contentView).offset(-[Theme paddingWithSize32]);
        
        make.height.equalTo(@([Theme paddingWithSize:50]));
        
    }];
    
    if (!dataSource) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"尚未开通“会员营销”功能，不能统计明星产品，要想展开此数据，请先为门店派账号开通“开通智慧门店”"];
        [attributedString addAttribute:NSLinkAttributeName
                                 value:@"openStore://"
                                 range:[[attributedString string] rangeOfString:@"开通“开通智慧门店”"]];
        
        [attributedString addAttribute:NSFontAttributeName
                                 value:[Theme fontWithSize28]
                                 range:NSMakeRange(0, attributedString.length)];
        
        [attributedString addAttribute:NSForegroundColorAttributeName
                                 value:UIColorFromRGB(0xc5cae9)
                                 range:NSMakeRange(0, attributedString.length)];
        
        
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectZero];
        textView.backgroundColor =  UIColorFromRGB(0x1b224c);
        textView.delegate = self;
        textView.editable = NO;
        textView.scrollEnabled = NO;
        textView.font = [Theme fontWithSize30];
        textView.textColor = UIColorFromRGB(0xc5cae9);
        textView.linkTextAttributes = @{NSForegroundColorAttributeName:
                                            UIColorFromRGB(0x338cf2),
                                        NSUnderlineColorAttributeName:  UIColorFromRGB(0x338cf2),
                                        NSUnderlineStyleAttributeName: @(NSUnderlinePatternSolid)};
        
        [self.contentView addSubview:textView];
        
        
        textView.attributedText = attributedString;
        [textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.contentView).offset([Theme paddingWithSize40]);
            make.right.equalTo(weakSelf.contentView).offset(-[Theme paddingWithSize40]);
            make.top.equalTo(titleNameLabel.mas_bottom).offset([Theme paddingWithSize40]);
            make.bottom.equalTo(weakSelf.contentView).offset(-[Theme paddingWithSize40]);
        }];
        
        return;
        
    }
    
    
    ColumnChartView *columnChart = [[ColumnChartView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, [Theme paddingWithSize:400])];
    columnChart.contentInsets = UIEdgeInsetsMake([Theme paddingWithSize40], [Theme paddingWithSize120], [Theme paddingWithSize40], [Theme paddingWithSize120]);
    columnChart.xLineDataArr = @[@"0", @"20",@"40", @"60", @"80"];
    columnChart.yLineDataArr = @[@"top1", @"top2",@"top3", @"top4", @"top5"];
    columnChart.xTextColor = [Theme colorDarkGray];
    columnChart.yTextColor = [Theme colorDarkGray];
    columnChart.yLineColor = [Theme colorForSeparatorLine];
    columnChart.columnTextColor = [Theme colorDarkGray];

    
    columnChart.valueArr = @[@"20",@"30",@"10",@"70",@"40"];
    columnChart.columnColorArr =  @[UIColorFromRGB(0x00d452),UIColorFromRGB(0x2d8cf8),UIColorFromRGB(0x26cef0),UIColorFromRGB(0x9c50d1),UIColorFromRGB(0xffc72c)];
    
    [columnChart showAnimation];
    [self.contentView addSubview:columnChart];
    [columnChart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.contentView);
        make.top.equalTo(lineView.mas_bottom).offset([Theme paddingWithSize32]);
        make.height.equalTo(@([Theme paddingWithSize:400]));
        
    }];
    
    UIView *tempView = nil;
    
    for (NSInteger i = 0; i < columnChart.valueArr.count; i++) {
        
        
        if (i % 2) {
            
        }
        
        if (tempView) {
            UIView *circleView = [[UIView alloc] initWithFrame:CGRectZero];
            circleView.backgroundColor = columnChart.columnColorArr[i];
            circleView.layer.cornerRadius = [Theme paddingWithSize20] / 2;
            circleView.layer.masksToBounds = YES;
            [self.contentView addSubview:circleView];
            
            [circleView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@([Theme paddingWithSize20]));
                make.width.equalTo(@([Theme paddingWithSize20]));
                
                if (i % 2 == 0 ) {
                    make.left.equalTo(weakSelf.contentView).offset([Theme paddingWithSize40]);
                    make.top.equalTo(tempView.mas_bottom).offset([Theme paddingWithSize28]);
                } else {
                    
                    make.left.equalTo(weakSelf.contentView.mas_centerX).offset([Theme paddingWithSize20]);
                    make.top.equalTo(tempView);
                }
                
                
            }];
            tempView = circleView;
        } else {
            
            UIView *circleView = [[UIView alloc] initWithFrame:CGRectZero];
            circleView.backgroundColor = columnChart.columnColorArr[i];
            circleView.layer.cornerRadius = [Theme paddingWithSize20] / 2;
            circleView.layer.masksToBounds = YES;
            [self.contentView addSubview:circleView];
            
            [circleView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@([Theme paddingWithSize20]));
                make.width.equalTo(@([Theme paddingWithSize20]));
                make.left.equalTo(weakSelf.contentView).offset([Theme paddingWithSize40]);
                make.top.equalTo(columnChart.mas_bottom).offset([Theme paddingWithSize40]);
            }];
            tempView = circleView;
            
        }
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        titleLabel.font = [Theme fontWithSize24];
        titleLabel.textColor = [Theme colorGray];
        titleLabel.text = @"安达市大所发";
        titleLabel.numberOfLines = 0;
        [self.contentView addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(tempView.mas_right).offset([Theme paddingWithSize20]);
            make.centerY.equalTo(tempView);
            make.width.equalTo(@(kScreenWidth / 2 - [Theme paddingWithSize100]));
        }];
        
        
        
        if (i == columnChart.valueArr.count - 1) {
            [tempView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-[Theme paddingWithSize:50]);
            }];
        }
    }
}

- (void)segmentSelected:(id)sender {
    UISegmentedControl* control = (UISegmentedControl*)sender;
    if (self.segmentIndexBlock) {
        self.segmentIndexBlock(control.selectedSegmentIndex);
    }
}


- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    if ([[URL scheme] isEqualToString:@"openStore"]) {
        if (self.openWisdomStoreBlock) {
            self.openWisdomStoreBlock();
        }
        return NO;
    }
    
    return YES;
}

@end
