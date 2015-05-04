//
//  GetTopBannerHandler.m
//  YCMathNetWorkDemo
//
//  Created by jiChengSun on 15/4/29.
//  Copyright (c) 2015年 jichengsun. All rights reserved.
//

#import "GetTopBannerHandler.h"

@implementation GetTopBannerHandler{


    NSString *_requestUrl;
}

-(id)initWithBannerUrl:(NSString *)bannerUrl{

    self = [super init];
    
    if (self) {
        
        _requestUrl = bannerUrl;
    }
    
    return self;

}

-(NSString*)requestUrl{
//正式开发时 在此格式化URL 扩展NSString 类添加URL格式化方法
    return _requestUrl;

}

-(NSInteger)cacheTimeInSeconds{

    return 60 * 60 * 24 * 7;

}

@end
