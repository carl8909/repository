//
//  UIScrollView+KFRefreshView.m
//  online-iOS
//
//  Created by wuy on 2021/2/3.
//  Copyright © 2021 深圳市看房网科技有限公司. All rights reserved.
//

#import "UIScrollView+KFRefreshView.h"
#import "UIImage+KFCompression.h"
#import "KFMJImageHelper.h"

@implementation KFRefreshHeader

- (void)prepare
{
    [super prepare];
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    if (state == MJRefreshStateRefreshing) {
        if (self.loading) {
            [self.loading startAnimating];
        }
    } else {
        if (self.loading) {
            [self.loading stopAnimating];
        }
    }
}

@end

@implementation KFRefreshFooter

- (void)prepare
{
    [super prepare];

    self.mj_h = 44;
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = KFHexColor(0x888888);
    label.font = [UIFont systemFontOfSize:16];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.label = label;
    
    UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self addSubview:loading];
    self.loading = loading;
}

- (void)placeSubviews
{
    [super placeSubviews];
    self.label.frame = self.bounds;
    self.loading.center = CGPointMake(self.mj_w * 0.5 - 55, self.mj_h * 0.5);
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    switch (state) {
        case MJRefreshStateIdle:
            if (self.idleTitle.length > 0) {
                self.label.text = self.idleTitle;
            } else {
                self.label.text = @"上拉加载...";
            }
            [self.loading stopAnimating];
            break;
        case MJRefreshStatePulling:
            [self.loading stopAnimating];
            self.label.text = @"正在载入...";
            break;
        case MJRefreshStateRefreshing:
            self.label.text = @"正在载入...";
            [self.loading startAnimating];
            break;
        case MJRefreshStateNoMoreData:
            self.label.text = @"无更多数据";
            [self.loading startAnimating];
            break;
        default:
            break;
    }
}

@end


@implementation UIScrollView (KFRefreshView)

//下拉刷新
- (void)configDownPullRefreshViewWithHandler:(void (^)(void))handler
{
    KFRefreshHeader *header = [KFRefreshHeader headerWithRefreshingBlock:handler];
    NSArray *gifArray = [[KFMJImageHelper shared] getMjImageArray];
    UIImage *image = [gifArray firstObject];
    [header setImages:@[image]
             forState:MJRefreshStatePulling];
    [header setImages:@[image]
             forState:MJRefreshStateIdle];
    [header setImages:gifArray
             duration:1.3
             forState:MJRefreshStateRefreshing];
    header.stateLabel.hidden = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    self.mj_header = header;
}

//上拉加载更多
- (void)configInfiniteFooterViewWithHandler:(void (^)(void))handler
{
    KFRefreshFooter *footer = [KFRefreshFooter footerWithRefreshingBlock:handler];
    self.mj_footer = footer;
    self.mj_footer.hidden = YES;
}

- (void)stopAnimation
{
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
}

@end
