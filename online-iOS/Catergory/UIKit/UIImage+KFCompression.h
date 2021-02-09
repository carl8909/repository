//
//  UIImage+KFCompression.h
//  online-iOS
//
//  Created by wuy on 2021/2/3.
//  Copyright © 2021 深圳市看房网科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (KFCompression)

/**
 图片尺寸压缩
 
 @param image 压缩前图片
 @param newSize 目标大小
 @return 压缩后图片
 */
+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;

@end

NS_ASSUME_NONNULL_END
