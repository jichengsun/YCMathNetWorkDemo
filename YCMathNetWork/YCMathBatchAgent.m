//
//  YCMathBatchAgent.m
//  YCMathNetWorkDemo
//
//  Created by jiChengSun on 15/4/27.
//  Copyright (c) 2015年 jichengsun. All rights reserved.
//

#import "YCMathBatchAgent.h"
@interface YCMathBatchAgent()

@property (strong, nonatomic) NSMutableArray *requestArray;

@end
@implementation YCMathBatchAgent

+ (YCMathBatchAgent *)sharedInstance {
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

- (void)addBatchRequest:(YCMathBatchRequest *)request {
    [_requestArray addObject:request];
}

- (void)removeBatchRequest:(YCMathBatchRequest *)request {
    [_requestArray removeObject:request];
}

@end
