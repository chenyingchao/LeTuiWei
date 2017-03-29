//
//  UIImage+AT.m
//  AsiaTravel
//
//  Created by wangxinxin on 15/11/18.
//  Copyright © 2015年 asiatravel. All rights reserved.
//

#import "UIImage+AT.h"

@implementation UIImage (AT)

+ (UIImage *)imageByApplyingAlpha:(CGFloat)alpha  image:(UIImage*)image {
    //set image alpha
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextSetAlpha(ctx, alpha);
    
    CGContextDrawImage(ctx, area, image.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    return [self imageWithColor:color rect:rect];
}

+ (UIImage *)imageWithColor:(UIColor *)color rect:(CGRect)rect{
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#define kPlaceholderImageWidth 188
#define kPlaceholderImageHeight 174

+ (UIImage *)placeholderImageWithSize:(CGSize)size {
    // place holder image
    UIImage *placeholderImage = [UIImage imageNamed:@"placeholder"];
    UIImage *colorImage = [UIImage imageWithColor:[Theme colorForAppBackground]];
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    [colorImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    CGFloat placeholderWidth = kPlaceholderImageWidth;
    CGFloat placeholderHeight = kPlaceholderImageHeight;
    // find the best size,
    CGFloat containerSize = fmin(size.width, size.height);
    CGFloat factor = 1;
    while (kPlaceholderImageWidth / factor > containerSize && factor < 4) {
        factor += 1;
    }
    if (factor < 4) {
        placeholderWidth = kPlaceholderImageWidth / factor;
        placeholderHeight = kPlaceholderImageHeight / factor;
    } else {
        placeholderHeight = placeholderWidth = containerSize;
    }
    
    CGRect targetFrame = CGRectMake((size.width - placeholderWidth) / 2, (size.height - placeholderHeight) / 2, placeholderWidth, placeholderHeight);
    
    [placeholderImage drawInRect:targetFrame];
    
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return finalImage;
}

+ (UIImage *)fixSizedPlaceholderImageWithSize:(CGSize)size {
    if (size.width < kPlaceholderImageWidth || size.height < kPlaceholderImageHeight) {
        return [self placeholderImageWithSize:size];
    }
    UIImage *placeholderImage = [UIImage imageNamed:@"placeholder"];
    UIImage *colorImage = [UIImage imageWithColor:[Theme colorForAppBackground]];
    CGFloat placeholderWidth = kPlaceholderImageWidth / 2;
    CGFloat placeholderHeight = kPlaceholderImageHeight / 2;
 
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    [colorImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    CGRect targetFrame = CGRectMake((size.width - placeholderWidth) / 2, (size.height - placeholderHeight) / 2, placeholderWidth, placeholderHeight);
    
    [placeholderImage drawInRect:targetFrame];
    
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return finalImage;
}

+ (UIImage *)resizedImageWithName:(NSString *)name {
    return [self resizedImageWithName:name left:0.5 top:0.5];
}

+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top {
    UIImage *image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * left topCapHeight:image.size.height * top];
}

+ (UIImage *)originalImageWithImageName:(NSString *)ImageName {
    UIImage * image = [UIImage imageNamed:ImageName];
    
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (UIImage *)fixOrientation {
    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

- (UIImage*)aspectFill:(CGSize)size {
    return [self aspectFill:size offset:0];
}

- (UIImage*)aspectFill:(CGSize)size offset:(CGFloat)offset {
    int w  = size.width;
    int h  = size.height;
    int wTwo = self.size.width;
    int hTwo = self.size.height;
    
    CGImageRef   imageRef = self.CGImage;
    CGColorSpaceRef colorSpaceInfo = CGImageGetColorSpace(imageRef);
    
    CGContextRef bitmap = CGBitmapContextCreate(NULL, w, h, 8, 4*w, colorSpaceInfo, kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrder32Little);
    
    
    if(self.imageOrientation == UIImageOrientationLeft || self.imageOrientation == UIImageOrientationRight){
        w  = size.height;
        h  = size.width;
        wTwo = self.size.height;
        hTwo = self.size.width;
    }
    
    double ratio = MAX(w/(double)wTwo, h/(double)hTwo);
    wTwo = ratio * wTwo;
    hTwo = ratio * hTwo;
    
    int dW = abs((wTwo-w)/2);
    int dH = abs((hTwo-h)/2);
    
    if(dW==0){ dH += offset; }
    if(dH==0){ dW += offset; }
    
    if(self.imageOrientation == UIImageOrientationLeft || self.imageOrientation == UIImageOrientationLeftMirrored){
        CGContextRotateCTM (bitmap, M_PI/2);
        CGContextTranslateCTM (bitmap, 0, -h);
    }
    else if (self.imageOrientation == UIImageOrientationRight || self.imageOrientation == UIImageOrientationRightMirrored){
        CGContextRotateCTM (bitmap, -M_PI/2);
        CGContextTranslateCTM (bitmap, -w, 0);
    }
    else if (self.imageOrientation == UIImageOrientationUp || self.imageOrientation == UIImageOrientationUpMirrored){
        // Nothing
    }
    else if (self.imageOrientation == UIImageOrientationDown || self.imageOrientation == UIImageOrientationDownMirrored){
        CGContextTranslateCTM (bitmap, w, h);
        CGContextRotateCTM (bitmap, -M_PI);
    }
    
    CGContextDrawImage(bitmap, CGRectMake(-dW, -dH, wTwo, hTwo), imageRef);
    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    UIImage* newImage = [UIImage imageWithCGImage:ref];
    
    CGContextRelease(bitmap);
    CGImageRelease(ref);
    
    return newImage;
}

- (UIImage *)scaledToSize:(CGSize)size {
    UIImage *fixedImage = [self fixOrientation];
    CGFloat imageWidth = fixedImage.size.width * self.scale;
    CGFloat imageHeight = fixedImage.size.height * self.scale;
    CGFloat imageRatio = (imageWidth / imageHeight);
    
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    
    if (!targetHeight || !targetWidth) {
        return fixedImage;
    }
    
    CGFloat clipWidth, clipHeight;
    
    if (targetWidth > imageWidth && targetHeight > imageHeight) {
        // clip to target ratio
        if (imageWidth < imageHeight) {
            clipWidth = imageWidth;
            clipHeight = clipWidth * (1 / imageRatio);
        } else {
            clipHeight = imageHeight;
            clipWidth = clipHeight * imageRatio;
        }
    } else if (targetWidth > imageWidth && targetHeight <= imageHeight) {
        clipWidth = imageWidth;
        clipHeight = clipWidth * (targetHeight / targetWidth);
    } else if (targetWidth <= imageWidth && targetHeight > imageHeight) {
        clipHeight = imageHeight;
        clipWidth = clipHeight * (targetWidth / targetHeight);
    } else {
        // target height <= image height, target width <= imagew width
        if (imageWidth < imageHeight) {
            clipWidth = imageWidth;
            clipHeight = clipWidth * (targetHeight / targetWidth);
        } else {
            clipHeight = imageHeight;
            clipWidth = clipHeight * (targetWidth / targetHeight);
        }
    }
    CGRect targetRect = CGRectMake((imageWidth - clipWidth) * 0.5, (imageHeight - clipHeight) * 0.5, clipWidth, clipHeight);
    
    CGImageRef croppedCGImage = CGImageCreateWithImageInRect(self.CGImage, targetRect);
    UIImage *croppedImage = [UIImage imageWithCGImage:croppedCGImage scale:1 orientation:self.imageOrientation];
    CGImageRelease(croppedCGImage);
    
    return croppedImage;
}

@end
