//
//  HomeViewController.m
//  Heroin
//
//  Created by Benson on 2018/9/10.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import "HomeViewController.h"
#import "BaseNavigationController.h"

#import "MeViewController.h"
#import "DeviceViewController.h"
#import "SceneViewController.h"

@interface HomeViewController()

@end

@implementation HomeViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupTabBarController];
        
        self.tabBar.tintColor =RGB(182, 65, 65);
        
        //显示未读
        //        UINavigationController  *discoverNav =(UINavigationController *)self.viewControllers[1];
        //        UITabBarItem *curTabBarItem=discoverNav.tabBarItem;
        //        [curTabBarItem setBadgeValue:@"2"];
        
    }
    return self;
}

- (void)setupTabBarController {
    /// 设置TabBar属性数组
    self.tabBarItemsAttributes =[self tabBarItemsAttributesForController];
    
    /// 设置控制器数组
    self.viewControllers =[self ViewControllers];
    
    self.delegate = self;
    self.moreNavigationController.navigationBarHidden = YES;
}

//TabBar文字跟图标设置
- (NSArray *)tabBarItemsAttributesForController {
    NSDictionary *firstTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"设备",
                                                 CYLTabBarItemImage : @"tab_equipment",
                                                 CYLTabBarItemSelectedImage : @"tab_equipment_on",
                                                 };
    NSDictionary *secondTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"场景",
                                                  CYLTabBarItemImage : @"tab_scene",
                                                  CYLTabBarItemSelectedImage : @"tab_scene_on",
                                                  };
    NSDictionary *thirdTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"我",
                                                 CYLTabBarItemImage : @"tab_user",
                                                 CYLTabBarItemSelectedImage : @"tab_user_on",
                                                 };
    
    NSArray *tabBarItemsAttributes = @[
                                       firstTabBarItemsAttributes,
                                       secondTabBarItemsAttributes,
                                       thirdTabBarItemsAttributes
                                       ];
    return tabBarItemsAttributes;
}

//控制器设置
- (NSArray *)ViewControllers {
    
    DeviceViewController *firstViewController = [[DeviceViewController alloc] init];
    UINavigationController *firstNavigationController = [[BaseNavigationController alloc]
                                                         initWithRootViewController:firstViewController];
    
    SceneViewController *secondViewController = [[SceneViewController alloc] init];
    UINavigationController *secondNavigationController = [[BaseNavigationController alloc]
                                                          initWithRootViewController:secondViewController];
    
    MeViewController *thirdViewController = [[MeViewController alloc] init];
    UINavigationController *thirdNavigationController = [[BaseNavigationController alloc]
                                                         initWithRootViewController:thirdViewController];
    
    NSArray *viewControllers = @[
                                 firstNavigationController,
                                 secondNavigationController,
                                 thirdNavigationController
                                 ];
    
    return viewControllers;
}

#pragma mark - UITabBarControllerDelegate

- (BOOL)tabBarController:(UITabBarController*)tabBarController shouldSelectViewController:(UINavigationController*)viewController {
    /// 特殊处理 - 是否需要登录
    BOOL isBaiDuService = [viewController.topViewController isKindOfClass:[SceneViewController class]];
    if (isBaiDuService) {
        
    }
    return YES;
}

@end
