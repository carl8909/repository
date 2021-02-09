//
//  UIView+KFFrame.h
//  online-iOS
//
//  Created by wuy on 2021/2/7.
//  Copyright © 2021 深圳市看房网科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (KFFrame)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
//
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
//
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, readonly) CGFloat right;
@property (nonatomic, readonly) CGFloat bottom;

@property (nonatomic,assign) CGFloat centerX;
@property (nonatomic,assign) CGFloat centerY;

@end

NS_ASSUME_NONNULL_END
