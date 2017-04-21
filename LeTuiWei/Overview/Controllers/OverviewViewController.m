//
//  OverviewViewController.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/3/28.
//  Copyright © 2017年 陈营超. All rights reserved.
//
//
//DistributionChartView *lineChart = [[DistributionChartView alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth, 200)];
//
//[lineChart showAnimation];
//[self.view addSubview:lineChart];

#import "OverviewViewController.h"
#import "NavigitionHeaderView.h"
#import "CalendarView.h"
#import "OverviewCell.h"
#import "NewCustomPickerView.h"
#import "CoustomPopUpView.h"
#import "AddStoreMaskView.h"
#import "AddStoresViewController.h"

typedef NS_ENUM(NSUInteger,ATCalendarSelectStep) {
    ATCalendarSelectStepOne,
    ATCalendarSelectStepTwo,
};

@interface OverviewViewController () <UITableViewDataSource, UITableViewDelegate,UITextViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NavigitionHeaderView *headerView;

@property (nonatomic, strong) CalendarView *calendarView;

@property (nonatomic, copy) NSString *checkInDateStr;

@property (nonatomic, copy) NSString *checkOutDateStr;

@property (nonatomic, assign) NaviHeaderViewButtonType headerButtonType;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) NewCustomPickerView *pickerView;

@property (nonatomic, assign) BOOL haveStoreInfo;

@end

@implementation OverviewViewController

- (void)loadView {
    [super loadView];
    [self createNavigitionHeaderView];
    [self creatTableView];
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.headerButtonType = NaviHeaderViewButtonToday;
    [self loadDataSource];
   
    self.haveStoreInfo = YES;
    WS(weakSelf);

    if (!self.haveStoreInfo) {
        AddStoreMaskView *addStoreMaskView = [[AddStoreMaskView alloc] initWithFrame:CGRectMake([Theme paddingWithSize:90], [Theme paddingWithSize:220], kScreenWidth - 2 * [Theme paddingWithSize:90], [Theme paddingWithSize:700])];
        addStoreMaskView.addStoreButtonBlock = ^(UIButton *button) {
            
            AddStoresViewController *addStoreVC = [[AddStoresViewController alloc] init];
            [weakSelf.navigationController pushViewController:addStoreVC animated:YES];
            
        };
        
        [addStoreMaskView showView];
    }
    
}

- (void)loadDataSource {
    
    switch (self.headerButtonType) {
        case NaviHeaderViewButtonCalendar: {
            self.dataArray = @[@"1", @"100"];
        
        }
            
            break;
            
        case NaviHeaderViewButtonToday: {
            self.dataArray = @[@"2", @"200"];
        }
            
            break;
        case NaviHeaderViewButtontYesterday: {
            self.dataArray = @[@"3", @"300"];
        }
            
            break;
        case NaviHeaderViewButtontSevenDay: {
            self.dataArray = @[@"4", @"400"];
        }
            
            break;
    }

    [self.tableView reloadData];
}


