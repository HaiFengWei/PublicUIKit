//
//  NSString+PUString.m
//  PublicUIKit
//
//  Created by Macbook on 2018/5/14.
//  Copyright © 2018年 Ehanghai. All rights reserved.
//

#import "NSString+PUString.h"

@implementation NSString (PUString)

#pragma mark -
#pragma mark 时间相关
+(NSString *)getTimeStamp
{
    NSDate *senddate = [NSDate date];
    NSString *timeStamp = [NSString stringWithFormat:@"%ld", (long)[senddate timeIntervalSince1970]];
    return timeStamp;
}

+(NSString *)timeStampTransferTime:(NSString *)tempSpain andTimeFormat:(NSString *)fromFormat
{
    long long createTime;
    if (tempSpain.length > 10) {
        createTime = [tempSpain longLongValue]/1000;
    }
    else{
        createTime = [tempSpain longLongValue];
    }
    
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:createTime];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:fromFormat];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    
    return currentDateStr;
}

+(long)timeTransfertimeStampOldTimeStr:(NSString *)timeStr timeFormat:(NSString *)fromFormat toFormat:(NSString *)toFormat
{
    /*
     timeStr : 2016年08月08日 21时28分00秒
     timeFormat: yyyy年MM月dd日 HH时mm分ss秒
     toFormat: yyyy-MM-dd HH:mm:ss
     */
    
    long timeStamp;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:fromFormat];
    
    NSDate *f = [formatter dateFromString:timeStr];
    [formatter setDateFormat:toFormat];
    
    timeStamp = (long)[f timeIntervalSince1970]*1000;
    
    return timeStamp;
}

#pragma mark -
#pragma mark 经纬度相关
+(NSString *)stringWithCoordinateString:(NSString *)coordinateString
{
    /** 将经度或纬度整数部分提取出来 */
    int latNumber = [coordinateString intValue];
    
    /** 取出小数点后面两位(为转化成'分'做准备) */
    NSArray *array = [coordinateString componentsSeparatedByString:@"."];
    /** 小数点后面部分 */
    NSString *lastCompnetString = [array lastObject];
    
    /** 拼接字字符串(将字符串转化为0.xxxx形式) */
    NSString *str1 = [NSString stringWithFormat:@"0.%@", lastCompnetString];
    
    /** 将字符串转换成float类型以便计算 */
    float minuteNum = [str1 floatValue];
    
    /** 将小数点后数字转化为'分'(minuteNum * 60) */
    float minuteNum1 = minuteNum * 60;
    
    /** 将转化后的float类型转化为字符串类型 */
    NSString *latStr = [NSString stringWithFormat:@"%f", minuteNum1];
    
    /** 取整数部分即为纬度或经度'分' */
    int latMinute = [latStr intValue];
    
    /** 取出小数点后面两位(为转化成'秒'做准备)*/
    
    NSArray *array1 = [latStr componentsSeparatedByString:@"."];
    /** 小数点后面部分 */
    NSString *lastCompnetString1 = [array1 lastObject];
    
    /** 拼接字字符串(将字符串转化为0.xxxx形式) */
    NSString *strMiao = [NSString stringWithFormat:@"0.%@", lastCompnetString1];
    
    /** 将字符串转换成float类型以便计算 */
    float miaoNum = [strMiao floatValue];
    
    /** 将小数点后数字转化为'秒'(miaoNum * 60) */
    float miaoNum1 = miaoNum * 60;
    
    /** 将转化后的float类型转化为字符串类型 */
    NSString *miaoStr = [NSString stringWithFormat:@"%f", miaoNum1];
    
    /** 取整数部分即为纬度或经度'秒' */
    int latMiao = [miaoStr intValue];
    
    /** 将经度或纬度字符串合并为(xx°xx')形式 */
    NSString *string = @"";
    if ((latMinute<10) && (latMiao <0)) {
        string = [NSString stringWithFormat:@"%d°%02d′%02d″", latNumber, latMinute,latMiao];
    }
    else{
        string = [NSString stringWithFormat:@"%d°%02d′%02d″", latNumber, latMinute,latMiao];
    }
    
    return string;
}

@end
