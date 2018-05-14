//
//  PUService.m
//  PublicUIKit
//
//  Created by Macbook on 2018/5/11.
//  Copyright © 2018年 Ehanghai. All rights reserved.
//

#import "PUService.h"
#import "NSObject+PUNotNull.h"

#import "PUCommon.h"

#define kUrlStr @""
#define kNetworkErrorMsg @"请求超时或网络未连接"
#define kAppStoreLinkUrl @""

@interface AFHTTPSessionManager (Singleton)

+ (instancetype)sharedManager;

@end

@implementation AFHTTPSessionManager (Singleton)

+ (instancetype)sharedManager{
    
    static AFHTTPSessionManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.requestSerializer.timeoutInterval = 30.f; //设置超时时间
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/json",@"text/plain",@"text/javascript",nil];
        [manager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Content-Encoding"];

    });
    return manager;
}

@end

@interface PUService ()

@end

@implementation PUService

- (instancetype)init{
    
    self = [super init];
    if(self){
        _manager = [AFHTTPSessionManager sharedManager];
        self.urlStr = kUrlStr;
    }
    return self;
}

-(void)addParamByKey:(NSString *)key value:(id)value{
    
    if (!_params)
    {
        _params = [NSMutableDictionary new];
    }
    if (key == nil || value == nil) {
        return;
    }
    [_params setObject:value forKey:key];
}

- (NSString *)generateURL{
    
    NSMutableString *url = [NSMutableString string];
    if (_urlStr) {
        [url appendString:_urlStr];
    }
    if (_handler) {
        [url appendFormat:@"/%@",_handler];
    }
    if (_method) {
        [url appendFormat:@"/%@",_method];
    }
    return url;
}

- (NSString *)description{
    
    NSString *urlStr = [self generateURL];
    NSURL *url = [NSURL URLWithString:urlStr relativeToURL:[NSURL URLWithString:kUrlStr]];
    urlStr = url.absoluteString;
    NSMutableArray *arr = [NSMutableArray new];
    for(NSString *key in [_params allKeys]){
        NSString *str = [key stringByAppendingFormat:@"=%@",[_params[key] isNotEmpty]?_params[key]:@""];
        [arr addObject:str];
    }
    NSString *params = [arr componentsJoinedByString:@"&"];
    if(params){
        urlStr = [urlStr stringByAppendingFormat:@"?%@",params];
    }
    return urlStr;
}

- (NSURLSessionDataTask *)request:(BlockHandle)finish{
//    [self parameterEncrypted];
    NSLog(@"网络请求:%@",[self description]);
  NSURLSessionDataTask *dataTask = [self.manager POST:[self generateURL] parameters:self.params progress:^(NSProgress * _Nonnull uploadProgress) {
        // 下载进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError *error;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
        if (responseObject)
        {
            finish([dataDic[@"error_code"] integerValue],dataDic);
        }
        else
        {
            finish(1,@{@"reason":@"请求失败"});
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            // 请求超时
            finish(-1000,error);
        }
    }];
    
    return dataTask;
}

+ (void)cancelAllRequest
{
    [[AFHTTPSessionManager sharedManager].operationQueue cancelAllOperations];
}

- (NSURLSessionDataTask *)get:(BlockHandle)finish{
    
    NSLog(@"网络请求:\n%@",[self description]);
    
   NSURLSessionDataTask *dataTask =  [self.manager GET:[self generateURL] parameters:self.params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError *error;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
        if (responseObject)
        {
            finish([dataDic[@"error_code"] integerValue],dataDic);
        }
        else
        {
            finish(1,@{@"reason":@"请求失败"});
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            // 请求超时
            finish(-1000,error);
        }
    }];
    return dataTask;
}

- (void)checkVersion:(BlockHandle)finish{
    
    [self.manager POST:kAppStoreLinkUrl parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            // 请求超时
            finish(-1000,error);
        }
    }];
}

//参数加密
//- (void)parameterEncrypted{
//
//    NSMutableString *signStr = [NSMutableString string];
//
//    //获取13位时间戳
//    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
//    NSString *timestamp = [NSString stringWithFormat:@"%.0f000",timeInterval];
//
//    NSArray *keyArr = self.params.allKeys;
//    //按字母升序排列
//    NSArray *afterSortedArr = [keyArr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
//        NSComparisonResult result = [obj1 compare:obj2];
//        return result==NSOrderedDescending;
//    }];
//
//    NSMutableString *paramerStr = [NSMutableString string];
//    [afterSortedArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        id value = self.params[obj];
//        [paramerStr appendString:[obj stringByAppendingFormat:@"%@",value]];
//    }];
//
//    if ([[(MemberInfo *)[SCAppCache storeObjectForKey:ObjectKeyMemberInfo] secret] isNotEmpty]) {
//
//        NSString *secret = [(MemberInfo *)[SCAppCache storeObjectForKey:ObjectKeyMemberInfo] secret];
//        [signStr appendFormat:@"%@%@%@%@",secret,paramerStr,timestamp,secret];
//    }else{
//
//        [signStr appendFormat:@"%@%@",paramerStr,timestamp];
//    }
//
//    NSString *MD5Str = [signStr md5HexDigest];
//    [self addParamByKey:@"sign" value:MD5Str];
//    [self addParamByKey:@"timestamp" value:timestamp];
//}




@end
