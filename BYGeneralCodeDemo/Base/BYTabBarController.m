//
//  BYTabBarController.m
//  BYGeneralCodeDemo
//
//  Created by BaoYin on 2017/5/9.
//  Copyright © 2017年 BaoYin Sun. All rights reserved.
//

#import "BYTabBarController.h"
#import "BYNavigationController.h"
#import "BYViewController.h"

@interface BYTabBarController ()
@end

@implementation BYTabBarController

#pragma mark -
#pragma mark - Override Method
- (void)viewDidLoad {
    [super viewDidLoad];
    [self customerTabBarVC];
    [self changeTabBarLineColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 
#pragma mark - Customer Method
//自定义tabbarController结构及UI
- (void)customerTabBarVC {
    //base custom
    NSArray *namesArr = @[@"HomePageViewController", @"BYPatientManagerCtrl", @"MeViewController"];
    NSArray *titlesArr = @[@"工作台", @"患者中心", @"我的"];
    NSArray *nImagesArr = @[@"ic_homepage_s", @"ic_patient_s", @"ic_my_s"];
    NSArray *sImagesArr = @[@"ic_homepage", @"ic_patient", @"ic_my"];
    
    //init controllers
    NSMutableArray *itemArr = [NSMutableArray arrayWithCapacity:namesArr.count];
    for (int i = 0; i < namesArr.count; i++) {
        BYViewController *vc = [[NSClassFromString(namesArr[i]) alloc] init];
        vc.title = titlesArr[i];
        BYNavigationController *naVC = [[BYNavigationController alloc] initWithRootViewController:vc];
        naVC.tabBarItem.image = [UIImage imageNamed:nImagesArr[i]];
        naVC.tabBarItem.selectedImage = [[UIImage imageNamed:sImagesArr[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [naVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor by_colorWithHexString:c_warmGrey]} forState:UIControlStateNormal];
        [naVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor by_colorWithHexString:c_grapefruit]} forState:UIControlStateSelected];
        [itemArr addObject:naVC];
    }
    
    //set tabbar
    self.viewControllers = itemArr;
}

- (void)changeTabBarLineColor {
    [UITabBar appearance].clipsToBounds = YES;
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BYScreen_width, 1)];
    lineView.backgroundColor = [UIColor by_colorWithHexString:c_whiteTwo_line];
    [[UITabBar appearance] addSubview:lineView];
}

/**
 *  @brief 清除H5缓存
 */
//- (void)clearTheCache {
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) {
//        NSArray * types = @[WKWebsiteDataTypeMemoryCache, WKWebsiteDataTypeDiskCache];
//        NSSet *websiteDataTypes = [NSSet setWithArray:types];
//        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
//        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
//            
//        }];
//    }else{
//        NSHTTPCookie *cookie;
//        NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//        
//        for (cookie in [storage cookies]){
//            [storage deleteCookie:cookie];
//        }
//        
//        NSURLCache * cache = [NSURLCache sharedURLCache];
//        [cache removeAllCachedResponses];
//        [cache setDiskCapacity:0];
//        [cache setMemoryCapacity:0];
//    }
//}


@end
