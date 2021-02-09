//
//  NSMutableDictionary+KFOperation.h
//  online-iOS
//
//  Created by wuy on 2021/2/4.
//  Copyright © 2021 深圳市看房网科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableDictionary (KFOperation)

- (void)kf_setObject:(id)object forKey:(NSString *)key;

- (void)kf_setValue:(id)value forKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
