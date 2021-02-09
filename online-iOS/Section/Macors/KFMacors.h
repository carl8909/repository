//
//  KFMacors.h
//  agent-iOS
//
//  Created by Miao on 2021/2/2.
//  Copyright © 2021 深圳市看房网科技有限公司. All rights reserved.
//

#ifndef KFMacors_h
#define KFMacors_h

#pragma mark - 1.Color
// RGB颜色转换（16进制->10进制）
#define KFHexColor(rgbValue)  [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
                                            green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
                                             blue:((float)(rgbValue & 0xFF))/255.0 \
                                            alpha:1.0]

#define KFHexColorAlpha(rgbValue, alphaValue)  [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
                                                             green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
                                                              blue:((float)(rgbValue & 0xFF))/255.0 \
                                                             alpha:alphaValue]


#pragma mark - 2.Frame
// MainScreen Height&Width
#define KFScreenWidth       [[UIScreen mainScreen] bounds].size.width
#define KFScreenHeight      [[UIScreen mainScreen] bounds].size.height
#define KFStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define KFNavBarHeight                (IS_IPHONEX?88.0f:64.0f)
#define KFTabBarHeight                (IS_IPHONEX?83.0f:49.0f)

// CGRect
#define MinX(v)                 CGRectGetMinX((v).frame)
#define MinY(v)                 CGRectGetMinY((v).frame)

#define MidX(v)                 CGRectGetMidX((v).frame)
#define MidY(v)                 CGRectGetMidY((v).frame)

#define MaxX(v)                 CGRectGetMaxX((v).frame)
#define MaxY(v)                 CGRectGetMaxY((v).frame)

// 安全边距
#define KFSafeAreaInsets(view) ({ UIEdgeInsets i; if (@available(iOS 11.0, *)) { i = view.safeAreaInsets; } else { i = UIEdgeInsetsZero; } i; })


// BasicWidth、BasicHeight
#define isiPhone6 (([[UIScreen mainScreen] bounds].size.width>320)&&([[UIScreen mainScreen] bounds].size.width<=375))
#define iPhone6Weight 375.0
#define iPhone6Height 667.0
// 是否异性屏幕
#define isiPhoneX       ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? \
                        ([[UIScreen mainScreen] currentMode].size.height / [[UIScreen mainScreen] currentMode].size.width) > (1334.0 / 750.0) : \
                        NO)

#define KFBasicHeight (1/iPhone6Height*(isiPhone6?iPhone6Height:KFScreenHeight))
#define KFBasicWidth (1/iPhone6Weight*KFScreenWidth)


#pragma mark - 3.线程
#define QF_Dispatch_Async_Main(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}


#pragma mark - 4.Log

#ifndef __OPTIMIZE__

#define NSLog(...) NSLog(__VA_ARGS__)
#define KFLog(fmt,...) printf("class:%s mothd:%s line:%d \ncontent:%s\n",[NSStringFromClass([self class]) UTF8String],[NSStringFromSelector(_cmd) UTF8String], __LINE__, [[NSString stringWithFormat:fmt, ##__VA_ARGS__] UTF8String]);
//#define KFLog(fmt, ...) NSLog(fmt, ##__VA_ARGS__);

#else

#define NSLog(...) {}
#define KFLog(...)

#endif

#pragma mark - 5.Block
#define WEAKSELF typeof(self) __weak weakSelf = self;
#define STRONGSELF typeof(weakSelf) __strong strongSelf = weakSelf;

#ifndef    weakify_self
#if __has_feature(objc_arc)
#define weakify_self autoreleasepool{} __weak __typeof__(self) weakSelf = self;
#else
#define weakify_self autoreleasepool{} __block __typeof__(self) blockSelf = self;
#endif
#endif
#ifndef    strongify_self
#if __has_feature(objc_arc)
#define strongify_self try{} @finally{} __typeof__(weakSelf) self = weakSelf;
#else
#define strongify_self try{} @finally{} __typeof__(blockSelf) self = blockSelf;
#endif
#endif

#endif /* KFMacors_h */
