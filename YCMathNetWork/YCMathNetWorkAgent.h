//
//  YCMathNetWorkAgent.h
//  YCMathNetWorkDemo
//
//  Created by jiChengSun on 15/4/27.
//  Copyright (c) 2015年 jichengsun. All rights reserved.
//
/**
 *  @author jichengsun, 15-04-27 15:04:32
 *
 *  网络请求管理类 根据request和config 格式化请求
 */

#import <Foundation/Foundation.h>
@class YCMathBaseRequest;
@class YCMathNetPrivate;

@interface YCMathNetWorkAgent : NSObject

+ (YCMathNetWorkAgent *)sharedInstance;

- (void)addRequest:(YCMathBaseRequest *)request;

- (void)cancelRequest:(YCMathBaseRequest *)request;

- (void)cancelAllRequests;

/// 根据request和networkConfig构建url
- (NSString *)buildRequestUrl:(YCMathBaseRequest *)request;

@end
