//
//  YCMathBatchAgent.h
//  YCMathNetWorkDemo
//
//  Created by jiChengSun on 15/4/27.
//  Copyright (c) 2015年 jichengsun. All rights reserved.
//
/**
 *  @author jichengsun, 15-04-28 10:04:10
 *
 *  批量网络请求管理类
 */
#import <Foundation/Foundation.h>
@class YCMathBatchRequest;

@interface YCMathBatchAgent : NSObject
+ (YCMathBatchAgent *)sharedInstance;

- (void)addBatchRequest:(YCMathBatchRequest *)request;

- (void)removeBatchRequest:(YCMathBatchRequest *)request;
@end
