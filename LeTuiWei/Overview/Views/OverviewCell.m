//
//  OverviewCell.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/17.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "OverviewCell.h"
#import "LineChartView.h"
#import "RingChartView.h"
#import "ColumnChartView.h"


@interface OverviewCell()<UITextViewDelegate>

@end


@implementation OverviewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withDataSource:(id)dataSource withCellType:(OverviewCellType)cellType {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier components:ATCommenCellComponentEmpty];
    self.opaque = YES;
    if (self) {
        
        switch (cellType) {
            case OverviewCellTypeStoreDate: {
            
                [self createStoreDataView:dataSource withCellType: cellType];
            }
               
                break;
            case OverviewCellTypeOrderMoneyStatistics: {
                
                [self createOrderMoneyStatisticView:dataSource];
            }
                
                break;
                
            case OverviewCellTypePayTypeProportion: {
                
                [self createPayTypeProportion:dataSource withCellType:cellType];
            }
                
                break;
                
            case OverviewCellTypeProductTop5: {
                
                [self createProductTop5:dataSource];
            }
                
                break;
                
            case OverviewCellTypeOrderDistributionMap: {
                
                [self createOrderDistributionMapView:dataSource];
            }
                
                break;
                
            case OverviewCellTypeVipDate: {
                
                [self createStoreDataView:dataSource withCellType: cellType];
            }
                
                break;
                
            case OverviewCellTypeWeixinPayFuns: {
                
                [self createWeiXinPayFunsView:dataSource];
            }
                
                break;
                
            case OverviewCellTypeTakeOutDate: {
                
                [self createStoreDataView:dataSource withCellType: cellType];
            }
                
                break;
                
            case OverviewCellTypeTakeOutProportion: {
                
                [self createPayTypeProportion:dataSource withCellType: cellType];
            }
                
                break;
                
                
            default:
                
                break;
        }
        
 
    }
    return self;
}



#pragma  mark 微信加粉数
- (void)createWeiXinPayFunsView:(id)dataSource {
    WS(weakSelf);
    
    
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"加粉总数:148"];
 
    [AttributedStr addAttribute:NSFontAttributeName
  
                                 value:[Theme fontWithSize40]
         
                                 range:NSMakeRange(5, AttributedStr.length - 5)];
 
    [AttributedStr addAttribute:NSForegroundColorAttributeName
         
                                    value:UIColorFromRGB(0xf9d542)
         
                                     range:NSMakeRange(5, AttributedStr.length - 5)];
    
    UILabel *funsTotalLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    funsTotalLabel.font = [Theme fontWithSize30];
    funsTotalLabel.textColor = UIColorFromRGB(0xc5cae9);
    funsTotalLabel.attributedText = AttributedStr;
    [self.contentView addSubview:funsTotalLabel];
    [funsTotalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.contentView);
        make.top.equalTo(weakSelf.contentView).offset([Theme paddingWithSize40]);
    }];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectZero];
    bgView.backgroundColor = UIColorFromRGB(0x222b59);
    
    [self.contentView addSubview:bgView];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).offset([Theme paddingWithSize32]);
        make.right.equalTo(weakSelf.contentView).offset(-[Theme paddingWithSize32]);
        make.top.equalTo(funsTotalLabel.mas_bottom).offset([Theme paddingWithSize32]);
        make.height.equalTo(@([Theme paddingWithSize:68]));
    }];
    
    UILabel *moneyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    moneyLabel.font = [Theme fontWithSize30];
    moneyLabel.textColor = UIColorFromRGB(0xc5cae9);
    moneyLabel.text = @"加粉数量";
    [bgView addSubview:moneyLabel];
    
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(bgView);
        make.right.equalTo(bgView.mas_centerX).offset(-[Theme paddingWithSize40]);
    }];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    timeLabel.font = [Theme fontWithSize30];
    timeLabel.textColor = UIColorFromRGB(0xc5cae9);
    timeLabel.text = @"时间84000.90";
    [bgView addSubview:timeLabel];
    
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(bgView);
        make.left.equalTo(bgView.mas_centerX).offset([Theme paddingWithSize40]);
    }];
    
    
    LineChartView *lineChart = [[LineChartView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, [Theme paddingWithSize:270])];
    lineChart.contentInsets = UIEdgeInsetsMake([Theme paddingWithSize40], [Theme paddingWithSize100], [Theme paddingWithSize40], [Theme paddingWithSize100]);
    lineChart.xLineDataArr = @[@"0:00",@"4:00",@"8:00",@"12:00",@"16:00",@"20:00",@"24:00"];
    lineChart.yLineDataArr = @[@"2500",@"5000",@"7500",@"10000"];
    lineChart.valueArr = @[@[@"100",@"2500",@"200",@2000,@10000,@300,@5000]
                           ];
    lineChart.showYLine = NO;
    lineChart.showYLevelLine = YES;
    lineChart.valueLineColorArr =@[ [UIColor greenColor], [UIColor orangeColor]];
    [lineChart showAnimation];
    [self.contentView addSubview:lineChart];
    [lineChart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf);
        make.top.equalTo(bgView.mas_bottom).offset([Theme paddingWithSize32]);
        make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-[Theme paddingWithSize:65]);
        make.height.equalTo(@([Theme paddingWithSize:270]));
        
    }];
    
}


