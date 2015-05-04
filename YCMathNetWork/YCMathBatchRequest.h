//
//  YCMathBatchRequest.h
//  YCMathNetWorkDemo
//
//  Created by jiChengSun on 15/4/27.
//  Copyright (c) 2015年 jichengsun. All rights reserved.
//
/**
 *  @author jichengsun, 15-04-28 10:04:53
 *
 *  用于方便地发送批量的网络请求
 */

#import <Foundation/Foundation.h>
#import "YCMathRequest.h"

@class YCMathBatchRequest;

@protocol YCMathBatchRequestDelegate <NSObject>

- (void)batchRequestFinished:(YCMathBatchRequest *)batchRequest;

- (void)batchRequestFailed:(YCMathBatchRequest *)batchRequest;
@end

@interface YCMathBatchRequest : NSObject
@property (strong, nonatomic, readonly) NSArray *requestArray;

@property (weak, nonatomic) id<YCMathBatchRequestDelegate> delegate;

@property (nonatomic, copy) void (^successCompletionBlock)(YCMathBatchRequest *);

@property (nonatomic, copy) void (^failureCompletionBlock)(YCMathBatchRequest *);

@property (nonatomic) NSInteger tag;

@property (nonatomic, strong) NSMutableArray *requestAccessories;

- (id)initWithRequestArray:(NSArray *)requestArray;

- (void)start;

- (void)stop;

/// block回调
- (void)startWithCompletionBlockWithSuccess:(void (^)(YCMathBatchRequest *batchRequest))success
                                    failure:(void (^)(YCMathBatchRequest *batchRequest))failure;

- (void)setCompletionBlockWithSuccess:(void (^)(YCMathBatchRequest *batchRequest))success
                              failure:(void (^)(YCMathBatchRequest *batchRequest))failure;

/// 把block置nil来打破循环引用
- (void)clearCompletionBlock;

/// Request Accessory，可以hook Request的start和stop
- (void)addAccessory:(id<YCMathRequestAccessory>)accessory;

/// 是否当前的数据从缓存获得
- (BOOL)isDataFromCache;
@end
