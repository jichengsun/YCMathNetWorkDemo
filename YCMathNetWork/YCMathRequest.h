//
//  YCMathRequest.h
//  YCMathNetWorkDemo
//
//  Created by jiChengSun on 15/4/27.
//  Copyright (c) 2015年 jichengsun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YCMathBaseRequest.h"

@interface YCMathRequest : YCMathBaseRequest

@property (nonatomic) BOOL ignoreCache;

/// 返回当前缓存的对象
- (id)cacheJson;

/// 是否当前的数据从缓存获得
- (BOOL)isDataFromCache;

/// 返回是否当前缓存需要更新
- (BOOL)isCacheVersionExpired;

/// 强制更新缓存
- (void)startWithoutCache;

/// 手动将其他请求的JsonResponse写入该请求的缓存
- (void)saveJsonResponseToCacheFile:(id)jsonResponse;

/// 子类根据需求 继承覆盖
- (NSInteger)cacheTimeInSeconds;
- (long long)cacheVersion;
- (id)cacheSensitiveData;

@end
