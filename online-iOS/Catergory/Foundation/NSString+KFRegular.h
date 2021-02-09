//
//  NSString+KFRegular.h
//  online-iOS
//
//  Created by wuy on 2021/2/7.
//  Copyright © 2021 深圳市看房网科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (KFRegular)

/**
 手机号码(1开头的11位数)
 */
- (BOOL)availablePhone;

/**
 邮箱
 */
- (BOOL)availableEmail;

/**
 密码(同时包含数字和字符(6——12位))
 */
- (BOOL)availablePassword;

@end

NS_ASSUME_NONNULL_END
