//
//  UIColor+PUColor.h
//  PublicUIKit
//
//  Created by Macbook on 2018/5/11.
//  Copyright © 2018年 Ehanghai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (PUColor)

/**
 根据HexString返回颜色数组

 @param color HexString颜色描述
 @return      颜色数组
 */
+ (NSArray *)colorWithHexString:(NSString *)color;


/**
 rgb颜色数字生成颜色对象

 @param rgbValue rgb颜色数字
 @return         颜色对象
 */
+ (UIColor *)colorFromRGB:(int)rgbValue;


/**
 rgb颜色数字生成颜色对象

 @param rgbValue   rgb颜色数字
 @param alphaValue 透明度
 @return           颜色对象
 */
+ (UIColor *)colorFromRGB:(int)rgbValue alphaValue:(float)alphaValue;

@end
