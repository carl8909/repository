//
//  NSObject+KFObserverHelper.m
//  online-iOS
//
//  Created by wuy on 2021/2/7.
//  Copyright © 2021 深圳市看房网科技有限公司. All rights reserved.
//

#import "NSObject+KFObserverHelper.h"
#import <objc/message.h>

@interface KFObserverHelper : NSObject

@property (nonatomic, unsafe_unretained) id target;
@property (nonatomic, unsafe_unretained) id observer;
@property (nonatomic, strong) NSString *keyPath;
@property (nonatomic, weak) KFObserverHelper *factor;

@end

@implementation KFObserverHelper

- (void)dealloc {
    if ( _factor ) {
        KFLog(@"remove observer : %@",_keyPath);
        [_target removeObserver:_observer forKeyPath:_keyPath];
    }
}

@end


@implementation NSObject (KFObserverHelper)

- (void)qf_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath {
    
    [self addObserver:observer forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:nil];
    
    KFObserverHelper *helper = [KFObserverHelper new];
    KFObserverHelper *sub = [KFObserverHelper new];
    
    sub.target = helper.target = self;
    sub.observer = helper.observer = observer;
    sub.keyPath = helper.keyPath = keyPath;
    helper.factor = sub;
    sub.factor = helper;
    
    const char *helpeKey = [[keyPath mutableCopy] UTF8String];
    const char *subKey = [[keyPath mutableCopy] UTF8String];
    // 关联属性  举例 self 和 helper 关联 当self释放的时候 helper释放 即可释放self的kvo 观察者和sub关联 当观察者释放的时候 调用sub的移除同样也能删除self的kvo   factor是同一个对象 是为防止多次移除导致的崩溃
    objc_setAssociatedObject(self, helpeKey, helper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(observer, subKey, sub, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
