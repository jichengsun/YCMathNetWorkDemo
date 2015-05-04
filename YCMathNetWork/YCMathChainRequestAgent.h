//
//  YCMathChainRequestAgent.h
//  YCMathNetWorkDemo
//
//  Created by jiChengSun on 15/4/27.
//  Copyright (c) 2015年 jichengsun. All rights reserved.
/**
 *  @author jichengsun, 15-04-28 10:04:03
 *
 *  有相互依赖的网络请求管理类
 */

#import <Foundation/Foundation.h>
@class YCMathChainRequest;

@interface YCMathChainRequestAgent : NSObject

+ (YCMathChainRequestAgent *)sharedInstance;

- (void)addChainRequest:(YCMathChainRequest *)request;

- (void)removeChainRequest:(YCMathChainRequest *)request;

@end
