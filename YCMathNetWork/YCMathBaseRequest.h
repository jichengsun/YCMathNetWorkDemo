//
//  YCMathBaseRequest.h
//  YCMathNetWorkDemo
//
//  Created by jiChengSun on 15/4/27.
//  Copyright (c) 2015年 jichengsun. All rights reserved.
//
/**
 *  @author jichengsun, 15-04-27 13:04:29
 *
 *  网络请求Handler基类
 */

#import <Foundation/Foundation.h>
#import "AFDownloadRequestOperation.h"
#import "AFNetworking.h"

typedef NS_ENUM(NSInteger, YCMathRequestMethod){
    
    YCMathRequestMethodGET = 0,
    YCMathRequestMethodPOST,
    YCMathRequestMethodHEAD,
    YCMathRequestMethodPUT,
    YCMathRequestMethodDELETE,
    YCMathRequestMethodPATCH

};

typedef NS_ENUM(NSInteger, YCMathRequestSerializeType){

    YCMathRequestSerializeTypeHTTP = 0,
    YCMathRequestSerializeTypeJSON

};

typedef void (^AFConstructingBlock)(id<AFMultipartFormData> formData);

typedef void (^AFDownloadProgressBlock)(AFDownloadRequestOperation *operation,NSInteger bytesRead,long long totalBytesRead,long long totalBytesExpected,long long totalBytesReadForFile,long long totalBytesExpectedReadForFile);


/******YCMathRequestDelegate********/

@class YCMathBaseRequest;

@protocol YCMathRequestDelegate <NSObject>

-(void)requestFinshed:(YCMathBaseRequest*)request;
-(void)requestFailed:(YCMathBaseRequest*)request;

@optional

-(void)clearRequests;

@end

/******YCMathRequestAccessory********/


@protocol YCMathRequestAccessory <NSObject>


@optional

-(void)requestWillStart:(id)request;

-(void)requestWillStop:(id)request;

-(void)requestStopped:(id)request;

@end

/******YCMathBaseRequest********/

@interface YCMathBaseRequest : NSObject

@property (nonatomic) NSInteger tag;

///用户信息
@property (nonatomic,strong) NSDictionary *userInfo;

@property (nonatomic,strong) AFHTTPRequestOperation *requestOperation;

//网络请求代理
@property (nonatomic,weak) id<YCMathRequestDelegate>delegate;

@property (nonatomic,strong,readonly) NSArray *responseHeaders;

@property (nonatomic,strong,readonly) NSArray *responseString;

@property (nonatomic,strong,readonly) id responseJSONObject;

@property (nonatomic,readonly) NSInteger responseStatusCode;

///block方式回调
@property (nonatomic,copy) void (^successCompletionBlock)(YCMathBaseRequest *request);

///block方式回调
@property (nonatomic,copy) void (^failureCompleteionBlock)(YCMathBaseRequest *request);

@property (nonatomic,strong) NSMutableArray *requestAccessories;


/// append self to request queue
- (void)start;

/// remove self from request queue
- (void)stop;

- (BOOL)isExecuting;

/// block回调
- (void)startWithCompletionBlockWithSuccess:(void (^)(YCMathBaseRequest *request))success
                                    failure:(void (^)(YCMathBaseRequest *request))failure;

///block方式回调
- (void)setCompletionBlockWithSuccess:(void (^)(YCMathBaseRequest *request))success
                              failure:(void (^)(YCMathBaseRequest *request))failure;

/// 把block置nil来打破循环引用
- (void)clearCompletionBlock;

/// Request Accessory，可以hook Request的start和stop
- (void)addAccessory:(id<YCMathRequestAccessory>)accessory;

/// 以下方法由子类选择继承覆盖默认值


/// 请求成功的回调
- (void)requestCompleteFilter;

/// 请求失败的回调
- (void)requestFailedFilter;

/// 请求的URL
- (NSString *)requestUrl;

/// 请求的CdnURL
- (NSString *)cdnUrl;

/// 请求的BaseURL
- (NSString *)baseUrl;

/// 请求的连接超时时间，默认为60秒
- (NSTimeInterval)requestTimeoutInterval;

/// 请求的参数列表
- (id)requestArgument;

/// 用于在cache结果，计算cache文件名时，忽略掉一些指定的参数
- (id)cacheFileNameFilterForRequestArgument:(id)argument;

/// Http请求的方法 GET/POST/HEAD/DELETE/PATCH/PUT
- (YCMathRequestMethod)requestMethod;

/// 请求的SerializerType
- (YCMathRequestSerializeType)requestSerializerType;

/// 请求的Server用户名和密码
- (NSArray *)requestAuthorizationHeaderFieldArray;

/// 在HTTP报头添加的自定义参数
- (NSDictionary *)requestHeaderFieldValueDictionary;

/// 构建自定义的UrlRequest，
/// 若这个方法返回非nil对象，会忽略requestUrl, requestArgument, requestMethod, requestSerializerType
- (NSURLRequest *)buildCustomUrlRequest;

/// 是否使用CDN的host地址
- (BOOL)useCDN;

/// 用于检查JSON是否合法的对象
- (id)jsonValidator;

/// 用于检查Status Code是否正常的方法
- (BOOL)statusCodeValidator;

/// 当POST的内容带有文件等富文本时使用
- (AFConstructingBlock)constructingBodyBlock;

/// 当需要断点续传时，指定续传的地址
- (NSString *)resumableDownloadPath;

/// 当需要断点续传时，获得下载进度的回调
- (AFDownloadProgressBlock)resumableDownloadProgressBlock;

@end
