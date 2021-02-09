//
//  NSNumber+KFDecimalNumber.m
//  online-iOS
//
//  Created by wuy on 2021/2/7.
//  Copyright © 2021 深圳市看房网科技有限公司. All rights reserved.
//

#import "NSNumber+KFDecimalNumber.h"

@implementation NSNumber (KFDecimalNumber)

+ (NSNumber *)kf_numberWithNumber:(NSNumber *)number pointNumber:(NSInteger)pointNum
{
    return [NSNumber kf_numberWithFloat:[number floatValue] pointNumber:pointNum];
}

+ (NSNumber *)kf_numberWithString:(NSString *)string pointNumber:(NSInteger)pointNum
{
    // 判断string是否是整数
    if ([NSNumber isIntNumber:string]) {
        return [NSNumber numberWithInteger:[string integerValue]];
    }
    
    return [NSNumber kf_numberWithFloat:[string floatValue] pointNumber:pointNum];
}

+ (NSNumber *)kf_numberWithFloat:(double)value pointNumber:(NSInteger)pointNum
{
    NSDecimalNumber *number1 = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",value]];
    
    NSDecimalNumber *number2 = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",0.0]];
    
    // NSRoundPlain （四舍五入）   NSRoundDown（只舍不入）
    NSDecimalNumberHandler *handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:pointNum raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    
    NSDecimalNumber *decimalNumber = [number2 decimalNumberByAdding:number1 withBehavior:handler];
    
    return decimalNumber;
}

// 判断一个数是否是整数
+ (BOOL)isIntNumber:(NSString *)string {
    
    // 如果转换成的小数和整数相等，那么传入的数字就是一个整数，否则就是小数
    return [string integerValue] == [string floatValue];
}

@end
