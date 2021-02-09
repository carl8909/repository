//
//  NSArray+KFCrash.m
//  online-iOS
//
//  Created by wuy on 2021/2/7.
//  Copyright © 2021 深圳市看房网科技有限公司. All rights reserved.
//

#import "NSArray+KFCrash.h"
#import <objc/runtime.h>

@implementation NSArray (KFCrash)

+ (void)load {
    
    Method systemMethod1 = class_getInstanceMethod(NSClassFromString(@"__NSArrayI"), @selector(objectAtIndexedSubscript:));
    Method my_Method1 = class_getInstanceMethod(self, @selector(kf_objectAtIndexedSubscript:));
    method_exchangeImplementations(systemMethod1, my_Method1);
    
    Method system_objectAtIndexMethod = class_getInstanceMethod(NSClassFromString(@"__NSArrayI"), @selector(objectAtIndex:));
    Method my_objectAtIndexMethod = class_getInstanceMethod(self, @selector(kf_objectAtIndex:));
    method_exchangeImplementations(system_objectAtIndexMethod, my_objectAtIndexMethod);
    
    Method system_objectAtIndexedSubscriptMethod = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(objectAtIndexedSubscript:));
    Method my_objectAtIndexedSubscriptMethod = class_getInstanceMethod(self, @selector(kf_mutableArrayObjectAtIndexedSubscript:));
    method_exchangeImplementations(system_objectAtIndexedSubscriptMethod, my_objectAtIndexedSubscriptMethod);
    
    Method system_addObjectMethod = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(addObject:));
    Method my_addObjectMethod = class_getInstanceMethod(self, @selector(kf_addObject:));
    method_exchangeImplementations(system_addObjectMethod, my_addObjectMethod);
    
    Method system_insertObjectAtIndexMethod = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(insertObject:atIndex:));
    Method my_insertObjectAtIndexMethod = class_getInstanceMethod(self, @selector(kf_insertObject:atIndex:));
    method_exchangeImplementations(system_insertObjectAtIndexMethod, my_insertObjectAtIndexMethod);
    
    Method system_removeObjectAtIndexMethod = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(removeObjectAtIndex:));
    Method my_removeObjectAtIndexMethod = class_getInstanceMethod(self, @selector(kf_removeObjectAtIndex:));
    method_exchangeImplementations(system_removeObjectAtIndexMethod, my_removeObjectAtIndexMethod);
}

/**
 @[] 字面量初始化调用方法
 
 @param objects 对象
 @param cnt 数组个数
 @return 数组
 */
+ (instancetype)kf_arrayWithObjects:(id  _Nonnull const [])objects count:(NSUInteger)cnt {
    
    NSMutableArray *objectArray = [NSMutableArray array];
    
    for (int i = 0; i < cnt; i++) {
        id object = objects[i];
        if (object && ![object isKindOfClass:[NSNull class]]) {
            [objectArray addObject:object];
        }
    }
    
    return [NSArray arrayWithArray:objectArray];
}

/**
 数组添加一个对象
 */
- (void)kf_addObject:(id)anObject {
    
    if (!anObject) {
        KFLog(@"%s 添加对象为空", __func__);
        return;
    }
    [self kf_addObject:anObject];
}

/**
 数组插入一个对象
 
 @param anObject 对象
 @param index 待插入的下标
 */
- (void)kf_insertObject:(id)anObject atIndex:(NSUInteger)index {
    
    if (!anObject) {
        KFLog(@"%s 添加对象为空", __func__);
        return;
    }
    if (index > self.count) {
        // 插入的下标为 self.count 时不会crash
        KFLog(@"%s 数组越界", __func__);
        return;
    }
    
    [self kf_insertObject:anObject atIndex:index];
}

/**
 根据下标移除某个对象
 
 @param index 需要移除的下标
 */
- (void)kf_removeObjectAtIndex:(NSUInteger)index {
    
    if (index >= self.count) {
        KFLog(@"%s 数组越界", __func__);
        return;
    }
    
    [self kf_removeObjectAtIndex:index];
}

/**
 通过 index 获取对象
 
 @param index 数组下标
 */
- (id)kf_objectAtIndex:(NSUInteger)index {
    
    if (index >= self.count) {
        KFLog(@"%s 数组越界", __func__);
        return [self lastObject];
    }
    
    return [self kf_objectAtIndex:index];
}

/**
 @[] 形式获取数组对象
 
 @param idx 数组下标
 */
- (id)kf_objectAtIndexedSubscript:(NSUInteger)idx {
    
    if (idx >= self.count) {
        KFLog(@"%s 数组越界", __func__);
        return nil;
    }
    
    return [self objectAtIndex:idx];
}

/**
 @[] 形式获取可变数组对象
 
 @param idx 数组下标
 */
- (id)kf_mutableArrayObjectAtIndexedSubscript:(NSUInteger)idx {
    
    if (idx >= self.count) return nil;
    
    return [self objectAtIndex:idx];
}

@end
