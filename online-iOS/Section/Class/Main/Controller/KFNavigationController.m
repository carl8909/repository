//
//  KFNavigationController.m
//  online-iOS
//
//  Created by wuy on 2021/2/3.
//  Copyright © 2021 深圳市看房网科技有限公司. All rights reserved.
//

#import "KFNavigationController.h"

@interface KFNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation KFNavigationController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.allowGestures = YES;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setBackGestureStart];
    
    UINavigationBar *navigationBar = self.navigationBar;
    [navigationBar setTintColor:KFHexColor(0x333333)];
    [navigationBar setBarTintColor:[UIColor whiteColor]];
    
    UIBarButtonItem *barButtonItem = [UIBarButtonItem appearance];
    [barButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:16], NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15], NSFontAttributeName, nil] forState:UIControlStateNormal];
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15], NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    navigationBar.translucent = NO;
}

// 设置返回手势的状态
- (void)setBackGestureStart
{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = YES;
        //解决ViewControllers里面设定了leftBarButtonItem导致手势返回失效的问题
        self.interactivePopGestureRecognizer.delegate = self;
    }
}

// 设置是否可以手势返回标准
- (void)setAllowGestures:(BOOL)allowGestures
{
    if (_allowGestures != allowGestures) {
        _allowGestures = allowGestures;
        if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.interactivePopGestureRecognizer.delegate = nil;
            self.interactivePopGestureRecognizer.enabled = _allowGestures;
            self.interactivePopGestureRecognizer.delegate = self;
        }
        return;
    }
}

- (UIViewController *)childViewControllerForStatusBarStyle
{
    return self.topViewController;
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isKindOfClass:[UISlider class]]) {
        return NO;
    }
    return YES;
}


//UIScreenEdgePanGestureRecognizer 不与其他的手势同时触发
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class]; //是否为滑动手势
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    //首页不能使用手势返回，防止出栈异常
    if (self.viewControllers.count == 1) {
        return NO;
    }else {
        return YES;
    }
}

//同时接受多个手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{

    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceivePress:(UIPress *)press
{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return NO;
}

@end
