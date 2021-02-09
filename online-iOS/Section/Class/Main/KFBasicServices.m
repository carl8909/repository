//
//  KFBasicServices.m
//  online-iOS
//
//  Created by wuy on 2021/2/3.
//  Copyright © 2021 深圳市看房网科技有限公司. All rights reserved.
//

#import "KFBasicServices.h"
#import "YTKNetworkConfig.h"
#import "KFAppDelegate.h"

@implementation KFBasicServices

#pragma mark - 网络配置

+ (void)networkConfiguration {
    
    [YTKNetworkConfig sharedConfig].baseUrl = @"http://m.api.haoshiqi.net";
}

#pragma mark - Bugly配置

+ (void)buglyConfiguration {
    
    [Bugly startWithAppId:@"e3d4a0fe95"];
}

#pragma mark - 分享配置

+ (void)shareConfiguration {
    
    // 打开图片水印
    [UMSocialGlobal shareInstance].isClearCacheWhenGetUserInfo = NO;
    
    // 微信和QQ完整版会校验合法的universalLink，不设置会在初始化平台失败
    NSString *wechatLinkUrl = @"https://umplus-sdk-download.oss-cn-shanghai.aliyuncs.com/";
    NSString *qqLinkUrl = @"https://umplus-sdk-download.oss-cn-shanghai.aliyuncs.com/qq_conn/101830139";
    [UMSocialGlobal shareInstance].universalLinkDic = @{@(UMSocialPlatformType_WechatSession):wechatLinkUrl,
                                                        @(UMSocialPlatformType_QQ):qqLinkUrl};
    
    // 设置微信appKey
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxdc1e388c3822c80b" appSecret:@"3baf1193c85774b3fd9d18447d76cab0" redirectURL:@"http://mobile.umeng.com/social"];
    
    // 设置QQ appKey
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105821097" appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];

}

#pragma mark - 极光推送配置

+ (void)jPushNotification:(KFAppDelegate *)appDelegate launchOptions:(NSDictionary *)launchOptions
{
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        if (@available(iOS 10.0, *)) {
            JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
            entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
            [JPUSHService registerForRemoteNotificationConfig:entity delegate:(id<JPUSHRegisterDelegate>)appDelegate];
        }
    } else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
    
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //app已经不支持iOS7及以下
    }
    
    // 启动极光推送
    [JPUSHService setupWithOption:launchOptions
                           appKey:@""
                          channel:nil
                 apsForProduction:YES
            advertisingIdentifier:nil];
    
    // 获取到极光registrationID
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        KFLog(@"resCode : %d",resCode);
        KFLog(@"registrationID : %@",registrationID);
    }];
}

@end
