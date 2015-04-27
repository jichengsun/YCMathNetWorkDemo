//
//  YCMathBatchAgent.h
//  YCMathNetWorkDemo
//
//  Created by jiChengSun on 15/4/27.
//  Copyright (c) 2015年 jichengsun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YCMathBatchRequest;

@interface YCMathBatchAgent : NSObject
+ (YCMathBatchAgent *)sharedInstance;

- (void)addBatchRequest:(YCMathBatchRequest *)request;

- (void)removeBatchRequest:(YCMathBatchRequest *)request;
@end
