//
//  NSNumber+KFDecimalNumber.h
//  online-iOS
//
//  Created by wuy on 2021/2/7.
//  Copyright © 2021 深圳市看房网科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSNumber (KFDecimalNumber)

/**
 将Number类型转成number，传入小数点位数(默认不做四舍五入)

 @param number 需要转换的number
 @param pointNum 小数点位数
 */
+ (NSNumber *)kf_numberWithNumber:(NSNumber *)number pointNumber:(NSInteger)pointNum;

/**
 将字符串类型转成number，传入小数点位数(默认不做四舍五入)

 @param string 需要转换的字符串
 @param pointNum 小数点位数
 */
+ (NSNumber *)kf_numberWithString:(NSString *)string pointNumber:(NSInteger)pointNum;

/**
 将浮点型型转成number，传入小数点位数(默认不做四舍五入)

 @param value 需要转换的字符串
 @param pointNum 小数点位数
 */
+ (NSNumber *)kf_numberWithFloat:(double)value pointNumber:(NSInteger)pointNum;

@end

NS_ASSUME_NONNULL_END
