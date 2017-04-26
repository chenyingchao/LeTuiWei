//
//  OIAppTheme.m
//  OilInstalments
//
//  Created by 陈颖超 on 2017/2/6.
//  Copyright © 2017年 chenyingchao. All rights reserved.
//

#import "OIAppTheme.h"

@implementation OIAppTheme

#define ATThemeOrange   1   // Let's say, OrangeTheme,

#define kDefaultBackgroundAlpha 0.5

#define kDefaultCellHeight      48

#define kDefaultCellHeight48    48

#define kColorWhite                             0xffffff
#define kColorBlack                             0x000000
#define kColorDarkGray                          0x333333
#define kColorGray                              0x666666
#define kColorDimGray                           0x999999
#define kColorLightGray                         0xd1d1d1

#define kColorAppearance                           0x3f88cd

#define kColorBgGray                         0xf0f0f0

#ifdef ATThemeOrange
// color
#define kColorThemeOrange                       0x8ace00

#define kColorForHilightBluishGreen             0x55bfb7                    //text, hotel rating

#define kColorForTextButtonNormal               kColorLightGray             //text, used in button, not hilighted, bit gray than normal text color

#define kColorForButtonBackgroundNormal         kColorThemeOrange           //button, normal state
#define kColorForButtonBackgroundTouched        0x7cb700                    //button, selected (hilighted)

#define kColorForButtonBackgroundDisabled       0xdedede                    //button, bit gray
#define kColorForGrayButtonBorder               kColorLightGray             //button border line color

#define kColorForTextNavigationTitle            kColorDarkGray                 //text, title in navigation bar, white
#define kColorForNavigationBarBackground        0xfcfcfc

#define kColorForSectionBackgroundGray          0xf7f7f7
#define kColorForAppBackground                  0xf7f7f7
#define kColorForTabbarBackground               kColorWhite

#define kColorForTipBackgroundYellow            0xfad485
#define kColorForToolBarBackground              kColorBlack

#define kColorForTextPrice                      0xfb7530
#define kColorForTextTitle                      kColorDarkGray
#define kColorForTextBody                       kColorGray
#define kColorForTextNotes                      kColorDimGray
#define kColorForTextPlaceHolder                kColorLightGray
#define kColorForSeparatorLine                  0xe6e6e6
#define kColorForSelectionHighlight             kColorForSeparatorLine
#define kColorForSearchBarBgColor               0xeeeeee
#define kColorForOrangeTextNotes                0xfd7530

#define kColorForOverViewbg                     0x222b59


// (font) size
#define kFontSize52                             (26 * kDeviceScaleFactor)
#define kFontSize50                             (25 * kDeviceScaleFactor)
#define kFontSize48                             (24 * kDeviceScaleFactor)
#define kFontSize44                             (22 * kDeviceScaleFactor)
#define kFontSize40                             (20 * kDeviceScaleFactor)
#define kFontSize36                             (18 * kDeviceScaleFactor)
#define kFontSize32                             (16 * kDeviceScaleFactor)
#define kFontSize30                             (15 * kDeviceScaleFactor)
#define kFontSize28                             (14 * kDeviceScaleFactor)
#define kFontSize24                             (12 * kDeviceScaleFactor)
#define kFontSize20                             (10 * kDeviceScaleFactor)
#define kFontSize18                             (9 * kDeviceScaleFactor)

#endif

/**
 Color settings
 */
+ (UIColor *)colorForButtonBackgroundNormal {
    return UIColorFromRGB(kColorForButtonBackgroundNormal);
}

+ (UIColor *)colorForButtonBackgroundTouched {
    return UIColorFromRGB(kColorForButtonBackgroundTouched);
}

+ (UIColor *)colorForTextButtonNormal {
    return UIColorFromRGB(kColorThemeOrange);
}

+ (UIColor *)colorForTextButtonNormalWithAlpha:(CGFloat)alpha {
    return UIColorFromAlphaRGB(kColorThemeOrange, alpha);
}

+ (UIColor *)colorForTextButtonHilighted {
    return UIColorFromRGB(kColorThemeOrange);
}

+ (UIColor *)colorForButtonBorderGray {
    return UIColorFromRGB(kColorForGrayButtonBorder);
}

+ (UIColor *)colorForButtonBorderGrayWithAlpha:(CGFloat)alpha {
    return UIColorFromAlphaRGB(kColorForGrayButtonBorder, alpha);
}

+ (UIColor *)colorForNavigationBarText {
    return UIColorFromRGB(kColorForTextNavigationTitle);
}

