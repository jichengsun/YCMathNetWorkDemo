//
//  ViewController.m
//  YCMathNetWorkDemo
//
//  Created by jiChengSun on 15/4/24.
//  Copyright (c) 2015年 jichengsun. All rights reserved.
//
#define DocumentsDirectory [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) lastObject]
#define MUSICFile [DocumentsDirectory stringByAppendingPathComponent:@"test.mov"]

#import "ViewController.h"
#import "AFDownloadRequestOperation.h"
#import "VideoDownloadHandler.h"
#import "YCMathBaseRequest.h"
#import "YCMathBatchRequest.h"
#import "AFDownloadRequestOperation.h"
#import "AFURLRequestSerialization.h"
#import "GetTopBannerHandler.h"
#import "GetTopicHandler.h"


@interface ViewController (){

   __block AFHTTPRequestOperation *_downLoadOperation;
    BOOL isPause;

}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)pauseAndResume:(id)sender{

    if (isPause) {
        
        [_downLoadOperation resume];
        
        isPause = NO;
        
        [(UIButton*)sender setTitle:@"暂停" forState:UIControlStateNormal];
    }else{
    
        [_downLoadOperation pause];
        
        isPause = YES;
        [(UIButton*)sender setTitle:@"继续" forState:UIControlStateNormal];
    
    }
    

}

