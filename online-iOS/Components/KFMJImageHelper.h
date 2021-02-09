//
//  KFMJImageHelper.h
//  online-iOS
//
//  Created by wuy on 2021/2/3.
//  Copyright © 2021 深圳市看房网科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KFMJImageHelper : NSObject

+ (instancetype)shared;

- (NSArray *)getMjImageArray;

@end

NS_ASSUME_NONNULL_END
