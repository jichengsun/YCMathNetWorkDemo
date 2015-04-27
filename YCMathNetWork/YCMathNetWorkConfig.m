//
//  YCMathNetWorkConfig.m
//  YCMathNetWorkDemo
//
//  Created by jiChengSun on 15/4/27.
//  Copyright (c) 2015年 jichengsun. All rights reserved.
//

#import "YCMathNetWorkConfig.h"

@implementation YCMathNetWorkConfig{

    NSMutableArray *_urlFiltersArr;
    NSMutableArray *_cacheDirPathFiltersArr;

}
+(YCMathNetWorkConfig*)shareInstance{

    static YCMathNetWorkConfig *_configInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
    
        _configInstance = [[self alloc] init];
        
    });
    
    return _configInstance;

}

-(id)init{

    self = [super init];
    
    if (self) {
        _urlFiltersArr = [NSMutableArray array];
        _cacheDirPathFiltersArr = [NSMutableArray array];
    }
    
    return self;

}

-(NSArray*)urlFiltersArr{

    return [_urlFiltersArr copy];

}

-(NSArray*)cacheDirPathFiltersArr{

    return [_cacheDirPathFiltersArr copy];

}
@end
