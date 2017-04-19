//
//  FSCalendarStaticHeader.m
//  FSCalendar
//
//  Created by dingwenchao on 9/17/15.
//  Copyright (c) 2015 wenchaoios. All rights reserved.
//

#import "FSCalendarStickyHeader.h"
#import "FSCalendar.h"
#import "UIView+FSExtension.h"
#import "FSCalendarConstance.h"
#import "FSCalendarDynamicHeader.h"

@interface FSCalendarStickyHeader ()

@property (assign, nonatomic) BOOL needsAdjustingViewFrame;

@end

@implementation FSCalendarStickyHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _needsAdjustingViewFrame = YES;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [OIAppTheme fontWithSize28];
        label.textColor = [OIAppTheme colorForTextTitle];
        [self addSubview:label];
        self.titleLabel = label;

        /*
        NSMutableArray *weekdayLabels = [NSMutableArray arrayWithCapacity:7];
        for (int i = 0; i < 7; i++) {
            label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.textAlignment = NSTextAlignmentCenter;
            label.backgroundColor =  UIColorFromRGB(0xeeeeee);
            [_contentView addSubview:label];
            [weekdayLabels addObject:label];
        }
        self.weekdayLabels = weekdayLabels.copy;
         */
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (_needsAdjustingViewFrame) {
        if (!CGSizeEqualToSize(self.frame.size, CGSizeZero)) {
            _needsAdjustingViewFrame = NO;

            _titleLabel.frame = CGRectMake(0, [OIAppTheme paddingWithSize28], self.fs_width, _titleLabel.font.lineHeight);
            
            /*
            CGFloat weekdayWidth = self.fs_width / 7.0;
            CGFloat weekdayHeight = self.fs_height/2.0;
            
            [_weekdayLabels enumerateObjectsUsingBlock:^(UILabel *label, NSUInteger index, BOOL *stop) { \
                label.frame = CGRectMake(index*weekdayWidth, _titleLabel.fs_bottom, weekdayWidth, weekdayHeight);
            }];
             */
            

        }
    }
    
    [self reloadData];
}

#pragma mark - Properties

- (void)setCalendar:(FSCalendar *)calendar
{
    if (![_calendar isEqual:calendar]) {
        _calendar = calendar;
    }
    if (![_appearance isEqual:calendar.appearance]) {
        _appearance = calendar.appearance;
        [self invalidateHeaderFont];
        [self invalidateHeaderTextColor];
        [self invalidateWeekdayFont];
        [self invalidateWeekdayTextColor];
    }
}

#pragma mark - Public methods

- (void)reloadData
{
    [self invalidateWeekdaySymbols];
    _calendar.formatter.dateFormat = _appearance.headerDateFormat;
    BOOL usesUpperCase = (_appearance.caseOptions & 15) == FSCalendarCaseOptionsHeaderUsesUpperCase;
    NSString *text = [_calendar.formatter stringFromDate:_month];
    text = usesUpperCase ? text.uppercaseString : text;
    _titleLabel.text = text;
}

#pragma mark - Private methods

- (void)invalidateHeaderFont
{
    _titleLabel.font = _appearance.headerTitleFont;
}

- (void)invalidateHeaderTextColor
{
    _titleLabel.textColor = _appearance.headerTitleColor;
}

- (void)invalidateWeekdayFont
{
    [_weekdayLabels makeObjectsPerformSelector:@selector(setFont:) withObject:_appearance.weekdayFont];
}

- (void)invalidateWeekdayTextColor
{
    [_weekdayLabels makeObjectsPerformSelector:@selector(setTextColor:) withObject:_appearance.weekdayTextColor];
}

- (void)invalidateWeekdaySymbols
{

//    BOOL useVeryShortWeekdaySymbols = (_appearance.caseOptions & (15<<4) ) == FSCalendarCaseOptionsWeekdayUsesSingleUpperCase;
//    NSArray *weekdaySymbols = useVeryShortWeekdaySymbols ? _calendar.calendar.weekdaySymbols : _calendar.calendar.shortStandaloneWeekdaySymbols;
//    BOOL useDefaultWeekdayCase = (_appearance.caseOptions & (15<<4) ) == FSCalendarCaseOptionsWeekdayUsesDefaultCase;
      NSArray *weekdaySymbols = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
     [_weekdayLabels enumerateObjectsUsingBlock:^(UILabel *label, NSUInteger index, BOOL *stop) {
        index += _calendar.firstWeekday-1;
        index %= 7;
        label.text = weekdaySymbols[index];
//        label.text = useDefaultWeekdayCase ? weekdaySymbols[index] : [weekdaySymbols[index] uppercaseString];

    }];
}


@end


