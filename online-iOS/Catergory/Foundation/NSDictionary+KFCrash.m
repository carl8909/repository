//
//  NSDictionary+KFCrash.m
//  online-iOS
//
//  Created by wuy on 2021/2/7.
//  Copyright © 2021 深圳市看房网科技有限公司. All rights reserved.
//

#import "NSDictionary+KFCrash.h"
#import <objc/runtime.h>

@implementation NSDictionary (KFCrash)

+ (void)load {
    
    Method system_dictionaryWithObjectsForKeysCountMethod = class_getClassMethod(self, @selector(dictionaryWithObjects:forKeys:count:));
    Method my_DictionaryWithObjectsForKeysCountMethod = class_getClassMethod(self, @selector(kfw_dictionaryWithObjects:forKeys:count:));
    method_exchangeImplementations(system_dictionaryWithObjectsForKeysCountMethod, my_DictionaryWithObjectsForKeysCountMethod);
    
    Method system_setObjectForKey = class_getInstanceMethod(NSClassFromString(@"__NSDictionaryM"), @selector(setObject:forKey:));
    Method my_setObjectForKey = class_getInstanceMethod(self, @selector(kfw_setObject:forKey:));
    method_exchangeImplementations(system_setObjectForKey, my_setObjectForKey);
}

/**
 *  构造字典 保护方法
 */
+ (instancetype)kfw_dictionaryWithObjects:(id  _Nonnull const [])objects forKeys:(id<NSCopying>  _Nonnull const [])keys count:(NSUInteger)cnt {
    
    NSMutableArray *valuesArray = [NSMutableArray array];
    NSMutableArray *keysArray = [NSMutableArray array];
    
    for (int i = 0; i < cnt; i++) {
        id value = objects[i];
        id key = keys[i];
        
        if ((value && key) && (![value isKindOfClass:[NSNull class]] && ![key isKindOfClass:[NSNull class]])) {
            [valuesArray addObject:value];
            [keysArray addObject:key];
        }
    }
    
    return [self dictionaryWithObjects:valuesArray forKeys:keysArray];
}

- (void)kfw_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    
    if (anObject && aKey) {
        [self kfw_setObject:anObject forKey:aKey];
    }
}

@end
