//
//  ExpendFile.h
//  PublicUIKit
//
//  Created by Macbook on 2018/5/11.
//  Copyright © 2018年 Ehanghai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExpendFile : NSObject

/**
 根据文件路径获取文件长度
 
 @param filePath 文件路径
 @return 文件长度
 */
+(NSInteger)getFileSizeWithFilePath:(NSString *)filePath;


/**
 转换文件大小单位（@"bytes",@"KB",@"MB",@"GB",@"TB",@"PB", @"EB", @"ZB", @"YB"）

 @param originalSize    原始单位下大小
 @param originalUnit    原始单位
 @param destinationUnit 目标单位
 @return                目标单位下大小
 */
- (NSString *)transOriginalSize:(id)originalSize originalUnit:(NSString *)originalUnit toDestinationUnit:(NSString *)destinationUnit;


/**
  转换文件大小(原始单位为bytes)

 @param value 文件大小
 @return      对应目标打下
 */
- (NSString *)transformedValue:(id)value;

/**
 根据url字符串配置路径
 
 @param urlStr url字符串
 @return       路径
 */
+ (NSString *)getPathStrByUrlStr:(NSString *)urlStr;

/**
 根据url字符串配置路径
 
 @param urlStr url字符串
 @return       路径
 */

/**
 根据url字符串配置路径

 @param urlStr       url字符串
 @param isCreateFile 若没有对应的路径文件则创建一个该路径文件
 @return             文件路径
 */
+ (NSString *)getPathStrByUrlStr:(NSString *)urlStr isCreateFile:(BOOL)isCreateFile;

/**
 为文件增加一个扩展属性，值是字符串
 
 @param path  文件路径
 @param key   拓展键
 @param value 拓展值
 @return      是否拓展成功
 */
+ (BOOL)extendedStringValueWithPath:(NSString *)path key:(NSString *)key value:(NSString *)value;
/**
 读取文件扩展属性，值是字符串
 
 @param path 文件路径
 @param key  拓展键
 @return     拓展值
 */
+ (NSString *)stringValueWithPath:(NSString *)path key:(NSString *)key;
@end
