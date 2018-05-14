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
@end
