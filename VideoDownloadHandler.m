//
//  VideoDownloadHandler.m
//  YCMathNetWorkDemo
//
//  Created by jiChengSun on 15/4/28.
//  Copyright (c) 2015年 jichengsun. All rights reserved.
//

#import "VideoDownloadHandler.h"

@implementation VideoDownloadHandler{

    NSString *_videoURL;
    NSString *_fileName;
    
    AFDownloadProgressBlock _downloadProgressBlock;

}
-(id)initWithVideoURL:(NSString*)videoURL fileName:(NSString *)fileName progressBlock:(AFDownloadProgressBlock)progressBlock{

    self = [super init];
    
    if (self) {
        
        _videoURL = videoURL;
        _fileName = fileName;
        _downloadProgressBlock = progressBlock;
    }

    return self;
}

-(NSString*)requestUrl{
//正式开发时 在此格式化URL 扩展NSString 类添加URL格式化方法
    return _videoURL;

}

-(BOOL)useCDN{

    return NO;
}

-(NSString*)resumableDownloadPath{

    NSString *libPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *cachePath = [libPath stringByAppendingPathComponent:@"Caches"];
    NSString *filePath = [cachePath stringByAppendingPathComponent:_fileName];
    
    NSLog(@"filePath====%@",filePath);
    
    return filePath;

}
-(AFDownloadProgressBlock)resumableDownloadProgressBlock{

    return _downloadProgressBlock;

}
@end
