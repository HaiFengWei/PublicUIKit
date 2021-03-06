//
//  ExpendFile.m
//  PublicUIKit
//
//  Created by Macbook on 2018/5/11.
//  Copyright © 2018年 Ehanghai. All rights reserved.
//

#import "ExpendFile.h"
#import "PUCommon.h"
#include <sys/xattr.h>
#define Key_FileTotalSize @"Key_FileTotalSize"
@implementation ExpendFile

+ (NSString *)getPathStrByUrlStr:(NSString *)urlStr
{
    // 创建文件管理者
    NSFileManager* fileManager = [NSFileManager defaultManager];
    // 获取文件各个部分
    NSArray* fileComponents = [fileManager componentsToDisplayForPath:urlStr];
    // 获取下载之后的文件名
    NSString* fileName = [fileComponents lastObject];
    // 根据文件名拼接沙盒全路径
    NSString* fileFullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[@"Documents/" stringByAppendingString:fileName]];
    return fileFullPath;
}

+ (NSString *)getPathStrByUrlStr:(NSString *)urlStr isCreateFile:(BOOL)isCreateFile
{
    // 创建文件管理者
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // 获取文件各个部分
    NSArray *fileComponents = [fileManager componentsToDisplayForPath:urlStr];
    // 获取下载之后的文件名
    NSString *fileName = [fileComponents lastObject];
    
    NSString *dirFillPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"Documents"];
    // 根据文件名拼接沙盒全路径
    NSString* fileFullPath = [dirFillPath stringByAppendingPathComponent:fileName];
    
    if (![fileManager fileExistsAtPath:fileFullPath] && isCreateFile) {
        
        BOOL isDir = NO;
        // fileExistsAtPath 判断一个文件或目录是否有效，isDirectory判断是否一个目录
        BOOL existed = [fileManager fileExistsAtPath:dirFillPath isDirectory:&isDir];
        
        if ( !(isDir == YES && existed == YES) ) {
            // 在 Document 目录下创建一个 head 目录
            [fileManager createDirectoryAtPath:dirFillPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        // 如果没有下载文件的话，就创建一个文件。如果有文件的话，则不用重新创建(不然会覆盖掉之前的文件)
        BOOL isSucces =  [fileManager createFileAtPath:fileFullPath contents:nil attributes:nil];
        PULOG(@"isSucces:%d",isSucces);
    }
    return fileFullPath;
}

+(NSInteger)getFileSizeWithFilePath:(NSString *)filePath
{
    // 创建文件管理者
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSDictionary* attributes = [fileManager attributesOfItemAtPath:filePath
                                                             error:nil];
    
    NSInteger fileCurrentSize = [attributes[@"NSFileSize"] integerValue];
    return fileCurrentSize;
}

- (NSString *)transOriginalSize:(id)originalSize originalUnit:(NSString *)originalUnit toDestinationUnit:(NSString *)destinationUnit
{
    
    if (!(originalUnit!=nil && originalUnit!=NULL && (NSNull *)originalUnit!=[NSNull null] && [originalUnit respondsToSelector:@selector(length)] && [(NSString *)originalUnit length]>0) || !(destinationUnit!=nil && destinationUnit!=NULL && (NSNull *)destinationUnit!=[NSNull null] && [destinationUnit respondsToSelector:@selector(length)] && [(NSString *)destinationUnit length]>0)) {
        return nil;
    }
    double convertedValue = [originalSize doubleValue];
    NSInteger originalIndex    = 0;
    NSInteger destinationIndex = 0;
    NSArray *tokens = [NSArray arrayWithObjects:@"bytes",@"KB",@"MB",@"GB",@"TB",@"PB", @"EB", @"ZB", @"YB",nil];
    originalIndex   = [tokens indexOfObject:originalUnit];
    destinationIndex = [tokens indexOfObject:destinationUnit];
    if (originalIndex > destinationIndex) {
        NSInteger marginCount = originalIndex - destinationIndex;
        for (int index = 0; index < marginCount; marginCount++)
        {
           convertedValue /= 1024;
        }
        return [NSString stringWithFormat:@"%4.2f %@",convertedValue, destinationUnit];
    }
    else
    {
        NSInteger marginCount = destinationIndex - originalIndex;
        for (int index = 0; index < marginCount; marginCount++)
        {
            convertedValue *= 1024;
        }
        return [NSString stringWithFormat:@"%4.2f %@",convertedValue, destinationUnit];
    }
}

- (NSString *)transformedValue:(id)value
{
    double convertedValue = [value doubleValue];
    int multiplyFactor = 0;
    
    NSArray *tokens = [NSArray arrayWithObjects:@"bytes",@"KB",@"MB",@"GB",@"TB",@"PB", @"EB", @"ZB", @"YB",nil];
    
    while (convertedValue > 1024) {
        convertedValue /= 1024;
        multiplyFactor++;
    }
    
    return [NSString stringWithFormat:@"%4.2f %@",convertedValue, [tokens objectAtIndex:multiplyFactor]];
}

//为文件增加一个扩展属性
+ (BOOL)extendedStringValueWithPath:(NSString *)path key:(NSString *)key value:(NSString *)stringValue
{
    NSData* value = [stringValue dataUsingEncoding:NSUTF8StringEncoding];
    ssize_t writelen = setxattr([path fileSystemRepresentation],
                                [key UTF8String],
                                [value bytes],
                                [value length],
                                0,
                                0);
    return writelen==0?YES:NO;
}
//读取文件扩展属性
+ (NSString *)stringValueWithPath:(NSString *)path key:(NSString *)key
{
    ssize_t readlen = 1024;
    do {
        char buffer[readlen];
        bzero(buffer, sizeof(buffer));
        size_t leng = sizeof(buffer);
        readlen = getxattr([path fileSystemRepresentation],
                           [key UTF8String],
                           buffer,
                           leng,
                           0,
                           0);
        if (readlen < 0){
            return nil;
        }
        else if (readlen > sizeof(buffer)) {
            continue;
        }else{
            NSData *data = [NSData dataWithBytes:buffer length:readlen];
            NSString* result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            return result;
        }
    } while (YES);
    return nil;
}
@end
