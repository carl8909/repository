//
//  NSMutableDictionary+KFOperation.m
//  online-iOS
//
//  Created by wuy on 2021/2/4.
//  Copyright © 2021 深圳市看房网科技有限公司. All rights reserved.
//

#import "NSMutableDictionary+KFOperation.h"

@implementation NSMutableDictionary (KFOperation)

- (void)kf_setObject:(id)object forKey:(NSString *)key {
    
    if (object && [object isKindOfClass:[NSString class]] && [(NSString *)object length] && key.length) {
        [self setObject:object forKey:key];
    } else if (object && ![object isKindOfClass:[NSNull class]] && key.length) {
        [self setObject:object forKey:key];
    }
}

- (void)kf_setValue:(id)value forKey:(NSString *)key {
    
    if (value && [value isKindOfClass:[NSString class]] && [(NSString *)value length] && key.length) {
        [self setValue:value forKey:key];
    } else if (value && ![value isKindOfClass:[NSNull class]] && key.length) {
        [self setValue:value forKey:key];
    }
}

@end
