//
//  main.m
//  online-iOS
//
//  Created by wuy on 2021/2/2.
//  Copyright © 2021 深圳市看房网科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KFAppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([KFAppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
