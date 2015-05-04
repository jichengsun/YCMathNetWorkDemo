//
//  VideoDownloadHandler.h
//  YCMathNetWorkDemo
//
//  Created by jiChengSun on 15/4/28.
//  Copyright (c) 2015年 jichengsun. All rights reserved.
//

#import "YCMathRequest.h"

@interface VideoDownloadHandler : YCMathRequest
-(id)initWithVideoURL:(NSString*)videoURL fileName:(NSString*)fileName progressBlock:(AFDownloadProgressBlock)progressBlock;
@end
