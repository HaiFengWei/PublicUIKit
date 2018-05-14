//
//  PUService.h
//  PublicUIKit
//
//  Created by Macbook on 2018/5/11.
//  Copyright © 2018年 Ehanghai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface PUService : NSObject
/**
 *  网络请求数据回调block
 *
 *  @param status 请求结果状态
 *  @param data   服务器响应数据源
 */
typedef void(^BlockHandle) (NSInteger status,id data);
/**
 上传或者下载进度回调Block

 @param progress 上传或者下载进度
 */
typedef void (^ _Nullable Progress)(NSProgress * _Nullable progress);


@property (nonatomic, copy) NSString *urlStr;  //服务部署地址
@property (nonatomic, copy) NSString *handler; //处理器名
@property (nonatomic, copy) NSString *method;  //函数名
@property(readonly,nonatomic,strong) NSMutableDictionary *params;   //传递参数


@property(readonly,nonatomic,strong) AFHTTPSessionManager *manager;

/**
 *  为网络请求添加参数
 *
 *  @param key   参数名
 *  @param value 参数值
 */
- (void)addParamByKey:(NSString *)key value:(id)value;

/**
 发起POST网络请求并回调服务器响应结果

 @param finish 回调函数
 @return       NSURLSessionDataTask对象，用来取消请求
 */
- (NSURLSessionDataTask *)request:(BlockHandle)finish;

/**
 发起GET网络请求并回调服务器响应结果

 @param finish 回调函数
 @return       NSURLSessionDataTask对象，用来取消请求
 */
- (NSURLSessionDataTask *)get:(BlockHandle)finish;

/**
 发起网络请求获取AppStore上版本号信息

 @param finish 回调函数
 */
- (void)checkVersion:(BlockHandle)finish;

/**
 *  生成完整URL路径,子类可重载本方法自定义URL拼接规则
 *
 *  @return 完整URL路径
 */
- (NSString *)generateURL;

//取消所有的网络请求
+ (void)cancelAllRequest;


///**
// *  封装POST图片上传(单张图片)
// *
// *  @param URLString  上传接口
// *  @param parameters 上传参数
// *  @param img        上传图片
// *  @param imageName  自定义的图片名称（全部用字母写，不能出现汉字）
// *  @param fileName   由后台指定的图片名称
// *  @param progress   上传进度
// *  @param success    成功的回调方法
// *  @param failure    失败的回调方法
// */
//- (void)UpLoadWithPOST:(NSString *)URLString parameters:(NSDictionary *)parameters image:(UIImage *)img imageName:(NSString *)imageName fileName:(NSString *)fileName progress:(Progress)progress success:(Success)success failure:(Failure)failure;
//
///**
// *  封装POST图片上传(多张图片) // 可扩展成多个别的数据上传如:mp3等
// *
// *  @param URLString  请求的链接
// *  @param parameters 请求的参数
// *  @param picArray   存放图片数组
// *  @param progress   进度的回调
// *  @param success    发送成功的回调
// *  @param failure    发送失败的回调
// */
//- (void)UpLoadWithPOST:(NSString *)URLString parameters:(NSDictionary *)parameters andPicArray:(NSArray *)picArray progress:(Progress)progress success:(Success)success failure:(Failure)failure;

@end
