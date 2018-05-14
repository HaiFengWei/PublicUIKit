//
//  UISearchBar+PUSearchBar.h
//  PublicUIKit
//
//  Created by Macbook on 2018/5/11.
//  Copyright © 2018年 Ehanghai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISearchBar (PUSearchBar)

/**
 设置字体大小

 @param font 字体大小
 */
- (void)setTextFont:(UIFont *)font;

/**
 设置字体颜色

 @param textColor 字体颜色
 */
- (void)setTextColor:(UIColor *)textColor;

/**
 设置取消按钮文字

 @param title 文字
 */
- (void)setCancelButtonTitle:(NSString *)title;
/**
 设置取消按钮字体大小
 
 @param font 字体大小
 */
- (void)setCancelButtonFont:(UIFont *)font;
@end
