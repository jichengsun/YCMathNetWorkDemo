//
//  YCMathNetWorkConfig.h
//  YCMathNetWorkDemo
//
//  Created by jiChengSun on 15/4/27.
//  Copyright (c) 2015年 jichengsun. All rights reserved.
//
/**
 *  @author jichengsun, 15-04-27 13:04:13
 *
 *  单例
 *  配置网络请求参数 统一设置网络请求的CDN地址和服务器地址
 *
 *  baseURL :基本URL 非CDN资源服务器URL
 *  cdnURL  :CDN资源服务器URL
 *  urlFiltersArr :URL过滤器数组
 *  cacheDirPathFiltersArr缓存过滤器数组
 */

#import <Foundation/Foundation.h>
@class YCMathBaseRequest;

///统一为网络请求添加一些参数 或者修改路径
@protocol YCUrlFilterProtocol <NSObject>
- (NSString *)filterUrl:(NSString *)originUrl withRequest:(YCMathBaseRequest *)request;
@end

@protocol YCCacheDirPathFilterProtocol <NSObject>
- (NSString *)filterCacheDirPath:(NSString *)originPath withRequest:(YCMathBaseRequest *)request;
@end


@interface YCMathNetWorkConfig : NSObject

@property (nonatomic,strong) NSString *baseURL;
@property (nonatomic,strong) NSString *cdnURL;
@property (nonatomic,strong,readonly) NSArray *urlFiltersArr;

@property (nonatomic,strong,readonly) NSArray *cacheDirPathFiltersArr;

+(YCMathNetWorkConfig*)shareInstance;

@end