+ (UIColor *)colorForNavigationBarBackground {
    return UIColorFromAlphaRGB(kColorForNavigationBarBackground, 0.95);
}

+ (UIColor *)colorForNavigationBarBackgroundWithAlpha:(CGFloat)alpha {
    return UIColorFromAlphaRGB(kColorForNavigationBarBackground, alpha);
}

+ (UIColor *)colorForHighlightBluishGreen {
    return UIColorFromRGB(kColorForHilightBluishGreen);
}

+ (UIColor *)colorForHighlightBluishGreenWithAlpha:(CGFloat)alpha {
    return UIColorFromAlphaRGB(kColorForHilightBluishGreen, alpha);
}

+ (UIColor *)colorThemeColor {
    return UIColorFromRGB(kColorThemeOrange);
}

+ (UIColor *)colorForTextBody {
    return UIColorFromRGB(kColorForTextBody);
}

+ (UIColor *)colorForTextBodyWithAlpha:(CGFloat)alpha {
    return UIColorFromAlphaRGB(kColorForTextBody, alpha);
}

+ (UIColor *)colorDarkGray {
    return UIColorFromRGB(kColorDarkGray);
}

+ (UIColor *)colorForAppearance {
    return UIColorFromRGB(kColorAppearance);
}

+ (UIColor *)colorDarkGrayWithAlpha:(CGFloat)alpha {
    return UIColorFromAlphaRGB(kColorDarkGray, alpha);
}

+ (UIColor *)colorLightGray {
    return UIColorFromRGB(kColorLightGray);
}

+ (UIColor *)colorLightGrayWithAlpha:(CGFloat)alpha {
    return UIColorFromAlphaRGB(kColorLightGray, alpha);
}

+ (UIColor *)colorDimGray {
    return UIColorFromRGB(kColorDimGray);
}

+ (UIColor *)colorDimGrayWithAlpha:(CGFloat)alpha {
    return UIColorFromAlphaRGB(kColorDimGray, alpha);
}

+ (UIColor *)colorForTextPlaceHolder {
    return UIColorFromRGB(kColorForTextPlaceHolder);
}

+ (UIColor *)colorForCommentBlue {
    return UIColorFromRGB(0x3f88cd);
}

+ (UIColor *)colorGray {
    return UIColorFromRGB(kColorGray);
}

+ (UIColor *)colorBgGray {
    return UIColorFromRGB(kColorBgGray);
}


+ (UIColor *)colorOverViewBg {
    return UIColorFromRGB(kColorForOverViewbg);
}

+ (UIColor *)colorTransparent {
    return [UIColor clearColor];
}

+ (UIColor *)colorForAppBackground {
    return UIColorFromRGB(kColorForAppBackground);
}

+ (UIColor *)colorForSeparatorLine {
    return UIColorFromRGB(kColorForSeparatorLine);
}

+ (UIColor *)colorForSelectionHighlight {
    return UIColorFromRGB(kColorForSeparatorLine);
}

+ (UIColor *)colorForTabBackground {
    return  UIColorFromAlphaRGB(kColorForTabbarBackground, 0.7);
}

+ (UIColor *)colorBlack {
    return [UIColor blackColor];
}

+ (UIColor *)colorBlackWithAlpha:(CGFloat)alpha {
    return UIColorFromAlphaRGB(kColorForToolBarBackground, alpha);
}

+ (UIColor *)colorWhite {
    return [UIColor whiteColor];
}

+ (UIColor *)colorWhiteWithAlpha:(CGFloat)alpha {
    return UIColorFromAlphaRGB(kColorWhite, alpha);
}

+ (UIColor *)colorForTextPrice {
    return UIColorFromRGB(kColorForTextPrice);
}

+ (UIColor *)colorForSectionBackgroundGray {
    return UIColorFromRGB(kColorForSectionBackgroundGray);
}

+ (UIColor *)colorForToolbarBackground {
    return UIColorFromAlphaRGB(kColorForToolBarBackground, 0.3);
}

+ (UIColor *)colorForTextNotes {
    return UIColorFromRGB(kColorForTextNotes);
}

+ (UIColor *)colorForTextNotesWithAlpha:(CGFloat)alpha {
    return UIColorFromAlphaRGB(kColorForTextNotes, alpha);
}

+ (UIColor *)colorForTextTitle {
    return UIColorFromRGB(kColorForTextTitle);
}

+ (UIColor *)colorForTextTitleWithAlpha:(CGFloat)alpha {
    return UIColorFromAlphaRGB(kColorForTextTitle, alpha);
}