#pragma mark 明星产品top5
- (void)createOrderDistributionMapView:(id)dataSource {
    WS(weakSelf);
    UIView *circleView = [[UIView alloc] initWithFrame:CGRectZero];
    circleView.backgroundColor = UIColorFromRGB(0x7c87cd);
    circleView.layer.cornerRadius = [Theme paddingWithSize12] / 2;
    circleView.layer.masksToBounds = YES;
    [self.contentView addSubview:circleView];
    
    [circleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@([Theme paddingWithSize12]));
        make.width.equalTo(@([Theme paddingWithSize12]));
        make.left.equalTo(weakSelf.contentView).offset([Theme paddingWithSize32]);
        make.top.equalTo(weakSelf.contentView).offset([Theme paddingWithSize40]);
    }];
    
    UILabel *titleNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleNameLabel.font = [Theme fontWithSize30];
    titleNameLabel.textColor = UIColorFromRGB(0xc5cae9);
    titleNameLabel.text = @"客单价分布图";
    [self.contentView addSubview:titleNameLabel];
    
    [titleNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(circleView).offset([Theme paddingWithSize32]);
        make.centerY.equalTo(circleView);
    }];
}

#pragma mark 明星产品top5
- (void)createProductTop5:(id)dataSource {
    WS(weakSelf);

    
    UIView *circleView = [[UIView alloc] initWithFrame:CGRectZero];
    circleView.backgroundColor = UIColorFromRGB(0x7c87cd);
    circleView.layer.cornerRadius = [Theme paddingWithSize12] / 2;
    circleView.layer.masksToBounds = YES;
    [self.contentView addSubview:circleView];
    
    [circleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@([Theme paddingWithSize12]));
        make.width.equalTo(@([Theme paddingWithSize12]));
        make.left.equalTo(weakSelf.contentView).offset([Theme paddingWithSize32]);
        make.top.equalTo(weakSelf.contentView).offset([Theme paddingWithSize40]);
    }];
    
    UILabel *titleNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleNameLabel.font = [Theme fontWithSize30];
    titleNameLabel.textColor = UIColorFromRGB(0xc5cae9);
    titleNameLabel.text = @"明星产品TOP5";
    [self.contentView addSubview:titleNameLabel];
    
    [titleNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(circleView).offset([Theme paddingWithSize32]);
        make.centerY.equalTo(circleView);
    }];
    

    NSArray *array = [NSArray arrayWithObjects:@"按销量",@"按销售额", nil];

    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:array];
    segment.backgroundColor = UIColorFromRGB(0x303A65);
    segment.apportionsSegmentWidthsByContent = YES;
    segment.layer.masksToBounds = YES;
    segment.layer.borderWidth = CGFLOAT_MIN;
    segment.layer.cornerRadius = 5;
    segment.tintColor = UIColorFromRGB(0x41518f);
    segment.selectedSegmentIndex = 0;
    [segment setTitleTextAttributes:@{NSForegroundColorAttributeName : UIColorFromRGB(0xffffff)} forState:UIControlStateSelected];
    [segment setTitleTextAttributes:@{NSForegroundColorAttributeName : UIColorFromRGB(0x7b86cc)} forState:UIControlStateNormal];
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
    columnChart.valueArr = @[@"20",@"30",@"10",@"70",@"40"];
    columnChart.columnColorArr =  @[UIColorFromRGB(0x00d452),UIColorFromRGB(0x2d8cf8),UIColorFromRGB(0x26cef0),UIColorFromRGB(0x9c50d1),UIColorFromRGB(0xffc72c)];

    [columnChart showAnimation];
    [self.contentView addSubview:columnChart];
    [columnChart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.contentView);
        make.top.equalTo(titleNameLabel.mas_bottom).offset([Theme paddingWithSize32]);
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
        titleLabel.font = [Theme fontWithSize20];
        titleLabel.textColor = UIColorFromRGB(0xc5cae9);
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


