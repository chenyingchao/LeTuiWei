//
//  FSCalendarCell.m
//  Pods
//
//  Created by Wenchao Ding on 12/3/15.
//
//

#import "FSCalendarCell.h"
#import "FSCalendar.h"
#import "UIView+FSExtension.h"
#import "FSCalendarDynamicHeader.h"
#import "FSCalendarConstance.h"
#import "NSDate+FSExtension.h"

#define kBackgroundLayerHeight 50 * kDeviceScaleFactor
#define kBackgroundLayerWidth  kBackgroundLayerHeight
#define kBackgroundLayerTop   (FSCalendarStandardRowHeight - 50) /2.0 * kDeviceScaleFactor

typedef NS_ENUM(NSUInteger, CellCornerType) {
    CellCornerTypeNone,
    CellCornerTypeLeft,
    CellCornerTypeRight,
};

@interface FSCalendarCell ()

@property (readonly, nonatomic) UIColor *colorForBackgroundLayer;
@property (readonly, nonatomic) UIColor *colorForTitleLabel;
@property (readonly, nonatomic) UIColor *colorForSubtitleLabel;
@property (readonly, nonatomic) UIColor *colorForCellBorder;
@property (readonly, nonatomic) FSCalendarCellShape cellShape;

@end

@implementation FSCalendarCell

#pragma mark - Life cycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _needsAdjustingViewFrame = YES;
        
        UILabel *label;
        CAShapeLayer *shapeLayer;
        UIImageView *imageView;
        
        label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [OIAppTheme fontWithSize28];
        [self.contentView addSubview:label];
        self.titleLabel = label;
        
        label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:label];
        self.subtitleLabel = label;
        
        shapeLayer = [CAShapeLayer layer];
        shapeLayer.backgroundColor = [UIColor clearColor].CGColor;
        shapeLayer.hidden = YES;
        [self.contentView.layer insertSublayer:shapeLayer below:_titleLabel.layer];
        self.selectedLayer = shapeLayer;
        
        shapeLayer = [CAShapeLayer layer];
        shapeLayer.backgroundColor = [UIColor clearColor].CGColor;
        shapeLayer.hidden = YES;
        [self.contentView.layer insertSublayer:shapeLayer below:_titleLabel.layer];
        self.backgroundLayer = shapeLayer;
        
        shapeLayer = [CAShapeLayer layer];
        shapeLayer.backgroundColor = [UIColor clearColor].CGColor;
        shapeLayer.fillColor = [UIColor cyanColor].CGColor;
        shapeLayer.path = [UIBezierPath bezierPathWithOvalInRect:shapeLayer.bounds].CGPath;
        shapeLayer.hidden = YES;
        [self.contentView.layer addSublayer:shapeLayer];
        self.eventLayer = shapeLayer;
        
        imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageView.contentMode = UIViewContentModeBottom|UIViewContentModeCenter;
        [self.contentView addSubview:imageView];
        self.imageView = imageView;
        
        self.clipsToBounds = NO;
        self.contentView.clipsToBounds = NO;
        
    }
    return self;
}

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];

    /*
    CGFloat titleHeight = self.bounds.size.height*5.0/6.0;
    CGFloat diameter = MIN(self.bounds.size.height*5.0/6.0,self.bounds.size.width);
    diameter = diameter > FSCalendarStandardCellDiameter ? (diameter - (diameter-FSCalendarStandardCellDiameter)*0.5) : diameter;
    _backgroundLayer.frame = CGRectMake((self.bounds.size.width-diameter)/2,
                                        (titleHeight-diameter)/2,
                                        diameter,
                                        diameter);

     */
    _backgroundLayer.frame = CGRectMake((self.fs_width - kBackgroundLayerHeight)/2.0, kBackgroundLayerTop, kBackgroundLayerWidth, kBackgroundLayerHeight);
    _selectedLayer.frame = CGRectMake(0, kBackgroundLayerTop, self.width, kBackgroundLayerHeight);

    _backgroundLayer.borderWidth = 1.0;
    _backgroundLayer.borderColor = [UIColor clearColor].CGColor;
    
    CGFloat eventSize = _backgroundLayer.frame.size.height/6.0;
    _eventLayer.frame = CGRectMake((_backgroundLayer.frame.size.width-eventSize)/2+_backgroundLayer.frame.origin.x, CGRectGetMaxY(_backgroundLayer.frame)+eventSize*0.17, eventSize*0.83, eventSize*0.83);
    _eventLayer.path = [UIBezierPath bezierPathWithOvalInRect:_eventLayer.bounds].CGPath;
    _imageView.frame = self.contentView.bounds;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [self configureCell];
    [CATransaction commit];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    [CATransaction setDisableActions:YES];
    _backgroundLayer.hidden = YES;
}

#pragma mark - Public

