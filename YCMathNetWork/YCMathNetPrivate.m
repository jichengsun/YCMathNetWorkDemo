//
//  YCMathNetPrivate.m
//  YCMathNetWorkDemo
//
//  Created by jiChengSun on 15/4/27.
//  Copyright (c) 2015年 jichengsun. All rights reserved.
//

#import "YCMathNetPrivate.h"
#import <CommonCrypto/CommonDigest.h>
#import "YCMathBaseRequest.h"
#import "YCMathBatchRequest.h"
#import "YCMathChainRequest.h"

void YCLog(NSString *format, ...) {
#ifdef DEBUG
    va_list argptr;
    va_start(argptr, format);
    NSLogv(format, argptr);
    va_end(argptr);
#endif
}

@implementation YCMathNetPrivate

+ (BOOL)checkJson:(id)json withValidator:(id)validatorJson {
    if ([json isKindOfClass:[NSDictionary class]] &&
        [validatorJson isKindOfClass:[NSDictionary class]]) {
        NSDictionary * dict = json;
        NSDictionary * validator = validatorJson;
        BOOL result = YES;
        NSEnumerator * enumerator = [validator keyEnumerator];
        NSString * key;
        while ((key = [enumerator nextObject]) != nil) {
            id value = dict[key];
            id format = validator[key];
            if ([value isKindOfClass:[NSDictionary class]]
                || [value isKindOfClass:[NSArray class]]) {
                return [self checkJson:value withValidator:format];
            } else {
                if ([value isKindOfClass:format] == NO &&
                    [value isKindOfClass:[NSNull class]] == NO) {
                    result = NO;
                    break;
                }
            }
        }
        return result;
    } else if ([json isKindOfClass:[NSArray class]] &&
               [validatorJson isKindOfClass:[NSArray class]]) {
        NSArray * validatorArray = (NSArray *)validatorJson;
        if (validatorArray.count > 0) {
            NSArray * array = json;
            NSDictionary * validator = validatorJson[0];
            for (id item in array) {
                BOOL result = [self checkJson:item withValidator:validator];
                if (!result) {
                    return NO;
                }
            }
        }
        return YES;
    } else if ([json isKindOfClass:validatorJson]) {
        return YES;
    } else {
        return NO;
    }
}

+ (NSString *)urlParametersStringFromParameters:(NSDictionary *)parameters {
    NSMutableString *urlParametersString = [[NSMutableString alloc] initWithString:@""];
    if (parameters && parameters.count > 0) {
        for (NSString *key in parameters) {
            NSString *value = parameters[key];
            value = [NSString stringWithFormat:@"%@",value];
            value = [self urlEncode:value];
            [urlParametersString appendFormat:@"&%@=%@", key, value];
        }
    }
    return urlParametersString;
}

+ (NSString *)urlStringWithOriginUrlString:(NSString *)originUrlString appendParameters:(NSDictionary *)parameters {
    NSString *filteredUrl = originUrlString;
    NSString *paraUrlString = [self urlParametersStringFromParameters:parameters];
    if (paraUrlString && paraUrlString.length > 0) {
        if ([originUrlString rangeOfString:@"?"].location != NSNotFound) {
            filteredUrl = [filteredUrl stringByAppendingString:paraUrlString];
        } else {
            filteredUrl = [filteredUrl stringByAppendingFormat:@"?%@", [paraUrlString substringFromIndex:1]];
        }
        return filteredUrl;
    } else {
        return originUrlString;
    }
}


+ (NSString*)urlEncode:(NSString*)str {
    
    NSString *result = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)str, CFSTR("."), CFSTR(":/?#[]@!$&'()*+,;="), kCFStringEncodingUTF8);
    return result;
}

+ (void)addDoNotBackupAttribute:(NSString *)path {
    NSURL *url = [NSURL fileURLWithPath:path];
    NSError *error = nil;
    [url setResourceValue:[NSNumber numberWithBool:YES] forKey:NSURLIsExcludedFromBackupKey error:&error];
    if (error) {
        YCLog(@"error to set do not backup attribute, error = %@", error);
    }
}

+ (NSString *)md5StringFromString:(NSString *)string {
    if(string == nil || [string length] == 0)
        return nil;
    
    const char *value = [string UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return outputString;
}

+ (NSString *)appVersionString {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

@end

@implementation YCMathBaseRequest (RequestAccessory)

- (void)toggleAccessoriesWillStartCallBack {
    for (id<YCMathRequestAccessory> accessory in self.requestAccessories) {
        if ([accessory respondsToSelector:@selector(requestWillStart:)]) {
            [accessory requestWillStart:self];
        }
    }
}

- (void)toggleAccessoriesWillStopCallBack {
    for (id<YCMathRequestAccessory> accessory in self.requestAccessories) {
        if ([accessory respondsToSelector:@selector(requestWillStop:)]) {
            [accessory requestWillStop:self];
        }
    }
}

- (void)toggleAccessoriesDidStopCallBack {
    for (id<YCMathRequestAccessory> accessory in self.requestAccessories) {
        if ([accessory respondsToSelector:@selector(requestStopped:)]) {
            [accessory requestStopped:self];
        }
    }
}

@end

@implementation YCMathBatchRequest (RequestAccessory)

- (void)toggleAccessoriesWillStartCallBack {
    for (id<YCMathRequestAccessory> accessory in self.requestAccessories) {
        if ([accessory respondsToSelector:@selector(requestWillStart:)]) {
            [accessory requestWillStart:self];
        }
    }
}

- (void)toggleAccessoriesWillStopCallBack {
    for (id<YCMathRequestAccessory> accessory in self.requestAccessories) {
        if ([accessory respondsToSelector:@selector(requestWillStop:)]) {
            [accessory requestWillStop:self];
        }
    }
}

- (void)toggleAccessoriesDidStopCallBack {
    for (id<YCMathRequestAccessory> accessory in self.requestAccessories) {
        if ([accessory respondsToSelector:@selector(requestStopped:)]) {
            [accessory requestStopped:self];
        }
    }
}

@end

@implementation YCMathChainRequest (RequestAccessory)

- (void)toggleAccessoriesWillStartCallBack {
    for (id<YCMathRequestAccessory> accessory in self.requestAccessories) {
        if ([accessory respondsToSelector:@selector(requestWillStart:)]) {
            [accessory requestWillStart:self];
        }
    }
}

- (void)toggleAccessoriesWillStopCallBack {
    for (id<YCMathRequestAccessory> accessory in self.requestAccessories) {
        if ([accessory respondsToSelector:@selector(requestWillStop:)]) {
            [accessory requestWillStop:self];
        }
    }
}

- (void)toggleAccessoriesDidStopCallBack {
    for (id<YCMathRequestAccessory> accessory in self.requestAccessories) {
        if ([accessory respondsToSelector:@selector(requestStopped:)]) {
            [accessory requestStopped:self];
        }
    }
}

@end