#pragma mark 收款方式占比
- (void)createPayTypeProportion:(id)dataSource withCellType:(OverviewCellType)cellType {
    WS(weakSelf);
    UIView *circleView = [[UIView alloc] initWithFrame:CGRectZero];
    circleView.backgroundColor = UIColorFromRGB(0x7c87cd);
    circleView.layer.cornerRadius = [Theme paddingWithSize12] / 2;
    circleView.layer.masksToBounds = YES;
    [self.contentView addSubview:circleView];
    
    [circleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@([Theme paddingWithSize12]));
        make.width.equalTo(@([Theme paddingWithSize12]));
        make.left.equalTo(weakSelf.contentView).offset([Theme paddingWithSize32]);
        make.top.equalTo(weakSelf.contentView).offset([Theme paddingWithSize40]);
    }];
    
    UILabel *titleNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleNameLabel.font = [Theme fontWithSize30];
    titleNameLabel.textColor = UIColorFromRGB(0xc5cae9);
    titleNameLabel.text = cellType == OverviewCellTypePayTypeProportion ? @"收款方式占比" : @"外卖平台占比";
    [self.contentView addSubview:titleNameLabel];
    
    [titleNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(circleView).offset([Theme paddingWithSize32]);
        make.centerY.equalTo(circleView);
    }];

    RingChartView *ringView = [[RingChartView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, [Theme paddingWithSize:326])];

    ringView.redius = [Theme paddingWithSize:115];

    ringView.valueDataArr = cellType == OverviewCellTypePayTypeProportion ?  @[@"50",@"20",@"10",@"20",@"50"] : @[@"30", @"40",@"20"];
    /*         Width of ring graph        */
    ringView.ringWidth = [Theme paddingWithSize100];
    /*        Fill color for each section of the ring diagram         */
    ringView.fillColorArray = @[UIColorFromRGB(0x00d452),UIColorFromRGB(0x2d8cf8),UIColorFromRGB(0x26cef0),UIColorFromRGB(0x9c50d1),UIColorFromRGB(0xffc72c)];
    /*        Start animation             */
    [ringView showAnimation];
    [self.contentView addSubview:ringView];
    
    [ringView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.contentView);
        make.top.equalTo(titleNameLabel.mas_bottom).offset([Theme paddingWithSize28]);
        make.height.equalTo(@([Theme paddingWithSize:326]));
        
    }];

    UIView *tempView = nil;
    NSArray *titleArray = cellType == OverviewCellTypePayTypeProportion ?  @[@"微信支付",@"支付宝支付",@"现金支付",@"会员卡余额支付",@"刷卡支付",] :  @[@"美团",@"饿了么",@"百度外卖"];
    for (NSInteger i = 0; i < titleArray.count; i++) {
        
        if (tempView) {
            UIView *circleView = [[UIView alloc] initWithFrame:CGRectZero];
            circleView.backgroundColor = ringView.fillColorArray[i];
            circleView.layer.cornerRadius = [Theme paddingWithSize20] / 2;
            circleView.layer.masksToBounds = YES;
            [self.contentView addSubview:circleView];
            
            [circleView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@([Theme paddingWithSize20]));
                make.width.equalTo(@([Theme paddingWithSize20]));
                make.left.equalTo(weakSelf.contentView).offset([Theme paddingWithSize100]);
                make.top.equalTo(tempView.mas_bottom).offset([Theme paddingWithSize28]);
            }];
            tempView = circleView;
        } else {
        
            UIView *circleView = [[UIView alloc] initWithFrame:CGRectZero];
            circleView.backgroundColor = ringView.fillColorArray[i];
            circleView.layer.cornerRadius = [Theme paddingWithSize20] / 2;
            circleView.layer.masksToBounds = YES;
            [self.contentView addSubview:circleView];
            
            [circleView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@([Theme paddingWithSize20]));
                make.width.equalTo(@([Theme paddingWithSize20]));
                make.left.equalTo(weakSelf.contentView).offset([Theme paddingWithSize100]);
                make.top.equalTo(ringView.mas_bottom).offset([Theme paddingWithSize40]);
            }];
            tempView = circleView;
        
        }
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        titleLabel.font = [Theme fontWithSize20];
        titleLabel.textColor = UIColorFromRGB(0xc5cae9);
        titleLabel.text = titleArray[i];
        [self.contentView addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(tempView.mas_right).offset([Theme paddingWithSize20]);
            make.centerY.equalTo(tempView);
        }];

        
        UILabel *titleValueLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        titleValueLabel.font = [Theme fontWithSize20];
        titleValueLabel.textColor = UIColorFromRGB(0xc5cae9);
        titleValueLabel.text = @"收款金额:100000元，占比100%";
        titleValueLabel.numberOfLines = 0;
        [self.contentView addSubview:titleValueLabel];
        
        [titleValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(weakSelf.contentView.mas_centerX);
            make.right.equalTo(weakSelf.contentView).offset(-[Theme paddingWithSize32]);
            make.centerY.equalTo(tempView);
        }];
        
    
        
        if (i == titleArray.count - 1) {
            [tempView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-[Theme paddingWithSize:50]);
            }];
        }
        
        
    }
    
    

}

