//
//  NSObject+PUNotNull.h
//  PublicUIKit
//
//  Created by Macbook on 2018/5/11.
//  Copyright © 2018年 Ehanghai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (PUNotNull)

/**
  数据非空判断,字符串数组字典如已初始化,但内容为空,判断为YES

 @return 是否为空
 */
-(BOOL)isNotNull;

/**
 数据内容非空判断,字符串数组字典如已初始化,但内容为空,判断为NO

 @return 是否为空
 */
-(BOOL)isNotEmpty;
@end