-(IBAction)downLoadClick:(id)sender{
    
    GetTopBannerHandler *getBannerHandler = [[GetTopBannerHandler alloc] initWithBannerUrl:@"http://m.yangcong345.com/api/v2/banners"];
    
    if ([getBannerHandler cacheJson]) {
        NSDictionary *json = [getBannerHandler cacheJson];
        
        NSLog(@"getBannerHandler 1cach jsonn===%@",json);
    }
    
    
    [getBannerHandler startWithCompletionBlockWithSuccess:^(YCMathBaseRequest *request) {
        
        //NSLog(@"request.responseJSONObject===%@",request.responseJSONObject);
        //NSLog(@"responseString===%@",request.responseString);
       // NSLog(@"responseHeaders===%@",request.responseHeaders);
        
    } failure:^(YCMathBaseRequest *request) {
        
        NSLog(@"request.statuscode===%lu",(long)request.responseStatusCode);
        
    
    }];
    
    if ([getBannerHandler cacheJson]) {
        NSDictionary *json = [getBannerHandler cacheJson];
        
        NSLog(@"getBannerHandler 1cach jsonn===%@",json);
    }
    
    
    
    GetTopicHandler *getTopicHandler = [[GetTopicHandler alloc] initWithToppicUrl:@"http://m.yangcong345.com/api/v1/chapters"];
    
    if ([getTopicHandler cacheJson]) {
        NSDictionary *json = [getTopicHandler cacheJson];
        
        NSLog(@"getTopicHandler1 cach jsonn===%@",json);
    }
    
    
    [getTopicHandler startWithCompletionBlockWithSuccess:^(YCMathBaseRequest *request) {
        
        //NSLog(@"request.responseJSONObject===%@",request.responseJSONObject);
        //NSLog(@"responseString===%@",request.responseString);
        //NSLog(@"responseHeaders===%@",request.responseHeaders);
        
    } failure:^(YCMathBaseRequest *request) {
        
        //NSLog(@"request.statuscode===%lu",(long)request.responseStatusCode);
        
        
    }];
    
    if ([getTopicHandler cacheJson]) {
        NSDictionary *json = [getTopicHandler cacheJson];
        
        NSLog(@"getTopicHandler cach jsonn===%@",json);
    }
    
    
    
    
    VideoDownloadHandler *a = [[VideoDownloadHandler alloc] initWithVideoURL:@"http://7xaw4c.com2.z0.glb.qiniucdn.com/%E6%95%B4%E5%BC%8F%E7%9A%84%E4%B9%98%E6%B3%95_17a_1_%E5%8D%81%E5%AD%97%E7%9B%B8%E4%B9%98.mp4" fileName:@"1.mp4" progressBlock:nil];
    
    VideoDownloadHandler *b = [[VideoDownloadHandler alloc] initWithVideoURL:@"http://7xaw4c.com2.z0.glb.qiniucdn.com/%E4%B8%80%E5%85%83%E4%B8%80%E6%AC%A1%E6%96%B9%E7%A8%8B_6b_%E6%80%BB%E5%92%8C%E9%97%AE%E9%A2%98.mp4" fileName:@"2.mp4" progressBlock:nil];
    
    VideoDownloadHandler *c = [[VideoDownloadHandler alloc] initWithVideoURL:@"http://7xaw4c.com2.z0.glb.qiniucdn.com/%E4%B8%80%E5%85%83%E4%B8%80%E6%AC%A1%E6%96%B9%E7%A8%8B_6a_2_%E5%B8%A6%E4%BD%A0%E5%9B%B4%E8%A7%82%E5%BA%94%E7%94%A8%E9%A2%98%E4%B8%8B.mp4" fileName:@"3.mp4" progressBlock:nil];
    
    //http://media.animusic2.com.s3.amazonaws.com/Animusic-ResonantChamber480p.mov
    //http://7xaw4c.com2.z0.glb.qiniucdn.com/%E6%9C%89%E7%90%86%E6%95%B0_1b1_%E8%B4%9F%E6%95%B0%E7%9A%84%E5%AE%9A%E4%B9%89%E9%94%99%E8%AF%AF%E9%80%89%E9%A1%B9.mp4
    
    VideoDownloadHandler *d = [[VideoDownloadHandler alloc] initWithVideoURL:@"http://media.animusic2.com.s3.amazonaws.com/Animusic-ResonantChamber480p.mov" fileName:@"4.mov" progressBlock:^(AFDownloadRequestOperation *operation, NSInteger bytesRead, long long totalBytesRead, long long totalBytesExpected, long long totalBytesReadForFile, long long totalBytesExpectedReadForFile) {
        float percentDone = totalBytesReadForFile/(float)totalBytesExpectedReadForFile;
        
        _downLoadOperation = operation;
        self.progressView.progress = percentDone;
        self.progressLabel.text = [NSString stringWithFormat:@"%.0f%%",percentDone*100];
        
        //        self.currentSizeLabel.text = [NSString stringWithFormat:@"CUR : %lli M",totalBytesReadForFile/1024/1024];
        //       self.totalSizeLabel.text = [NSString stringWithFormat:@"TOTAL : %lli M",totalBytesExpectedToReadForFile/1024/1024];
        
        NSLog(@"------%f",percentDone);
       // NSLog(@"Operation%i: bytesRead: %ld", 1, (long)bytesRead);
        //NSLog(@"Operation%i: totalBytesRead: %lld", 1, totalBytesRead);
        //NSLog(@"Operation%i: totalBytesExpected: %lld", 1, totalBytesExpected);
        //NSLog(@"Operation%i: totalBytesReadForFile: %lld", 1, totalBytesReadForFile);
        //NSLog(@"Operation%i: totalBytesExpectedToReadForFile: %lld", 1, totalBytesExpectedReadForFile);
    }];
    
    YCMathBatchRequest *batchRequest = [[YCMathBatchRequest alloc] initWithRequestArray:@[a,b,c,d]];
    
    [batchRequest startWithCompletionBlockWithSuccess:^(YCMathBatchRequest *request){
        
        NSLog(@"succeed");
        NSArray *requests = batchRequest.requestArray;
        VideoDownloadHandler *a = (VideoDownloadHandler *)requests[0];
        VideoDownloadHandler *b = (VideoDownloadHandler *)requests[1];
        VideoDownloadHandler *c = (VideoDownloadHandler *)requests[2];
        VideoDownloadHandler *d = (VideoDownloadHandler *)requests[3];
        // deal with requests result ...
        NSLog(@"%@, %@, %@, %@", a, b, c, d);
    
    } failure:^(YCMathBatchRequest* request){
    
        NSLog(@"failure");
    }];

}
@end
