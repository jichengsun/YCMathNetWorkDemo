//
//  YCMathChainRequestAgent.h
//  YCMathNetWorkDemo
//
//  Created by jiChengSun on 15/4/27.
//  Copyright (c) 2015年 jichengsun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YCMathChainRequest;

@interface YCMathChainRequestAgent : NSObject

+ (YCMathChainRequestAgent *)sharedInstance;

- (void)addChainRequest:(YCMathChainRequest *)request;

- (void)removeChainRequest:(YCMathChainRequest *)request;

@end
