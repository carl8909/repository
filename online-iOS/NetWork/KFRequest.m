//
//  KFRequest.m
//  online-iOS
//
//  Created by wuy on 2021/2/4.
//  Copyright © 2021 深圳市看房网科技有限公司. All rights reserved.
//

#import "KFRequest.h"

@interface KFRequest ()

@end

@implementation KFRequest

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        _arguments = [NSMutableDictionary dictionary];
        
        // 添加公共参数
    }
    return self;
}

// 请求时间
- (NSTimeInterval)requestTimeoutInterval {
    
    return 20.0;
}

// 请求方式
- (YTKRequestMethod)requestMethod {
    
   return YTKRequestMethodPOST;
}

// 请求参数
- (id)requestArgument {
   
    return _arguments;
}

// 请求头
- (NSDictionary *)requestHeaderFieldValueDictionary {
    
    return _arguments;
}

// 接口请求
- (void)requestWithCompletionBlockWithCompletion:(KFRequestCompletionBlock)completion
{
    [super startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        
        id jsonObject = request.responseJSONObject;
        
        if (!KF_VALIDATE_REQUEST(jsonObject)) {
            
        }
        
        if (completion) {
            
            completion(jsonObject, YES);
        }
        
    } failure:^(__kindof YTKBaseRequest *request) {
        
        id jsonObject = request.responseJSONObject;
        
        if (completion) {
            
            completion(jsonObject, NO);
        }
    }];
}

@end
