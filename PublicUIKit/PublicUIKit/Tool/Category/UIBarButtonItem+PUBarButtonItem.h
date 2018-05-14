//
//  UIBarButtonItem+PUBarButtonItem.h
//  PublicUIKit
//
//  Created by Macbook on 2018/5/11.
//  Copyright © 2018年 Ehanghai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (PUBarButtonItem)

/**
 快速创建UIBarButtonItem

 @param size          按钮尺寸（传入CGSizeZero则自适应）
 @param normalImgName 正常状态图片名
 @param clickImgName  高亮状态图片名
 @param target        按钮监听者
 @param action        监听方法
 @return              UIBarButtonItem对象
 */
+ (UIBarButtonItem *)creatWithSize:(CGSize)size normalImgName:(NSString *)normalImgName clickImgName:(NSString *)clickImgName target:(nullable id)target action:(nullable SEL)action;
@end
