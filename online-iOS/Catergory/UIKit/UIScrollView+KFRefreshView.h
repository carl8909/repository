//
//  UIScrollView+KFRefreshView.h
//  online-iOS
//
//  Created by wuy on 2021/2/3.
//  Copyright © 2021 深圳市看房网科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface KFRefreshHeader : MJRefreshGifHeader

@property (nonatomic, strong) UIActivityIndicatorView *loading;

@end

@interface KFRefreshFooter : MJRefreshBackFooter

@property (nonatomic, strong) UILabel *label;
@property (nonatomic,   copy) NSString *idleTitle;
@property (nonatomic, strong) UIActivityIndicatorView *loading;

@end


@interface UIScrollView (KFRefreshView)

/**
 下拉刷新
 */
- (void)configDownPullRefreshViewWithHandler:(void (^)(void))handler;

/**
 上拉加载更多
 */
- (void)configInfiniteFooterViewWithHandler:(void (^)(void))handler;

@end

NS_ASSUME_NONNULL_END
