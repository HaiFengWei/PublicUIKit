//
//  UIView+PUView.h
//  PublicUIKit
//
//  Created by Macbook on 2018/5/11.
//  Copyright © 2018年 Ehanghai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (PUView)
#pragma mark -
#pragma mark 设置视图位置尺寸属性
/**
 设置视图原点x值

 @param x 视图原点x值
 */
-(void)setOriginx:(CGFloat)x;

/**
 设置视图原点y值

 @param y 视图原点y值
 */
-(void)setOriginy:(CGFloat)y;

/**
 设置视图宽度

 @param width 视图宽度
 */
-(void)setWidth:(CGFloat)width;
/**
 设置视图高度

 @param height 视图高度
 */
-(void)setHeight:(CGFloat)height;

/**
 设置视图尺寸

 @param size 视图尺寸
 */
-(void)setSize:(CGSize)size;

/**
 设置视图原点

 @param point 视图原点
 */
-(void)setOrigin:(CGPoint)point;

#pragma mark -
#pragma mark 获取视图位置尺寸属性
/**
 获取视图原点x值

 @return 视图原点x值
 */
-(CGFloat)originx;
/**
 获取视图原点y值
 
 @return 视图原点y值
 */
-(CGFloat)originy;
/**
 获取视图宽度
 
 @return 视图宽度
 */
-(CGFloat)width;
/**
 获取视图高度
 
 @return 视图高度
 */
-(CGFloat)height;
/**
 获取视图尺寸
 
 @return 视图尺寸
 */
-(CGSize)size;
/**
 获取视图原点
 
 @return 视图原点
 */
-(CGPoint)origin;

#pragma mark -
#pragma mark 视图操作方法
/**
 将视图生成图片

 @return 图片对象
 */
- (UIImage *)imageFromView;

/**
 将视图转换成相对窗口视图位置尺寸

 @param window 窗口视图
 @return       相对位置尺寸
 */
- (CGRect)convertFrameToWindow:(UIWindow *)window;

/**
 查找属于特定类的成员的第一个子视图（包括此视图）

 @param cls 特定类
 @return    子视图
 */
- (UIView *)descendantOrSelfWithClass:(Class)cls;

/**
 查找属于特定类的成员的第一个父视图（包括此视图）

 @param cls 特定类
 @return    父视图
 */
- (UIView *)ancestorOrSelfWithClass:(Class)cls;

/**
 旋转视图（以锚点为中心点旋转）

 @param centerPoint 锚点相对父视图位置
 @param size        设置视图尺寸
 @param anchorPoint 锚点
 @param rotate      旋转角度
 */
- (void)changImageViewWithCenterPoint:(CGPoint)centerPoint Size:(CGSize)size AnchorPoint:(CGPoint)anchorPoint Rotate:(CGFloat)rotate;

@end