+ (UIColor *)colorForCalendarSelection {
    return UIColorFromAlphaRGB(kColorThemeOrange, 0.6);
}

+ (UIColor *)colorForCalendarButtonNormalBackground {
    return UIColorFromAlphaRGB(kColorGray, 0.9);
}

+ (UIColor *)colorForSearchBarBgColor {
    return UIColorFromRGB(kColorForSearchBarBgColor);
}

+ (UIColor *)colorForOrangeTextNotes {
    return UIColorFromRGB(kColorForOrangeTextNotes);
}

/**
 Font settings, currently we're using UI design size.
 */
+ (UIFont *)fontWithSize50 {
    return [UIFont systemFontOfSize:kFontSize50];
}


+ (UIFont *)fontWithSize40 {
    return [UIFont systemFontOfSize:kFontSize40];
}

+ (UIFont *)fontWithSize36 {
    return [UIFont systemFontOfSize:kFontSize36];
}

+ (UIFont *)fontWithSize32 {
    return [UIFont systemFontOfSize:kFontSize32];
}

+ (UIFont *)fontWithSize30 {
    return [UIFont systemFontOfSize:kFontSize30];
}

+ (UIFont *)fontWithSize28 {
    return [UIFont systemFontOfSize:kFontSize28];
}

+ (UIFont *)fontWithSize24 {
    return [UIFont systemFontOfSize:kFontSize24];
}

+ (UIFont *)fontWithSize20 {
    return [UIFont systemFontOfSize:kFontSize20];
}

+ (UIFont *)fontWithSize18 {
    return [UIFont systemFontOfSize:kFontSize18];
}

+ (UIFont *)boldFontWithSize40 {
    return [UIFont boldSystemFontOfSize:kFontSize40];
}

+ (UIFont *)boldFontWithSize36 {
    return [UIFont boldSystemFontOfSize:kFontSize36];
}

+ (UIFont *)boldFontWithSize32 {
    return [UIFont boldSystemFontOfSize:kFontSize32];
}

+ (UIFont *)boldFontWithSize28 {
    return [UIFont boldSystemFontOfSize:kFontSize28];
}

+ (UIFont *)boldFontWithSize24 {
    return [UIFont boldSystemFontOfSize:kFontSize24];
}

+ (UIFont *)boldFontWithSize20 {
    return [UIFont boldSystemFontOfSize:kFontSize20];
}

+ (UIFont *)boldFfontWithSize18 {
    return [UIFont boldSystemFontOfSize:kFontSize18];
}

+ (UIFont *)boldFontWithSize44 {
    return [UIFont boldSystemFontOfSize:kFontSize44];
}

+ (UIFont *)boldFontWithSize48 {
    return [UIFont boldSystemFontOfSize:kFontSize48];
}

+ (UIFont *)boldFontWithSize52 {
    return [UIFont boldSystemFontOfSize:kFontSize52];
}

/**
 Size settings
 */

+ (CGFloat)paddingWithSize:(CGFloat)size{
    return (size / 2) * kDeviceScaleFactor;
}

+ (CGFloat)paddingWithSize28 {
    return [self paddingWithSize:28];
}

+ (CGFloat)paddingWithSize40 {
    return [self paddingWithSize:40];
}

+ (CGFloat)paddingWithSize36 {
    return [self paddingWithSize:36];
}

+ (CGFloat)paddingWithSize100 {
    return [self paddingWithSize:100];
}

+ (CGFloat)paddingWithSize120 {
    return [self paddingWithSize:120];
}

+ (CGFloat)paddingWithSize32 {
    return [self paddingWithSize:32];
}

+ (CGFloat)paddingWithSize24 {
    return [self paddingWithSize:24];
}

+ (CGFloat)paddingWithSize20 {
    return [self paddingWithSize:20];
}

+ (CGFloat)paddingWithSize12 {
    return [self paddingWithSize:12];
}

+ (CGFloat)paddingWithSize10 {
    return [self paddingWithSize:10];
}

+ (CGFloat)defaultCellHeight {
    return kDefaultCellHeight * kDeviceScaleFactor;
}


+ (CGFloat)defaultCellHeight48 {
    return kDefaultCellHeight48 * kDeviceScaleFactor;
}

+ (CGFloat)defaultSectionHeaderHeight {
    return [self paddingWithSize:68];
}

+ (CGFloat)scaleWithSize:(CGFloat)size {
    return [self paddingWithSize:size];
}

/**
 Misc
 */
+ (CGFloat)defaultBackgroundAlpha {
    return kDefaultBackgroundAlpha;
}


@end
