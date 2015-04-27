//
//  YCMathNetPrivate.h
//  YCMathNetWorkDemo
//
//  Created by jiChengSun on 15/4/27.
//  Copyright (c) 2015年 jichengsun. All rights reserved.
//
/**
 *  @author jichengsun, 15-04-27 15:04:31
 *
 *  定义了一些工具类类方法 
 *  定义了网络请求基类的 类别方法
 */

#import <Foundation/Foundation.h>
#import "YCMathBaseRequest.h"
#import "YCMathBatchRequest.h"
#import "YCMathChainRequest.h"

FOUNDATION_EXPORT void YCLog(NSString *format, ...) NS_FORMAT_FUNCTION(1,2);

@interface YCMathNetPrivate : NSObject

///验证json格式
+ (BOOL)checkJson:(id)json withValidator:(id)validatorJson;
///格式化http请求url 追加参数
+ (NSString *)urlStringWithOriginUrlString:(NSString *)originUrlString
                          appendParameters:(NSDictionary *)parameters;

///增加不备份参数 路径
+ (void)addDoNotBackupAttribute:(NSString *)path;

///md5加密
+ (NSString *)md5StringFromString:(NSString *)string;

///获取应用版本
+ (NSString *)appVersionString;

@end

//YCMathBaseRequest 类别

@interface YCMathBaseRequest (RequestAccessory)

- (void)toggleAccessoriesWillStartCallBack;
- (void)toggleAccessoriesWillStopCallBack;
- (void)toggleAccessoriesDidStopCallBack;

@end


@interface YCMathBatchRequest (RequestAccessory)

- (void)toggleAccessoriesWillStartCallBack;
- (void)toggleAccessoriesWillStopCallBack;
- (void)toggleAccessoriesDidStopCallBack;

@end


@interface YCMathChainRequest (RequestAccessory)

- (void)toggleAccessoriesWillStartCallBack;
- (void)toggleAccessoriesWillStopCallBack;
- (void)toggleAccessoriesDidStopCallBack;

@end
