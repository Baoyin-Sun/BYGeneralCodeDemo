//
//  AppDelegate.m
//  BYGeneralCodeDemo
//
//  Created by BaoYin on 2017/4/17.
//  Copyright © 2017年 BaoYin Sun. All rights reserved.
//

#import "AppDelegate.h"
#import "BYTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    BYTabBarController *tabBar = [[BYTabBarController alloc] init];
    self.window.rootViewController = tabBar;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}


@end