#pragma mark -- tableView delegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 9;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
  }

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WS(weakSelf);
    OverviewCell *cell = nil;
    
    switch (indexPath.section) {
        case OverviewCellTypeStoreDate: {
            cell = [[OverviewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"StoreDate" withDataSource:self.dataArray withCellType:OverviewCellTypeStoreDate];
        }
            
            break;
            
        case OverviewCellTypeOrderMoneyStatistics: {
            cell = [[OverviewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OrderMoneyStatistics" withDataSource:self.dataArray withCellType:OverviewCellTypeOrderMoneyStatistics];
        }
            
            break;
            
        case OverviewCellTypePayTypeProportion: {
            cell = [[OverviewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PayTypeProportion" withDataSource:self.dataArray withCellType:OverviewCellTypePayTypeProportion];
        }
            
            break;
            
        case OverviewCellTypeProductTop5: {
            cell = [[OverviewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ProductTop5" withDataSource:self.dataArray withCellType:OverviewCellTypeProductTop5];
            
            cell.segmentIndexBlock = ^(NSInteger index) {
                //按销量
                if (index == 0) {
                    NSLog(@"按销量");
                } else { //按销售额
                    NSLog(@"按销售额");
                
                }
                
                
            };
            //开通智慧门店
            cell.openWisdomStoreBlock = ^() {
                AddStoreMaskView *addStoreMaskView = [[AddStoreMaskView alloc] initWithFrame:CGRectMake([Theme paddingWithSize:90], [Theme paddingWithSize:220], kScreenWidth - 2 * [Theme paddingWithSize:90], [Theme paddingWithSize:700])];
                
                [addStoreMaskView showView];
                addStoreMaskView.addStoreButtonBlock = ^(UIButton *button) {
                 
                    AddStoresViewController *addStoreVC = [[AddStoresViewController alloc] init];
                    [weakSelf.navigationController pushViewController:addStoreVC animated:YES];
                    
                };

            };
        }
            
            break;
        case OverviewCellTypeOrderDistributionMap: {
            cell = [[OverviewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OrderDistributionMap" withDataSource:self.dataArray withCellType:OverviewCellTypeOrderDistributionMap];
        }
            
            break;
            
        case OverviewCellTypeVipDate: {
            cell = [[OverviewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"VipDate" withDataSource:self.dataArray withCellType:OverviewCellTypeVipDate];
        }
            
            break;
            
        case OverviewCellTypeWeixinPayFuns: {
            cell = [[OverviewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WeixinPayFuns" withDataSource:self.dataArray withCellType:OverviewCellTypeWeixinPayFuns];
        }
            
            break;
            
        case OverviewCellTypeTakeOutDate: {
            cell = [[OverviewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TakeOutDate" withDataSource:self.dataArray withCellType:OverviewCellTypeTakeOutDate];
        }
            
            break;
            
        case OverviewCellTypeTakeOutProportion: {
            cell = [[OverviewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TakeOutProportion" withDataSource:self.dataArray withCellType:OverviewCellTypeTakeOutProportion];
        }
            
            break;
            
        
            
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.bottomSeparatorStyle = ATCommonCellSeparatorStyleNone;
    cell.backgroundColor = UIColorFromRGB(0x1b224c);
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    if (section == OverviewCellTypeStoreDate ||section == OverviewCellTypeVipDate ||section == OverviewCellTypeWeixinPayFuns ||section == OverviewCellTypeTakeOutDate) {
        return [Theme paddingWithSize:90];
    }
    return CGFLOAT_MIN;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    if (section == OverviewCellTypeOrderDistributionMap ||section == OverviewCellTypeVipDate) {
        return CGFLOAT_MIN;
    }
    
    return [Theme paddingWithSize20];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    WS(weakSelf);
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, [Theme paddingWithSize:90])];
    bgView.userInteractionEnabled = YES;
    switch (section) {
        case OverviewCellTypeStoreDate: {
            
            UILabel *titleNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
            titleNameLabel.font = [Theme fontWithSize30];
            titleNameLabel.textColor = UIColorFromRGB(0xc5cae9);
            titleNameLabel.text = @"门店数据";
            [bgView addSubview:titleNameLabel];
            
            [titleNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(bgView).offset([Theme paddingWithSize32]);
                make.centerY.equalTo(bgView);
            }];
            
            UIButton *calendarButton = [[UIButton alloc] initWithFrame:CGRectZero];
            calendarButton.titleLabel.font = [Theme fontWithSize30];
            
            NSString *title = @"全部门店";
            [calendarButton setTitle:title forState:UIControlStateNormal];
            [calendarButton setTitleColor:UIColorFromRGB(0xc5cae9) forState:UIControlStateNormal];
            [calendarButton setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
            [calendarButton setImage:[UIImage imageNamed:@"up"] forState:UIControlStateSelected];
            [bgView addSubview: calendarButton];
            [calendarButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(bgView).offset(-[Theme paddingWithSize32]);
                make.centerY.equalTo(bgView);
            }];
            
            CGSize size = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) textFont: [Theme fontWithSize28] aimString:title];
            calendarButton.imageEdgeInsets = UIEdgeInsetsMake(0,size.width + 3, 0, -(size.width + 3));
            calendarButton.titleEdgeInsets = UIEdgeInsetsMake(0, -([UIImage imageNamed:@"down"].size.width + 3), 0, [UIImage imageNamed:@"down"].size.width + 3);
            
            [calendarButton bk_whenTapped:^{
                calendarButton.selected = !calendarButton.selected;
                if (calendarButton) {
                    weakSelf.pickerView.dataSource = @[@"全部门店",@"麦当劳东单店",@"麦当劳大望路点",@"麦当劳西单店",@"老王面馆"];
                    [self.pickerView show];
                } else {
            
                    [self.pickerView dismiss];
                }
                weakSelf.pickerView.determineBtnBlock = ^(NSString *selectTitle) {
                
                    NSLog(@"%@",selectTitle);
                };
                
                weakSelf.pickerView.statusBlock = ^(BOOL willOpen) {
                    calendarButton.selected = willOpen;
                
                };

            }];


        }
            
            break;
            
        case OverviewCellTypeVipDate: {
            
            
            UILabel *titleNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
            titleNameLabel.font = [Theme fontWithSize30];
            titleNameLabel.textColor = UIColorFromRGB(0xc5cae9);
            titleNameLabel.text = @"会员数据";
            [bgView addSubview:titleNameLabel];
            
            [titleNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(bgView).offset([Theme paddingWithSize32]);
                make.centerY.equalTo(bgView);
            }];
            if (!_haveStoreInfo) {
                NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"(未开通“智慧门店”,会员功能不可用,立即开通)"];
                [attributedString addAttribute:NSLinkAttributeName
                                         value:@"openStore://"
                                         range:[[attributedString string] rangeOfString:@"立即开通"]];
                
                [attributedString addAttribute:NSFontAttributeName
                                         value:[Theme fontWithSize24]
                                         range:NSMakeRange(0, attributedString.length)];
                
                [attributedString addAttribute:NSForegroundColorAttributeName
                                         value:UIColorFromRGB(0x7b86cc)
                                         range:NSMakeRange(0, attributedString.length)];
                
                
                UITextView *textView = [[UITextView alloc] initWithFrame:CGRectZero];
                textView.backgroundColor =  UIColorFromRGB(0x14193f);
                textView.delegate = self;
                textView.editable = NO;
                textView.scrollEnabled = NO;
                textView.font = [Theme fontWithSize30];
                textView.textColor = UIColorFromRGB(0xc5cae9);
                textView.linkTextAttributes = @{NSForegroundColorAttributeName:
                                                    UIColorFromRGB(0x338cf2),
                                                NSUnderlineColorAttributeName:  UIColorFromRGB(0x338cf2),
                                                NSUnderlineStyleAttributeName: @(NSUnderlinePatternSolid)};
                
                [bgView addSubview:textView];
                
                
                textView.attributedText = attributedString;
                [textView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(titleNameLabel.mas_right).offset([Theme paddingWithSize:5]);
                    make.centerY.equalTo(titleNameLabel);
                }];

            }
 
        }
            
            break;
            
        case OverviewCellTypeWeixinPayFuns: {
            
            
            UILabel *titleNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
            titleNameLabel.font = [Theme fontWithSize30];
            titleNameLabel.textColor = UIColorFromRGB(0xc5cae9);
            titleNameLabel.text = @"微信支付加粉数";
            [bgView addSubview:titleNameLabel];
            
            [titleNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(bgView).offset([Theme paddingWithSize32]);
                make.centerY.equalTo(bgView);
            }];
            
            UIImageView *promptImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
            promptImageView.userInteractionEnabled = YES;
            promptImageView.image = [UIImage imageNamed:@"note"];
            [bgView addSubview:promptImageView];
            [promptImageView mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.left.equalTo(titleNameLabel.mas_right).offset([Theme paddingWithSize10]);
                make.centerY.equalTo(titleNameLabel);
                
            }];
            
            
            [promptImageView bk_whenTapped:^{
                CoustomPopUpView *view = [[CoustomPopUpView alloc] initWithFrame:CGRectMake([Theme paddingWithSize100], 200, [UIScreen mainScreen].bounds.size.width - [Theme paddingWithSize100] * 2,[Theme paddingWithSize:450])];
                
                NSString *str = @"是指顾客使用微信支付后关注公众号的数量。(如何让您的公众号出现在付款完成界面？您需要完成以下操作：在PC端登录乐推微官网，找到“门店派”-“公众号授权”，授权绑定您的公众号)";
                
                NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
                
                [attrStr setAttributes:@{ NSForegroundColorAttributeName : [UIColor redColor]} range:NSMakeRange(21, 28)];
                view.attributeContent = attrStr;
                
                
                [view PopUpViewComponent:PopUpViewTypeWithComment withTitle:nil withContent:str andButtonType:PopUpViewComponentCentreButton];

            }];
            
            
            
        }
            
            break;
            
        case OverviewCellTypeTakeOutDate: {
            
            
            UILabel *titleNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
            titleNameLabel.font = [Theme fontWithSize30];
            titleNameLabel.textColor = UIColorFromRGB(0xc5cae9);
            titleNameLabel.text = @"外卖数据";
            [bgView addSubview:titleNameLabel];
            
            [titleNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(bgView).offset([Theme paddingWithSize32]);
                make.centerY.equalTo(bgView);
            }];
            
        }
            
            break;
            
        default:
            break;
    }

    return bgView;
}


- (void)creatTableView {
    WS(weakSelf);
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.backgroundColor = UIColorFromRGB(0x14193f);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.estimatedRowHeight = 200;
 
    [self.view addSubview:_tableView];
    [self.view sendSubviewToBack:_tableView];
    [_tableView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view).offset([Theme paddingWithSize:200]);
    }];
}

-(void)createNavigitionHeaderView {
    
    self.headerView = [[NavigitionHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, [Theme paddingWithSize:200]) withTitles:@[@"今天",@"昨天",@"近7天"] withViewType:NaviHeaderViewOverView];
    self.headerView.backgroundColor = [Theme colorOverViewBg];
    self.checkInDateStr =  [[NSDate date] stringForYearMonthDayDashed];

    self.checkOutDateStr =  [[NSDate date] stringForYearMonthDayDashed];

    self.headerView.calendarTitle = [NSString stringWithFormat:@"%@至%@",self.checkInDateStr,self.checkOutDateStr];
    
    [self.headerView upDateView];
  
     [[UIApplication sharedApplication].keyWindow addSubview:self.headerView];
  
    WS(weakSelf);
    self.headerView.selectAtIndexBlock = ^(NaviHeaderViewButtonType indexType, BOOL isSelected) {
        
        weakSelf.headerButtonType = indexType;
        switch (indexType) {
            case NaviHeaderViewButtonCalendar: {
                if (isSelected) {
                    //创建日历
                    weakSelf.calendarView = [[CalendarView alloc] initWithFrame:CGRectMake(0,[Theme paddingWithSize:200], kScreenWidth, kScreenHeight - [Theme paddingWithSize:200])];
                    weakSelf.calendarView.origin = CGPointMake(0, [Theme paddingWithSize:200]);
                    weakSelf.calendarView.confirmDateButton = ^(NSString *checkInDate, NSString *checkOutDate) {
                        
                        weakSelf.headerView.calendarButton.selected = NO;
                        //更改button内容
                        weakSelf.checkInDateStr = checkInDate;
                        weakSelf.checkOutDateStr = checkOutDate;
                        weakSelf.headerView.calendarTitle = [NSString stringWithFormat:@"%@至%@",weakSelf.checkInDateStr,weakSelf.checkOutDateStr];
                        [weakSelf.headerView upDateView];
                        [weakSelf loadDataSource];
                        
                    };
                    
                    [[UIApplication sharedApplication].keyWindow insertSubview:weakSelf.calendarView belowSubview:weakSelf.headerView];
                    
           
                    weakSelf.calendarView.checkInDate = [NSDate at_dateFromString:weakSelf.checkInDateStr];
                    weakSelf.calendarView.checkOutDate  = [NSDate at_dateFromString:weakSelf.checkOutDateStr];
   
                    [weakSelf.calendarView showCalendarView];
                    
                } else {
                    
                    [weakSelf.calendarView dismissCalendarView];
         
                }
            }
                break;

            case NaviHeaderViewButtonToday: {
                weakSelf.checkInDateStr =  [[NSDate date] stringForYearMonthDayDashed];
                weakSelf.checkOutDateStr =  [[NSDate date] stringForYearMonthDayDashed];
                weakSelf.headerView.calendarTitle = [NSString stringWithFormat:@"%@至%@",weakSelf.checkInDateStr,weakSelf.checkOutDateStr];
                
                [weakSelf.headerView upDateView];
                
                weakSelf.headerView.calendarButton.selected = NO;
                [weakSelf.calendarView dismissCalendarView];
                [weakSelf loadDataSource];
           
            }
                
                break;
                
            case NaviHeaderViewButtontYesterday: {
                
                NSDate *lastDay = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:[NSDate date] ];//前一天
                weakSelf.checkInDateStr =  [lastDay stringForYearMonthDayDashed];
                weakSelf.checkOutDateStr = [lastDay stringForYearMonthDayDashed];
                weakSelf.headerView.calendarTitle = [NSString stringWithFormat:@"%@至%@",weakSelf.checkInDateStr,weakSelf.checkOutDateStr];
                
                [weakSelf.headerView upDateView];
                weakSelf.headerView.calendarButton.selected = NO;
               [weakSelf.calendarView dismissCalendarView];
                [weakSelf loadDataSource];
        
                
            }
                
                break;
                
            case NaviHeaderViewButtontSevenDay: {
                
                NSDate *lastSevenDay = [NSDate dateWithTimeInterval:-24*60*60*7 sinceDate:[NSDate date] ];//前7天
                NSDate *lastDay = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:[NSDate date] ];//前一天
                
                weakSelf.checkInDateStr =  [lastSevenDay stringForYearMonthDayDashed];
                weakSelf.checkOutDateStr = [lastDay stringForYearMonthDayDashed];
                weakSelf.headerView.calendarTitle = [NSString stringWithFormat:@"%@至%@",weakSelf.checkInDateStr,weakSelf.checkOutDateStr];
                [weakSelf.headerView upDateView];
                
                
                weakSelf.headerView.calendarButton.selected = NO;
                [weakSelf.calendarView dismissCalendarView];
                [weakSelf loadDataSource];
            
                
            }
                
                break;
            
        }
        
    };

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.headerView.hidden = NO;

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.headerView.hidden = YES;

}


#pragma mark 返回字符串尺寸
- (CGSize)sizeOfStringWithMaxSize:(CGSize)maxSize textFont:(UIFont *)fontSize aimString:(NSString *)aimString{
    
    
    return [[NSString stringWithFormat:@"%@",aimString] boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:fontSize} context:nil].size;
    
}


- (NewCustomPickerView *)pickerView {
    
    if (!_pickerView) {
        _pickerView = [[NewCustomPickerView alloc]  init];
        
    }
    
    return _pickerView;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    if ([[URL scheme] isEqualToString:@"openStore"]) {
        WS(weakSelf);
        AddStoreMaskView *addStoreMaskView = [[AddStoreMaskView alloc] initWithFrame:CGRectMake([Theme paddingWithSize:90], [Theme paddingWithSize:220], kScreenWidth - 2 * [Theme paddingWithSize:90], [Theme paddingWithSize:700])];
        
        [addStoreMaskView showView];
        addStoreMaskView.addStoreButtonBlock = ^(UIButton *button) {
            
            AddStoresViewController *addStoreVC = [[AddStoresViewController alloc] init];
            [weakSelf.navigationController pushViewController:addStoreVC animated:YES];
            
        };
        return NO;
    }
    
    return YES;
}


@end