- (void)performSelecting
{
    _backgroundLayer.hidden = NO;
    
#define kAnimationDuration FSCalendarDefaultBounceAnimationDuration
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    CABasicAnimation *zoomOut = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    zoomOut.fromValue = @0.3;
    zoomOut.toValue = @1.2;
    zoomOut.duration = kAnimationDuration/4*3;
    CABasicAnimation *zoomIn = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    zoomIn.fromValue = @1.2;
    zoomIn.toValue = @1.0;
    zoomIn.beginTime = kAnimationDuration/4*3;
    zoomIn.duration = kAnimationDuration/4;
    group.duration = kAnimationDuration;
    group.animations = @[zoomOut, zoomIn];
    [_backgroundLayer addAnimation:group forKey:@"bounce"];
    [self configureCell];
}

#pragma mark - Private

- (void)configureCell
{

    if ([self isToday]) {
        _titleLabel.text = @"今天";
    }
    else {
        _titleLabel.text = [NSString stringWithFormat:@"%@",@([_calendar dayOfDate:_date])];
    }
    

    if (_needsAdjustingViewFrame || CGSizeEqualToSize(_titleLabel.frame.size, CGSizeZero)) {
        _needsAdjustingViewFrame = NO;
        
        CGFloat titleHeight = ceil([@"1" sizeWithAttributes:@{NSFontAttributeName:_titleLabel.font}].height);
        if (_subtitle) {
            _subtitleLabel.hidden = NO;
            _subtitleLabel.text = _subtitle;
            
            CGFloat subtitleHeight = ceil([@"1" sizeWithAttributes:@{NSFontAttributeName:_subtitleLabel.font}].height);
            /*
            CGFloat height = titleHeight + subtitleHeight;
            _titleLabel.frame = CGRectMake(0,
                                           (self.contentView.fs_height*5.0/6.0-height)*0.5+_appearance.titleVerticalOffset,
                                           self.fs_width,
                                           titleHeight);
            
            _subtitleLabel.frame = CGRectMake(0,
                                              _titleLabel.fs_bottom - (_titleLabel.fs_height-_titleLabel.font.pointSize)+_appearance.subtitleVerticalOffset,
                                              self.fs_width,
                                              subtitleHeight);

             */
            
            _titleLabel.frame = CGRectMake(0, 12*kDeviceScaleFactor, self.fs_width, titleHeight*kDeviceScaleFactor);
            _subtitleLabel.frame = CGRectMake(0, self.fs_height - subtitleHeight*kDeviceScaleFactor ,self.fs_width , subtitleHeight*kDeviceScaleFactor);
            
        } else {
            /*
            _titleLabel.frame = CGRectMake(0, _appearance.titleVerticalOffset, self.fs_width, floor(self.contentView.fs_height*5.0/6.0));
             */
            _titleLabel.frame = CGRectMake(0, (FSCalendarStandardRowHeight - titleHeight) / 2.0 * kDeviceScaleFactor, self.fs_width, titleHeight * kDeviceScaleFactor);

            _subtitleLabel.hidden = YES;
        }
        
    }

    
    UIColor *textColor = self.colorForTitleLabel;
    if (![textColor isEqual:_titleLabel.textColor]) {
        _titleLabel.textColor = textColor;
    }
    if (_subtitle) {
        textColor = self.colorForSubtitleLabel;
        if (![textColor isEqual:_subtitleLabel.textColor]) {
            _subtitleLabel.textColor = textColor;
        }
    }
    
    UIColor *borderColor = self.colorForCellBorder;
    BOOL shouldHiddenBackgroundLayer = !self.selected && !self.dateIsToday && !self.dateIsSelected && !borderColor;
    
    if (_backgroundLayer.hidden != shouldHiddenBackgroundLayer) {
        _backgroundLayer.hidden = shouldHiddenBackgroundLayer;
    }
    if (!shouldHiddenBackgroundLayer) {
        
        CGPathRef path = self.cellShape == FSCalendarCellShapeCircle ?
        [UIBezierPath bezierPathWithOvalInRect:_backgroundLayer.bounds].CGPath :
        [UIBezierPath bezierPathWithRect:_backgroundLayer.bounds].CGPath;
        if (!CGPathEqualToPath(_backgroundLayer.path,path)) {
            _backgroundLayer.path = path;
        }
        
        CGColorRef backgroundColor = self.colorForBackgroundLayer.CGColor;
        if (!CGColorEqualToColor(_backgroundLayer.fillColor, backgroundColor)) {
            _backgroundLayer.fillColor = backgroundColor;
        }
        
        CGColorRef borderColor = self.colorForCellBorder.CGColor;
        if (!CGColorEqualToColor(_backgroundLayer.strokeColor, borderColor)) {
            _backgroundLayer.strokeColor = borderColor;
        }
        
    }
    
    if (![_image isEqual:_imageView.image]) {
        [self invalidateImage];
    }
    
    if (_eventLayer.hidden == _hasEvent) {
        _eventLayer.hidden = !_hasEvent;
        if (_hasEvent) {
            CGColorRef color = self.preferedEventColor.CGColor ?: _appearance.eventColor.CGColor;
            if (!CGColorEqualToColor(color, _eventLayer.fillColor)) {
                _eventLayer.fillColor = color;
            }
        }
    }
    
    if (self.inSelectedRange) {
        _titleLabel.textColor = _appearance.titleColors[@(FSCalendarCellStateSelected)];
        [self setSelectedLayerRectCornerType];
        _selectedLayer.hidden = NO;
    } else {
        _selectedLayer.hidden = YES;
    }
    if (self.checkIn || self.checkOut) {
        if ((([self isTheFirstDayOfWeek] || [self isTheFirstDayOfMonth]) && self.checkOut)
            || (([self isTheLastDayOfWeek] || [self isTheLastDayOfMonth]) && self.checkIn)
            || (self.checkIn && self.checkOut)) {
            _selectedLayer.hidden = YES;
        }
        _titleLabel.textColor = _appearance.titleColors[@(FSCalendarCellStateSelected)];
        if (_subtitleLabel) {
            _subtitleLabel.textColor =  _appearance.titleColors[@(FSCalendarCellStateInSelectedRange)];
        }
        _backgroundLayer.hidden = false;
        _backgroundLayer.cornerRadius = _backgroundLayer.frame.size.height/2.0;
        _backgroundLayer.masksToBounds = YES;
        self.backgroundLayer.backgroundColor = [OIAppTheme colorForTextButtonHilighted].CGColor;
    
    }
    else {
         _backgroundLayer.hidden = true;
    }
    if ([self isNotCurrentMonthPlaceholder]) {
        self.hidden = YES;
    }
    else{
        self.hidden = NO;
    }
}
- (BOOL)isTheFirstDayOfWeek
{
    return _date && ([_calendar weekdayOfDate:_date] == 1);
}

