//
//  YCMathChainRequestAgent.m
//  YCMathNetWorkDemo
//
//  Created by jiChengSun on 15/4/27.
//  Copyright (c) 2015年 jichengsun. All rights reserved.
//

#import "YCMathChainRequestAgent.h"

@interface YCMathChainRequestAgent()

@property (strong, nonatomic) NSMutableArray *requestArray;

@end

@implementation YCMathChainRequestAgent
+ (YCMathChainRequestAgent *)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        _requestArray = [NSMutableArray array];
    }
    return self;
}

- (void)addChainRequest:(YCMathChainRequest *)request {
    [_requestArray addObject:request];
}

- (void)removeChainRequest:(YCMathChainRequest *)request {
    [_requestArray removeObject:request];
}
@end
