//
//  KFMJImageHelper.m
//  online-iOS
//
//  Created by wuy on 2021/2/3.
//  Copyright © 2021 深圳市看房网科技有限公司. All rights reserved.
//

#define K_IMAGE_COUNT   89

#import "KFMJImageHelper.h"

@interface KFMJImageHelper ()

@property (nonatomic, strong) NSMutableArray *mjArray;

@end

@implementation KFMJImageHelper

+ (instancetype)shared
{
    static KFMJImageHelper *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[KFMJImageHelper alloc] init];
    });
    return _sharedClient;
}

- (NSArray *)getMjImageArray
{
    if (self.mjArray.count == 0) {
        CGFloat zoom = 2.0;
        for (int i = 0; i < K_IMAGE_COUNT; i++) {
            NSString *str = [self getImageNumber:i];
            UIImage *image = [UIImage imageNamed:str];
            [image setAccessibilityIdentifier:str];
            //压缩图片尺寸
            image = [UIImage imageWithImage:image
                               scaledToSize:CGSizeMake(image.size.width / zoom, image.size.height / zoom)];
            [self.mjArray addObject:image];
        }
    }
    return self.mjArray;
}

- (NSString *)getImageNumber:(NSInteger)number
{
    NSString *str = [NSString stringWithFormat:@"icon_refresh_animation2_000"];
    if (number < 10) {
        str = [NSString stringWithFormat:@"icon_refresh_animation2_0000"];
    }
    str = [str stringByAppendingString:[NSString stringWithFormat:@"%ld", (long)number]];
    return str;
}

@end
