//
//  UIImage+PUImage.m
//  PublicUIKit
//
//  Created by Macbook on 2018/5/11.
//  Copyright © 2018年 Ehanghai. All rights reserved.
//

#import "UIImage+PUImage.h"
#import "PUCommon.h"
@implementation UIImage (PUImage)
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (UIImage *)simpleImage:(UIImage *)originImg
{
    CGSize imageSize = [self handleImage:originImg.size];
    UIGraphicsBeginImageContextWithOptions(imageSize, YES, 0.0);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, imageSize.width, imageSize.height)];
    CGContextAddPath(contextRef, bezierPath.CGPath);
    CGContextClip(contextRef);
    [originImg drawInRect:CGRectMake(0, 0, imageSize.width, imageSize.height)];
    UIImage *clipedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return clipedImage;
}

+ (CGSize)handleImage:(CGSize)retSize {
    CGFloat width = 0;
    CGFloat height = 0;
    if (retSize.width > retSize.height) {
        width = kPUScreenWidth;
        height = retSize.height / retSize.width * width;
    } else {
        height = kPUScreenHeight;
        width = retSize.width / retSize.height * height;
    }
    return CGSizeMake(width, height);
}


+ (UIImage *)addImage:(UIImage *)baseImg topImage:(UIImage *)topImage baseImgSize:(CGSize)baseImgSize topImgRect:(CGRect)topImgRect;
{
    if (baseImg == nil || topImage == nil) {
        return nil;
    }
    
    CGSize baseSize = baseImgSize;
    if (baseImgSize.width == 0 || baseImgSize.height == 0)
    {
        baseSize = baseImg.size;
    }
    
    UIGraphicsBeginImageContext(baseSize);
    [baseImg drawInRect:CGRectMake(0, 0, baseSize.width, baseSize.height)];
    
    if (topImgRect.size.width == 0 || topImgRect.size.height == 0) {
        [topImage drawInRect:topImgRect];
    }
    else
    {
        [topImage drawInRect:CGRectMake((baseSize.width-topImage.size.width)*0.5,(baseSize.height-topImage.size.height)*0.5, topImage.size.width, topImage.size.height)];
    }
    
    UIImage *resultImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImg;
}
@end
