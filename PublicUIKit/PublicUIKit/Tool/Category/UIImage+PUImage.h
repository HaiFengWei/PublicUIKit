//
//  UIImage+PUImage.h
//  PublicUIKit
//
//  Created by Macbook on 2018/5/11.
//  Copyright © 2018年 Ehanghai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (PUImage)

/**
 根据颜色生成纯色图片

 @param color 颜色
 @return      图片对象
 */
+ (UIImage *)imageWithColor:(UIColor *)color;


/**
 压缩图片使之宽度等于屏幕宽（图片宽大于屏幕宽时）或高度等于屏幕高

 @param originImg 原图片
 @return          压缩图
 */
+ (UIImage *)simpleImage:(UIImage *)originImg;


/**
 合并图片

 @param baseImg     底部图片
 @param topImage    上层图片
 @param baseImgSize 底部图片尺寸
 @param topImgRect  上层图片位置
 @return            合并后的图片
 */
+ (UIImage *)addImage:(UIImage *)baseImg topImage:(UIImage *)topImage baseImgSize:(CGSize)baseImgSize topImgRect:(CGRect)topImgRect;
@end
