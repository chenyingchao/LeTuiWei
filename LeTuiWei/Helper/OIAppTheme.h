//
//  OIAppTheme.h
//  OilInstalments
//
//  Created by 陈颖超 on 2017/2/6.
//  Copyright © 2017年 chenyingchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define Theme OIAppTheme

#define kNavigationBarHeight            44
#define kStatusBarHeight                20
#define kToolBarHeight                  49
#define kDefaultButtonCornerRadius     (4 * kDeviceScaleFactor)
#define kDefaultRowHeight               44.0f

@interface OIAppTheme : NSObject


/**
 Color settings
 */

// Design spec colors

+ (UIColor *)colorThemeColor;

+ (UIColor *)colorWhite;

+ (UIColor *)colorWhiteWithAlpha:(CGFloat)alpha;

+ (UIColor *)colorBlack;

+ (UIColor *)colorBlackWithAlpha:(CGFloat)alpha;

+ (UIColor *)colorDarkGray;

+ (UIColor *)colorDarkGrayWithAlpha:(CGFloat)alpha;

+ (UIColor *)colorGray;

+ (UIColor *)colorDimGray;

+ (UIColor *)colorDimGrayWithAlpha:(CGFloat)alpha;

+ (UIColor *)colorLightGray;

+ (UIColor *)colorLightGrayWithAlpha:(CGFloat)alpha;

+ (UIColor *)colorTransparent;

+ (UIColor *)colorBgGray;

+ (UIColor *)colorOverViewBg ;

// Common component colors

+ (UIColor *)colorForAppBackground;

// Text
+ (UIColor *)colorForTextTitle;

+ (UIColor *)colorForTextTitleWithAlpha:(CGFloat)alpha;

+ (UIColor *)colorForTextBody;

+ (UIColor *)colorForTextBodyWithAlpha:(CGFloat)alpha;

+ (UIColor *)colorForTextNotes;

+ (UIColor *)colorForTextNotesWithAlpha:(CGFloat)alpha;

+ (UIColor *)colorForTextPlaceHolder;

+ (UIColor *)colorForTextPrice;

+ (UIColor *)colorForSeparatorLine;

+ (UIColor *)colorForSelectionHighlight;

+ (UIColor *)colorForNavigationBarBackground;

+ (UIColor *)colorForNavigationBarBackgroundWithAlpha:(CGFloat)alpha;

+ (UIColor *)colorForNavigationBarText;

+ (UIColor *)colorForToolbarBackground;

+ (UIColor *)colorForTabBackground;

+ (UIColor *)colorForButtonBackgroundNormal;

+ (UIColor *)colorForButtonBackgroundTouched;

+ (UIColor *)colorForButtonBorderGray;

+ (UIColor *)colorForButtonBorderGrayWithAlpha:(CGFloat)alpha;

+ (UIColor *)colorForTextButtonNormal;

+ (UIColor *)colorForTextButtonNormalWithAlpha:(CGFloat)alpha;

+ (UIColor *)colorForTextButtonHilighted;

+ (UIColor *)colorForOrangeTextNotes;

// Special component colors

+ (UIColor *)colorForHighlightBluishGreen;

+ (UIColor *)colorForHighlightBluishGreenWithAlpha:(CGFloat)alpha;

+ (UIColor *)colorForSectionBackgroundGray;

+ (UIColor *)colorForCalendarSelection;

+ (UIColor *)colorForCalendarButtonNormalBackground;

+ (UIColor *)colorForSearchBarBgColor;

+ (UIColor *)colorForAppearance;

/**
 Font settings
 */

+ (UIFont *)fontWithSize50;

+ (UIFont *)fontWithSize40;

+ (UIFont *)fontWithSize36;

+ (UIFont *)fontWithSize32;

+ (UIFont *)fontWithSize30;

+ (UIFont *)fontWithSize28;

+ (UIFont *)fontWithSize24;

+ (UIFont *)fontWithSize20;

+ (UIFont *)fontWithSize18;

+ (UIFont *)boldFontWithSize40;

+ (UIFont *)boldFontWithSize36;

+ (UIFont *)boldFontWithSize32;

+ (UIFont *)boldFontWithSize28;

+ (UIFont *)boldFontWithSize24;

+ (UIFont *)boldFontWithSize44;

+ (UIFont *)boldFontWithSize48;

+ (UIFont *)boldFontWithSize52;

/**
 Size settings
 */
+ (CGFloat)paddingWithSize:(CGFloat)size;

+ (CGFloat)paddingWithSize28;

+ (CGFloat)paddingWithSize36;

+ (CGFloat)paddingWithSize40;

+ (CGFloat)paddingWithSize100;

+ (CGFloat)paddingWithSize120;


+ (CGFloat)paddingWithSize32;

+ (CGFloat)paddingWithSize24;

+ (CGFloat)paddingWithSize20;

+ (CGFloat)paddingWithSize12;

+ (CGFloat)paddingWithSize10 ;

+ (CGFloat)defaultCellHeight;

+ (CGFloat)defaultCellHeight48;

+ (CGFloat)defaultSectionHeaderHeight;

+ (CGFloat)scaleWithSize:(CGFloat)size;


/**
 Misc
 */
+ (CGFloat)defaultBackgroundAlpha;


@end
