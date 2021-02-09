//
//  NSString+KFRegular.m
//  online-iOS
//
//  Created by wuy on 2021/2/7.
//  Copyright © 2021 深圳市看房网科技有限公司. All rights reserved.
//

#import "NSString+KFRegular.h"

@implementation NSString (KFRegular)

// 手机号码(1开头的11位数)
- (BOOL)availablePhone
{
    NSString * MOBILE = @"^1([0-9])\\d{9}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:self];
}

// 邮箱
- (BOOL)availableEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

// 密码(同时包含数字和字符(6——12位))
- (BOOL)availablePassword
{
    NSString *passWordRegex = @"^[0-9A-Za-z]{6,12}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:self];
}

@end
