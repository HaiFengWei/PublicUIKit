//
//  NSString+PUString.h
//  PublicUIKit
//
//  Created by Macbook on 2018/5/14.
//  Copyright © 2018年 Ehanghai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (PUString)
#pragma mark -
#pragma mark 时间戳相关
/**
 获取十三位时间戳

 @return 时间戳
 */
+(NSString *)getTimeStamp;

/**
 时间戳转时间
 
 @param tempSpain       时间戳
 @param fromFormat      时间格式
 
 @return 返回格式化之后的字符串
 */
+(NSString *)timeStampTransferTime:(NSString *)tempSpain andTimeFormat:(NSString *)fromFormat;

/**
 将格式化的日期字符串重新格式化 -->转换成时间戳
 
 @param timeStr    格式化的字符串
 @param fromFormat 格式化字符串的格式的格式
 @param toFormat   目标格式
 
 @return 返回时间戳
 */
+(long)timeTransfertimeStampOldTimeStr:(NSString *)timeStr timeFormat:(NSString *)fromFormat toFormat:(NSString *)toFormat;

#pragma mark -
#pragma mark 经纬度相关
/**
 经纬度转度分秒

 @param coordinateString 原始经纬度
 @return                 度分秒经纬度
 */
+(NSString *)stringWithCoordinateString:(NSString *)coordinateString;
@end