#pragma  mark 门店订单金额统计
- (void)createOrderMoneyStatisticView:(id)dataSource {
    WS(weakSelf);
    UIView *circleView = [[UIView alloc] initWithFrame:CGRectZero];
    circleView.backgroundColor = UIColorFromRGB(0x7c87cd);
    circleView.layer.cornerRadius = [Theme paddingWithSize12] / 2;
    circleView.layer.masksToBounds = YES;
    [self.contentView addSubview:circleView];
    
    [circleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@([Theme paddingWithSize12]));
        make.width.equalTo(@([Theme paddingWithSize12]));
        make.left.equalTo(weakSelf.contentView).offset([Theme paddingWithSize32]);
        make.top.equalTo(weakSelf.contentView).offset([Theme paddingWithSize40]);
    }];
    
    UILabel *titleNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleNameLabel.font = [Theme fontWithSize30];
    titleNameLabel.textColor = UIColorFromRGB(0xc5cae9);
    titleNameLabel.text = @"门店订单金额统计";
    [self.contentView addSubview:titleNameLabel];
    
    [titleNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(circleView).offset([Theme paddingWithSize32]);
        make.centerY.equalTo(circleView);
    }];

    UIView *bgView = [[UIView alloc] initWithFrame:CGRectZero];
    bgView.backgroundColor = UIColorFromRGB(0x222b59);

    [self.contentView addSubview:bgView];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).offset([Theme paddingWithSize32]);
        make.right.equalTo(weakSelf.contentView).offset(-[Theme paddingWithSize32]);
        make.top.equalTo(titleNameLabel.mas_bottom).offset([Theme paddingWithSize32]);
        make.height.equalTo(@([Theme paddingWithSize:68]));
    }];
    
    UILabel *moneyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    moneyLabel.font = [Theme fontWithSize30];
    moneyLabel.textColor = UIColorFromRGB(0xc5cae9);
    moneyLabel.text = @"金额84000.90";
    [bgView addSubview:moneyLabel];
    
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(bgView);
        make.right.equalTo(bgView.mas_centerX).offset(-[Theme paddingWithSize40]);
    }];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    timeLabel.font = [Theme fontWithSize30];
    timeLabel.textColor = UIColorFromRGB(0xc5cae9);
    timeLabel.text = @"时间84000.90";
    [bgView addSubview:timeLabel];
    
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(bgView);
        make.left.equalTo(bgView.mas_centerX).offset([Theme paddingWithSize40]);
    }];
    
    
    LineChartView *lineChart = [[LineChartView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, [Theme paddingWithSize:270])];
    lineChart.contentInsets = UIEdgeInsetsMake([Theme paddingWithSize40], [Theme paddingWithSize100], [Theme paddingWithSize40], [Theme paddingWithSize100]);
    lineChart.xLineDataArr = @[@"0:00",@"4:00",@"8:00",@"12:00",@"16:00",@"20:00",@"24:00"];
    lineChart.yLineDataArr = @[@"2500",@"5000",@"7500",@"10000"];
    lineChart.valueArr = @[@[@"100",@"2500",@"200",@2000,@10000,@300,@5000]];
    lineChart.showYLine = NO;
    lineChart.showYLevelLine = YES;
    lineChart.valueLineColorArr =@[ [UIColor greenColor], [UIColor orangeColor]];
    [lineChart showAnimation];
    [self.contentView addSubview:lineChart];
    [lineChart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf);
        make.top.equalTo(bgView.mas_bottom).offset([Theme paddingWithSize32]);
        make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-[Theme paddingWithSize:65]);
        make.height.equalTo(@([Theme paddingWithSize:270]));
        
    }];
    
}

