//
//  UIBarButtonItem+PUBarButtonItem.m
//  PublicUIKit
//
//  Created by Macbook on 2018/5/11.
//  Copyright © 2018年 Ehanghai. All rights reserved.
//

#import "UIBarButtonItem+PUBarButtonItem.h"

@implementation UIBarButtonItem (PUBarButtonItem)
+ (UIBarButtonItem *)creatWithSize:(CGSize)size normalImgName:(NSString *)normalImgName clickImgName:(NSString *)clickImgName target:(nullable id)target action:(nullable SEL)action
{
    UIButton *button = [UIButton new];
    if (size.width == 0 && size.height == 0) {
        [button sizeToFit];
    }else {
        button.frame = CGRectMake(0, 0, size.width, size.height);
    }
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:normalImgName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:clickImgName] forState:UIControlStateHighlighted];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return barButtonItem;
}
@end
