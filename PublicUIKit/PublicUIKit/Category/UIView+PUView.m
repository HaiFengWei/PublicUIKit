//
//  UIView+PUView.m
//  PublicUIKit
//
//  Created by Macbook on 2018/5/11.
//  Copyright © 2018年 Ehanghai. All rights reserved.
//

#import "UIView+PUView.h"

@implementation UIView (PUView)
-(void)setOriginx:(CGFloat)x{
    CGRect rect=self.frame;
    rect.origin.x=x;
    self.frame=rect;
}

-(void)setOriginy:(CGFloat)y{
    CGRect rect=self.frame;
    rect.origin.y=y;
    self.frame=rect;
}

-(void)setWidth:(CGFloat)width{
    CGRect rect=self.frame;
    rect.size.width=width;
    self.frame=rect;
}

-(void)setHeight:(CGFloat)height{
    CGRect rect=self.frame;
    rect.size.height=height;
    self.frame=rect;
}

-(void)setSize:(CGSize)size{
    CGRect rect=self.frame;
    rect.size=size;
    self.frame=rect;
}

-(void)setOrigin:(CGPoint)point{
    CGRect rect=self.frame;
    rect.origin=point;
    self.frame=rect;
}

-(CGFloat)originx{
    return self.frame.origin.x;
}

-(CGFloat)originy{
    return self.frame.origin.y;
}

-(CGFloat)width{
    return self.frame.size.width;
}
-(CGFloat)height{
    return self.frame.size.height;
}

-(CGSize)size{
    return self.frame.size;
}

-(CGPoint)origin{
    return self.frame.origin;
}

- (UIImage *)imageFromView {
    CGSize size = self.size;
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    image = [UIImage imageWithCGImage:image.CGImage scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
    UIGraphicsEndImageContext();
    return image;
}

- (CGRect)convertFrameToWindow:(UIWindow *)window {
    UIView *superView = [self superview];
    CGRect frameInSuperView = [self frame];
    while (superView && (superView != window)) {
        if ([superView superview]) {
            frameInSuperView = [superView.superview convertRect:frameInSuperView fromView:superView];
        }
        superView = [superView superview];
    }
    return frameInSuperView;
}

- (UIView *)descendantOrSelfWithClass:(Class)cls {
    if ([self isKindOfClass:cls])
        return self;
    
    for (UIView *child in self.subviews) {
        UIView *it = [child descendantOrSelfWithClass:cls];
        if (it)
            return it;
    }
    
    return nil;
}

- (UIView *)ancestorOrSelfWithClass:(Class)cls {
    if ([self isKindOfClass:cls]) {
        return self;
    } else if (self.superview) {
        return [self.superview ancestorOrSelfWithClass:cls];
    } else {
        return nil;
    }
}

- (void)changImageViewWithCenterPoint:(CGPoint)centerPoint Size:(CGSize)size AnchorPoint:(CGPoint)anchorPoint Rotate:(CGFloat)rotate
{
    // 将视图复位
    self.transform             = CGAffineTransformMakeRotation(0);
    // 设置视图frame
    CGFloat tempX              = centerPoint.x - size.width*anchorPoint.x;
    CGFloat tempY              = centerPoint.y - size.height*anchorPoint.y;
    
    self.frame                 = CGRectMake(tempX, tempY, size.width, size.height);
    self.layer.anchorPoint     = anchorPoint;
    // 设置视图选择角度
    self.transform             = CGAffineTransformMakeRotation(rotate/180*M_PI);
}
@end
