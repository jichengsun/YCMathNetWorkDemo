//
//  YCMathBatchRequest.m
//  YCMathNetWorkDemo
//
//  Created by jiChengSun on 15/4/27.
//  Copyright (c) 2015年 jichengsun. All rights reserved.
//

#import "YCMathBatchRequest.h"
#import "YCMathNetPrivate.h"
#import "YCMathBatchAgent.h"

@interface YCMathBatchRequest() <YCMathRequestDelegate>

@property (nonatomic) NSInteger finishedCount;

@end

@implementation YCMathBatchRequest

- (id)initWithRequestArray:(NSArray *)requestArray {
    self = [super init];
    if (self) {
        _requestArray = [requestArray copy];
        _finishedCount = 0;
        for (YCMathRequest * req in _requestArray) {
            if (![req isKindOfClass:[YCMathRequest class]]) {
                YCLog(@"Error, request item must be YTKRequest instance.");
                return nil;
            }
        }
    }
    return self;
}

- (void)start {
    if (_finishedCount > 0) {
        YCLog(@"Error! Batch request has already started.");
        return;
    }
    [[YCMathBatchAgent sharedInstance] addBatchRequest:self];
    [self toggleAccessoriesWillStartCallBack];
    for (YCMathRequest * req in _requestArray) {
        req.delegate = self;
        [req start];
    }
}

- (void)stop {
    [self toggleAccessoriesWillStopCallBack];
    _delegate = nil;
    [self clearRequest];
    [self toggleAccessoriesDidStopCallBack];
    [[YCMathBatchAgent sharedInstance] removeBatchRequest:self];
}

- (void)startWithCompletionBlockWithSuccess:(void (^)(YCMathBatchRequest *batchRequest))success
                                    failure:(void (^)(YCMathBatchRequest *batchRequest))failure {
    [self setCompletionBlockWithSuccess:success failure:failure];
    [self start];
}

- (void)setCompletionBlockWithSuccess:(void (^)(YCMathBatchRequest *batchRequest))success
                              failure:(void (^)(YCMathBatchRequest *batchRequest))failure {
    self.successCompletionBlock = success;
    self.failureCompletionBlock = failure;
}

- (void)clearCompletionBlock {
    // nil out to break the retain cycle.
    self.successCompletionBlock = nil;
    self.failureCompletionBlock = nil;
}

- (BOOL)isDataFromCache {
    BOOL result = YES;
    for (YCMathRequest *request in _requestArray) {
        if (!request.isDataFromCache) {
            result = NO;
        }
    }
    return result;
}


- (void)dealloc {
    [self clearRequest];
}

#pragma mark - Network Request Delegate

- (void)requestFinshed:(YCMathRequest *)request {
    _finishedCount++;
    if (_finishedCount == _requestArray.count) {
        [self toggleAccessoriesWillStopCallBack];
        if ([_delegate respondsToSelector:@selector(batchRequestFinished:)]) {
            [_delegate batchRequestFinished:self];
        }
        if (_successCompletionBlock) {
            _successCompletionBlock(self);
        }
        [self clearCompletionBlock];
        [self toggleAccessoriesDidStopCallBack];
    }
}

- (void)requestFailed:(YCMathRequest *)request {
    [self toggleAccessoriesWillStopCallBack];
    [self clearRequest];
    if ([_delegate respondsToSelector:@selector(batchRequestFailed:)]) {
        [_delegate batchRequestFailed:self];
    }
    if (_failureCompletionBlock) {
        _failureCompletionBlock(self);
    }
    [self clearCompletionBlock];
    [self toggleAccessoriesDidStopCallBack];
    [[YCMathBatchAgent sharedInstance] removeBatchRequest:self];
}

- (void)clearRequest {
    for (YCMathRequest * req in _requestArray) {
        [req stop];
    }
    [self clearCompletionBlock];
}

#pragma mark - Request Accessoies

- (void)addAccessory:(id<YCMathRequestAccessory>)accessory {
    if (!self.requestAccessories) {
        self.requestAccessories = [NSMutableArray array];
    }
    [self.requestAccessories addObject:accessory];
}
@end
