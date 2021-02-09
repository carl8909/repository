//
//  KFBasicServices.h
//  online-iOS
//
//  Created by wuy on 2021/2/3.
//  Copyright © 2021 深圳市看房网科技有限公司. All rights reserved.
//
/// 基础服务

#import <Foundation/Foundation.h>
@class KFAppDelegate;

#import <UMShare/UMShare.h>

// 引入 JPush 功能所需头文件
#import "JPUSHService.h"
// iOS10 注册 APNs 所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface KFBasicServices : NSObject

/**
 网络配置
 */
+ (void)networkConfiguration;

/**
 分享配置
 */
+ (void)shareConfiguration;

/**
 Bugly配置
 */
+ (void)buglyConfiguration;

/**
 极光推送配置
 */
+ (void)jPushNotification:(KFAppDelegate *)appDelegate launchOptions:(NSDictionary *)launchOptions;

@end

NS_ASSUME_NONNULL_END