- (BOOL)isTheLastDayOfWeek
{
    return _date && ([_calendar weekdayOfDate:_date] == 7);
}

- (BOOL)isTheFirstDayOfMonth
{
    return [[self.date fs_dateBySubtractingDays:1] fs_isEqualToDateForMonth:[_month fs_dateBySubtractingMonths:1]];
}

- (BOOL)isTheLastDayOfMonth
{
   return [[self.date fs_dateByAddingDays:1] fs_isEqualToDateForMonth:[_month fs_dateByAddingMonths:1]];
}


- (BOOL)isWeekend
{
    return _date && ([_calendar weekdayOfDate:_date] == 1 || [_calendar weekdayOfDate:_date] == 7);
}

- (BOOL)isToday
{
    return [_date fs_isEqualToDateForDay:[NSDate date]];
}
- (BOOL)isNotCurrentMonthPlaceholder
{
    return ![_date fs_isEqualToDateForMonth:_month];
}


- (UIColor *)colorForCurrentStateInDictionary:(NSDictionary *)dictionary
{
    if (self.isSelected || self.dateIsSelected) {
        if (self.dateIsToday) {
            return dictionary[@(FSCalendarCellStateSelected|FSCalendarCellStateToday)] ?: dictionary[@(FSCalendarCellStateSelected)];
        }
        return dictionary[@(FSCalendarCellStateSelected)];
    }
    if (self.dateIsToday && [[dictionary allKeys] containsObject:@(FSCalendarCellStateToday)]) {
        return dictionary[@(FSCalendarCellStateToday)];
    }
    if (self.dateIsPlaceholder && [[dictionary allKeys] containsObject:@(FSCalendarCellStatePlaceholder)]) {
        return dictionary[@(FSCalendarCellStatePlaceholder)];
    }
    if (self.isWeekend && [[dictionary allKeys] containsObject:@(FSCalendarCellStateWeekend)]) {
        return dictionary[@(FSCalendarCellStateWeekend)];
    }
    return dictionary[@(FSCalendarCellStateNormal)];
}

- (void)invalidateTitleFont
{
    _titleLabel.font = _appearance.titleFont;
}

- (void)invalidateTitleTextColor
{
    _titleLabel.textColor = self.colorForTitleLabel;
}

- (void)invalidateSubtitleFont
{
    _subtitleLabel.font = _appearance.subtitleFont;
}

- (void)invalidateSubtitleTextColor
{
    _subtitleLabel.textColor = self.colorForSubtitleLabel;
}

- (void)invalidateBorderColors
{
    _backgroundLayer.strokeColor = self.colorForCellBorder.CGColor;
}

- (void)invalidateBackgroundColors
{
    _backgroundLayer.fillColor = self.colorForBackgroundLayer.CGColor;
}

