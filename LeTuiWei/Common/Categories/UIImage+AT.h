//
//  UIImage+AT.h
//  AsiaTravel
//
//  Created by wangxinxin on 15/11/18.
//  Copyright © 2015年 asiatravel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (AT)

+ (UIImage *)imageByApplyingAlpha:(CGFloat)alpha  image:(UIImage*)image;

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)imageWithColor:(UIColor *)color rect:(CGRect)rect;

+ (UIImage *)resizedImageWithName:(NSString *)name;

+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;

+ (UIImage *)placeholderImageWithSize:(CGSize)size;

+ (UIImage *)fixSizedPlaceholderImageWithSize:(CGSize)size;

/**
 *  Fix  Image orientation Problem of UIImagePickerController
 *
 *  @return orientation problem Fixed Image
 */
- (UIImage *)fixOrientation;

/**
 *  aspectFill image to a given size
 *
 *  @param size
 *
 *  @return resized image
 */
- (UIImage*)aspectFill:(CGSize)size;

- (UIImage*)aspectFill:(CGSize)size offset:(CGFloat)offset;

// scale the image to proper fit the given size,
- (UIImage *)scaledToSize:(CGSize)size;

@end
