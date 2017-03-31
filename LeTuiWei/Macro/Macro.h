//
//  Macro.h
//  OilInstalments
//
//  Created by 陈颖超 on 2017/1/24.
//  Copyright © 2017年 chenyingchao. All rights reserved.
//

#define WS(weakSelf)                __weak __typeof(&*self)weakSelf = self;

#define OILocalizedString(x)        NSLocalizedString(x, nil)

#ifdef DEBUG
#define OIDevLog(xx, ...)       NSLog(@"%s(%d):\n\t* " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define OIDevLog(xx, ...)       ((void)0)
#endif


#define kStrHasValue(str)		   (str && [str isKindOfClass:[NSString class]] && [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length > 0)

#define kReplaceWithEmptySpaceIfNull(str) kStrHasValue(str) ? str : @""

/************************************--Color Tool--***********************************************/
#define Color(r, g, b)              [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define ColorA(r, g, b ,a)          [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define UIColorFromRGB(rgbValue)    [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFromAlphaRGB(rgbValue,a) \
[UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

/*************************************--Screen Size and Device Version--**************************/
#define iPhone4S                        ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? \
CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone5                         ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? \
CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define kScreenIphone6                  (([[UIScreen mainScreen] bounds].size.width)>=375)

#define kScreenHeight                   [UIScreen mainScreen].bounds.size.height

#define kScreenWidth                    [UIScreen mainScreen].bounds.size.width

#define iPhone5Padding                  ((fabs((double)[[UIScreen mainScreen ]bounds].size.height - (double)568 ) < DBL_EPSILON ) ?88:0)

#define IOS6                            ([[[UIDevice currentDevice] systemVersion] compare:@"6.0" options:NSNumericSearch] != NSOrderedAscending)

#define IOS7_OR_LATER                   ([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending)

#define IOS8_OR_LATER                   ([[[UIDevice currentDevice] systemVersion] compare:@"8.0" options:NSNumericSearch] != NSOrderedAscending)

#define IOS7_OR_Later_VIEW_OFFSET       (IOS7_OR_LATER?64:0)

#define iOS7                            ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0 ? YES : NO)

#define NLSystemVersionGreaterOrEqualThan(version) \
([[[UIDevice currentDevice] systemVersion] floatValue] >= version)

#define IOS9                            NLSystemVersionGreaterOrEqualThan(9.0)

#define kDeviceScaleFactor              (kScreenWidth/375.0)

#define ATKeyWindow                     [UIApplication sharedApplication].keyWindow

#define kAppVersion                     [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]


#define kAppAdIdentifier                kReplaceWithEmptySpaceIfNull([[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString])

#define kSeparatorHeight  0.5f

#define APP_Version  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]


