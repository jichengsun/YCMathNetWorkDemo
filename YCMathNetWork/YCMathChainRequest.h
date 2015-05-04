//
//  YCMathChainRequest.h
//  YCMathNetWorkDemo
//
//  Created by jiChengSun on 15/4/27.
//  Copyright (c) 2015年 jichengsun. All rights reserved.
//
/**
 *  @author jichengsun, 15-04-28 10:04:52
 *
 *  用于管理有相互依赖的网络请求 
 */
#import <Foundation/Foundation.h>
#import "YCMathBaseRequest.h"

@class YCMathChainRequest;
@protocol YCMathChainRequestDelegate <NSObject>

- (void)chainRequestFinished:(YCMathChainRequest *)chainRequest;

- (void)chainRequestFailed:(YCMathChainRequest *)chainRequest failedBaseRequest:(YCMathBaseRequest*)request;

@end

typedef void (^ChainCallback)(YCMathChainRequest *chainRequest, YCMathBaseRequest *baseRequest);

@interface YCMathChainRequest : NSObject

@property (weak, nonatomic) id<YCMathChainRequestDelegate> delegate;

@property (nonatomic, strong) NSMutableArray *requestAccessories;

/// start chain request
- (void)start;

/// stop chain request
- (void)stop;

- (void)addRequest:(YCMathBaseRequest *)request callback:(ChainCallback)callback;

- (NSArray *)requestArray;

/// Request Accessory，可以hook Request的start和stop
- (void)addAccessory:(id<YCMathRequestAccessory>)accessory;


@end
