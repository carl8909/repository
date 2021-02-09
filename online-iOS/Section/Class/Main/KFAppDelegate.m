//
//  AppDelegate.m
//  online-iOS
//
//  Created by wuy on 2021/2/2.
//  Copyright © 2021 深圳市看房网科技有限公司. All rights reserved.
//

#import "KFAppDelegate.h"
#import "KFTabBarController.h"
#import "KFBasicServices.h"

@interface KFAppDelegate ()<JPUSHRegisterDelegate>

@end

@implementation KFAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    KFTabBarController *tabbar = [[KFTabBarController alloc] init];
    self.window.rootViewController = tabbar;
    [self.window makeKeyAndVisible];
    
    [self initConfiguration:launchOptions];
    
    // 接收APNS消息(App状态为未运行,如果launchOptions包含UIApplicationLaunchOptionsRemoteNotificationKey 表示用户点击 apns通知导致 app 被启动运行；如果不含有对应键值则表示 App 不是因点击 apn 而被启动，可能为直接点击 icon 被启动或其他)
    NSDictionary *notiInfo = [launchOptions objectForKey: UIApplicationLaunchOptionsRemoteNotificationKey];
    KFLog(@"通知内容 : %@",notiInfo);
    
    return YES;
}

#pragma mark - 初始化配置

- (void)initConfiguration:(NSDictionary *)launchOptions {
    KFLog(@"===");
    [KFBasicServices buglyConfiguration];
    [KFBasicServices shareConfiguration];
    [KFBasicServices networkConfiguration];
    [KFBasicServices jPushNotification:self launchOptions:launchOptions];
    
    // 监听极光推送消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
}

#pragma mark - UIApplicationDelegate

// 设置友盟分享系统回调
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    // 6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

// 设置Universal Links系统回调
- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler
{
    if (![[UMSocialManager defaultManager] handleUniversalLink:userActivity options:nil]) {
        // 其他SDK的回调
    }
    return YES;
}

// 注册设备Token
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [JPUSHService registerDeviceToken:deviceToken];
}

// 注册APNs失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    KFLog(@"注册 APNs 失败 : %@", error);
}

// 收到、点击推送（App状态为正在前台或者点击通知栏的通知消息， iOS 9 Support）
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

#pragma mark- JPUSHRegisterDelegate

// iOS 12 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification API_AVAILABLE(ios(10.0))
{
  if (notification && [notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
    // 从通知界面直接进入应用
  } else {
    // 从通知设置界面进入应用
  }
}

// APP前台运行，收到推送（iOS 10 Support）
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler API_AVAILABLE(ios(10.0))
{
  NSDictionary * userInfo = notification.request.content.userInfo;
  if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
    [JPUSHService handleRemoteNotification:userInfo];
  } else {
      // 本地通知
  }
  completionHandler(UNNotificationPresentationOptionAlert);
}

// APP后台运行，点击推送（iOS 10 Support）
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler  API_AVAILABLE(ios(10.0))
{
  NSDictionary * userInfo = response.notification.request.content.userInfo;
  if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
    [JPUSHService handleRemoteNotification:userInfo];
  } else {
      // 本地通知
  }
  completionHandler();
}

// 监测通知授权状态返回的结果
- (void)jpushNotificationAuthorization:(JPAuthorizationStatus)status withInfo:(NSDictionary *)info
{
    
}

#pragma mark - 极光推送消息监听

- (void)networkDidReceiveMessage:(NSNotification *)noti {
    
    //NSDictionary *userInfo = [noti userInfo];
}


@end