#pragma mark 门店数据
- (void)createStoreDataView:(id)dataSource withCellType:(OverviewCellType)cellType {
    
    NSArray *dataArray = dataSource;
    
    WS(weakSelf);
    UILabel * seperatorLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    seperatorLabel.backgroundColor = UIColorFromRGB(0x313d80);
    [self.contentView addSubview:seperatorLabel];

    [seperatorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView).offset([Theme paddingWithSize40]);
        make.bottom.equalTo(weakSelf.contentView).offset(-[Theme paddingWithSize40]);
        make.height.equalTo(@([Theme paddingWithSize:135]));
        make.centerX.equalTo(weakSelf.contentView);
        make.width.equalTo(@(0.5));
    }];
    
    UILabel *orderQuantityLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    orderQuantityLabel.font = [Theme fontWithSize30];
    orderQuantityLabel.textColor = UIColorFromRGB(0xc5cae9);

    [self.contentView addSubview:orderQuantityLabel];
    
    [orderQuantityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(weakSelf.contentView).offset([Theme paddingWithSize:50]);
        make.centerX.equalTo(weakSelf.contentView).dividedBy(2);
    }];
    
    UILabel *orderMoneryLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    orderMoneryLabel.font = [Theme fontWithSize30];
    orderMoneryLabel.textColor = UIColorFromRGB(0xc5cae9);

    [self.contentView addSubview:orderMoneryLabel];
    
    [orderMoneryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.contentView).offset([Theme paddingWithSize:50]);
        make.centerX.equalTo(weakSelf.contentView).multipliedBy(1.5);
    }];
    
    UILabel *orderQuantityValueLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    orderQuantityValueLabel.font = [UIFont systemFontOfSize:30];
    orderQuantityValueLabel.textColor = UIColorFromRGB(0xf9d542);
    
    [self.contentView addSubview:orderQuantityValueLabel];
    
    [orderQuantityValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(orderQuantityLabel.mas_bottom).offset([Theme paddingWithSize20]);
        make.centerX.equalTo(orderQuantityLabel.mas_centerX);
    }];
    
    UILabel *orderMoneryValueLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    orderMoneryValueLabel.font = [UIFont systemFontOfSize:30];
    orderMoneryValueLabel.textColor = UIColorFromRGB(0xf9d542);

    [self.contentView addSubview:orderMoneryValueLabel];
    
    [orderMoneryValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(orderMoneryLabel.mas_bottom).offset([Theme paddingWithSize20]);
        make.centerX.equalTo(orderMoneryLabel.mas_centerX);
    }];
    
    NSString *quantityValueStr = [NSString stringWithFormat:@"%@", dataArray.firstObject] ;
    NSString *moneryValueStr = [NSString stringWithFormat:@"%@", dataArray.lastObject];
    
    if (cellType == OverviewCellTypeStoreDate) {
        orderQuantityLabel.text = @"订单数";
        orderMoneryLabel.text = @"订单总额";
        orderQuantityValueLabel.text = quantityValueStr;
        orderMoneryValueLabel.text = moneryValueStr;

    } else  if (cellType == OverviewCellTypeVipDate) {
        orderQuantityLabel.text = @"会员充值金额";
        orderMoneryLabel.text = @"新增会员";
        orderQuantityValueLabel.text = quantityValueStr;
        orderMoneryValueLabel.text = moneryValueStr;
    } else  if (cellType == OverviewCellTypeTakeOutDate) {
        orderQuantityLabel.text = @"订单数";
        orderMoneryLabel.text = @"订单总额";
        orderQuantityValueLabel.text = quantityValueStr;
        orderMoneryValueLabel.text = moneryValueStr;
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
