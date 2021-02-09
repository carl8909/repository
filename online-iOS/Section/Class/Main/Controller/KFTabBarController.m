//
//  KFTabBarController.m
//  online-iOS
//
//  Created by wuy on 2021/2/3.
//  Copyright © 2021 深圳市看房网科技有限公司. All rights reserved.
//

#import "KFTabBarController.h"
#import "KFNavigationController.h"
#import "KFHomeViewController.h"
#import "KFMineViewController.h"

@interface KFTabBarController ()<UITabBarDelegate,UITabBarControllerDelegate>

@end

@implementation KFTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initContentController];
}

- (void)initContentController
{
    KFHomeViewController *homeVC = [[KFHomeViewController alloc] init];
    NSString *homeIcon = @"icon_tabbar_home";
    NSString *homeIconSel = @"icon_tabbar_home_sel";
    
    [self addVC:homeVC title:@"首页" imageName:homeIcon selImageName:homeIconSel];
    
    KFMineViewController *mineVC = [[KFMineViewController alloc] init];
    NSString *mineIcon = @"icon_tabbar_mine";
    NSString *mineIconSel = @"icon_tabbar_mine_sel";
    
    [self addVC:mineVC title:@"我的" imageName:mineIcon selImageName:mineIconSel];
}

- (void)addVC:(UIViewController *)vc title:(NSString *)title imageName:(NSString *)imgName selImageName:(NSString *)selImgName {
    
    vc.tabBarItem.title = title;
    UIImage *initImage = [UIImage imageNamed:imgName];
    vc.tabBarItem.image = [initImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedImage = [UIImage imageNamed:selImgName];
    vc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : KFHexColor(0x666666)}
                                      forState:UIControlStateNormal];
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : KFHexColor(0x333333)}
                                      forState:UIControlStateHighlighted];
    KFNavigationController *nav = [[KFNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}

#pragma mark - UITabBarControllerDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
}

@end
