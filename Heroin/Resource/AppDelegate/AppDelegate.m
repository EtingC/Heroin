//
//  AppDelegate.m
//  MobileFrame
//
//  Created by Honyar Intelligence on 2018/3/20.
//  Copyright © 2018年 Benson. All rights reserved.
//
// com.Benson.Honyar.Heroin

#import "AppDelegate.h"
//#import "LoginViewController.h"

#import "HomeViewController.h"
#import "introductoryPagesHelper.h"
#import "PasswordLogInViewController.h"
#import "SMSLogInViewController.h"
#import "RegisterViewContrller.h"

#import "LogInInterface.h"
#import "NSUserDefaults+SafeAccess.h"
@interface AppDelegate ()

@property(nonatomic,strong) NSData *deviceToken;
@property(nonatomic,strong) UISegmentedControl *Boneseg,*seg;
@property(nonatomic,assign) BOOL isSearchedDev;

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
        DDLogInfo(@"AppDelegate  ^_^!");
#warning 注册监听，没有释放，需要优化  - Benson by  
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeISearchDec:) name:SearchedDev object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reLogin) name:RELOGIN_NOTIFICATION object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setHomeVC) name:kAKNotificationUserLoggedIn object:nil];
    
    //加载页面
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self setupHomeViewController];
//    [self setupLoginViewController];
    //引导页面加载
    [self setupIntroductoryPage];
   
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    DDLogInfo(@"applicationWillResignActive ^_^!");
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    DDLogInfo(@"applicationDidEnterBackground ^_^!");
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    DDLogInfo(@"applicationWillEnterForeground ^_^!");
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    DDLogInfo(@"applicationDidBecomeActive ^_^!");
}


- (void)applicationWillTerminate:(UIApplication *)application {
    DDLogInfo(@"applicationWillTerminate ^_^!");
}


#pragma mark 引导页
-(void)setupIntroductoryPage
{
    if (UserProperties.isNoFirstLaunch) {
        return;
    }
    UserProperties.isNoFirstLaunch = YES;
    NSArray *images=@[@"introductoryPage1",@"introductoryPage2",@"introductoryPage3",@"introductoryPage4"];
    [introductoryPagesHelper showIntroductoryPageView:images];
}

#pragma mark 自定义跳转不同的页面
//登录页面
-(void)setupLoginViewController{
    PasswordLogInViewController *tabBarController = [[PasswordLogInViewController alloc] init];
    [self.window setRootViewController:tabBarController];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];  
    
//    if ([NSUserDefaults boolForKey:ISLOGIN]) {
//        [ZIKRouterToView(LogInInterface) performPath:ZIKViewRoutePath.pushFrom(self.window.rootViewController)
//                                         configuring:^(ZIKViewRouteConfiguration * _Nonnull config) {
//                                             
//                                         }];
//    }
}

//首页
-(void)setupHomeViewController{
    HomeViewController *tabBarController = [[HomeViewController alloc] init];
    [self.window setRootViewController:tabBarController];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
}


- (void)changeISearchDec:(NSNotification *)info
{
    NSDictionary *dic = [info object];
    if ([dic[@"status"] isEqualToString:@"start"]) {
        self.isSearchedDev = NO;
    }else{
        self.isSearchedDev = YES;
    }
}

-(void)reLogin{
    [((AppDelegate*) AppDelegateInstance) setupHomeViewController];
}

@end
