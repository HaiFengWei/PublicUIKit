//
//  UIButton+PUButton.h
//  PublicUIKit
//
//  Created by Macbook on 2018/5/11.
//  Copyright © 2018年 Ehanghai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ActionBlock)(UIButton *button);

// 定义一个枚举（包含了四种类型的button）
typedef NS_ENUM(NSUInteger, ButtonEdgeInsetsStyle) {
    ButtonEdgeInsetsStyleTop,    // image在上，label在下
    ButtonEdgeInsetsStyleLeft,   // image在左，label在右
    ButtonEdgeInsetsStyleBottom, // image在下，label在上
    ButtonEdgeInsetsStyleRight   // image在右，label在左
};


@interface UIButton (PUButton)
/**
 block按钮回调

 @param controlEvent 触发事件
 @param action       方法回调
 */
- (void)handleControlEvent:(UIControlEvents)controlEvent withBlock:(ActionBlock)action;

/**
 设置button的titleLabel和imageView的布局样式，及间距
 
 @param style titleLabel和imageView的布局样式
 @param space titleLabel和imageView的间距
 */
- (void)layoutButtonWithEdgeInsetsStyle:(ButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;
@end
