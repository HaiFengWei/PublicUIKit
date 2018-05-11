//
//  PUCommon.h
//  PublicUIKit
//
//  Created by Macbook on 2018/5/11.
//  Copyright © 2018年 Ehanghai. All rights reserved.
//

#ifndef PUCommon_h
#define PUCommon_h

// 常用宏定义

#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

// 屏幕尺寸
#define kPUScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kPUScreenHeight [UIScreen mainScreen].bounds.size.height
// 是否是iPhone
#define kPUIS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
// 控件按比例宽高宏定义
#ifdef kPUIS_IPHONE // iPhone比例
#define kPUScreenWidthRatio  (kPUScreenWidth / 375.f)
#define kPUScreenHeightRatio (kPUScreenHeight / 667.f)
#else  // iPad比例
#define kPUScreenWidthRatio  (kPUScreenWidth / 1024.0)
#define kPUScreenHeightRatio (kPUScreenHeight / 768.0)
#endif
// 是否是iPhone X
//判断是否iPhone X
#define kPUIS_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
// iPhone X适配宏
// status bar height.
#define  kPUStatusBarHeight      (kPUIS_iPhoneX ? 44.f : 20.f)
// Navigation bar height.
#define  kPUNavigationBarHeight  44.f
// Tabbar height.
#define  kPUTabbarHeight  (kPUIS_iPhoneX ? (49.f+34.f) : 49.f)
// Tabbar safe bottom margin.
#define  kPUTabbarSafeBottomMargin   (kPUIS_iPhoneX ? 34.f : 0.f)
// Status bar & navigation bar height.
#define  kPUStatusBarAndNavigationBarHeight  (kPUIS_iPhoneX ? 88.f : 64.f)

/****** 调试日志 ******/
#ifdef DEBUG
#define PULOG(...) printf(" %s\n",[[NSString stringWithFormat:__VA_ARGS__]UTF8String]);
#define PULOG_CURRENT_METHOD NSLog(@"%@-%@", NSStringFromClass([self class]), NSStringFromSelector(_cmd))
#else
#define PULOG(...) ;
#define PULOG_CURRENT_METHOD ;
#endif



#endif /* PUCommon_h */