- (void)invalidateEventColors
{
    _eventLayer.fillColor = self.preferedEventColor.CGColor ?: _appearance.eventColor.CGColor;
}

- (void)invalidateCellShapes
{
    CGPathRef path = self.cellShape == FSCalendarCellShapeCircle ?
    [UIBezierPath bezierPathWithOvalInRect:_backgroundLayer.bounds].CGPath :
    [UIBezierPath bezierPathWithRect:_backgroundLayer.bounds].CGPath;
    _backgroundLayer.path = path;
}

- (void)invalidateImage
{
    _imageView.image = _image;
    _imageView.hidden = !_image;
}

#pragma mark - Properties

- (UIColor *)colorForBackgroundLayer
{
    if (self.dateIsSelected || self.isSelected) {
        return self.preferedSelectionColor ?: [self colorForCurrentStateInDictionary:_appearance.backgroundColors];
    }
    return [self colorForCurrentStateInDictionary:_appearance.backgroundColors];
}

- (UIColor *)colorForTitleLabel
{
    if (self.dateIsSelected || self.isSelected) {
        return self.preferedTitleSelectionColor ?: [self colorForCurrentStateInDictionary:_appearance.titleColors];
    }
    return self.preferedTitleDefaultColor ?: [self colorForCurrentStateInDictionary:_appearance.titleColors];
}

- (UIColor *)colorForSubtitleLabel
{
    if (self.dateIsSelected || self.isSelected) {
        return self.preferedSubtitleSelectionColor ?: [self colorForCurrentStateInDictionary:_appearance.subtitleColors];
    }
    return self.preferedSubtitleDefaultColor ?: [self colorForCurrentStateInDictionary:_appearance.subtitleColors];
}

- (UIColor *)colorForCellBorder
{
    if (self.dateIsSelected || self.isSelected) {
        return _preferedBorderSelectionColor ?: _appearance.borderSelectionColor;
    }
    return _preferedBorderDefaultColor ?: _appearance.borderDefaultColor;
}

- (FSCalendarCellShape)cellShape
{
    return _preferedCellShape ?: _appearance.cellShape;
}

- (void)setCalendar:(FSCalendar *)calendar
{
    if (![_calendar isEqual:calendar]) {
        _calendar = calendar;
    }
    if (![_appearance isEqual:calendar.appearance]) {
        _appearance = calendar.appearance;
        [self invalidateTitleFont];
        [self invalidateSubtitleFont];
        [self invalidateTitleTextColor];
        [self invalidateSubtitleTextColor];
        [self invalidateEventColors];
    }
}

- (void)setSubtitle:(NSString *)subtitle
{
    if (![_subtitle isEqualToString:subtitle]) {
        _needsAdjustingViewFrame = !(_subtitle.length && subtitle.length);
        _subtitle = subtitle;
        _subtitleLabel.text = subtitle;
        if (_needsAdjustingViewFrame) {
            [self setNeedsLayout];
        }
    }
}

- (void)setSelectedLayerRectCornerType {
    CellCornerType cornerType = CellCornerTypeNone;
    UIRectCorner corner = UIRectCornerAllCorners;
    CGFloat radius = kBackgroundLayerHeight / 2.0;
    
    self.selectedLayer.frame = CGRectMake(0, kBackgroundLayerTop, self.width, kBackgroundLayerHeight);
    
    if (self.checkIn || [self isTheFirstDayOfWeek] || [self isTheFirstDayOfMonth]) {
        cornerType = CellCornerTypeLeft;
        corner = UIRectCornerTopLeft | UIRectCornerBottomLeft;
        self.selectedLayer.frame = CGRectMake(((self.fs_width - kBackgroundLayerHeight)/2.0), kBackgroundLayerTop, self.width - (self.fs_width - kBackgroundLayerHeight)/2.0, kBackgroundLayerHeight);
        
    }
    if (self.checkOut || [self isTheLastDayOfWeek] || [self isTheLastDayOfMonth]) {
        cornerType = CellCornerTypeRight;
        corner = UIRectCornerTopRight | UIRectCornerBottomRight;
        self.selectedLayer.frame = CGRectMake(0, kBackgroundLayerTop, self.width - (self.fs_width - kBackgroundLayerHeight)/2.0, kBackgroundLayerHeight);
    }
    
    if (cornerType > CellCornerTypeNone) {
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.selectedLayer.bounds
                                                       byRoundingCorners:corner
                                                             cornerRadii:CGSizeMake(radius, radius)];
        self.selectedLayer.path = maskPath.CGPath;
        
    } else {
        self.selectedLayer.path = [UIBezierPath bezierPathWithRect:self.selectedLayer.bounds].CGPath;
    }
     self.selectedLayer.fillColor = [OIAppTheme colorForCalendarSelection].CGColor;
}


@end



