//
//  KFHomeApi.m
//  online-iOS
//
//  Created by wuy on 2021/2/4.
//  Copyright © 2021 深圳市看房网科技有限公司. All rights reserved.
//

#import "KFHomeApi.h"

@implementation KFHomeApi

- (NSString *)requestUrl {
    
    return @"/index/qfangtanClick";
}

- (id)requestArgument {
    
    if (self.homeId) {
        
        [self.arguments kf_setValue:self.homeId forKey:@"id"];
    }
    return self.arguments;
}

// 接口缓存(180 秒)
- (NSInteger)cacheTimeInSeconds {
    
    return 60 * 3;
}

@end
