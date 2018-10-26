//
//  XAspect-ServerAppDelegate.m
//  Heroin
//
//  Created by Benson on 2018/9/29.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import "AppDelegate.h"
#import "XAspect.h"
#import "FMDBManager.h"

/**
 必须要有的宏定义, 而且必须写在最前面
 @param AtAspect: 字段固定, 不能修改
 @param LZProjectName: 这个可以自定义, 一般和自己需要注入代码的类有关
 */
#define AtAspect LogAppDelegate

/** 
 需要注入代码的类
 @param AtAspectOfClass: 固定字段, 不能修改
 @param AppDelegate: 需要注入代码的类
 */
#define AtAspectOfClass AppDelegate
// 开辟空间, 这个参数类名需和上面的类一致
@classPatchField(AppDelegate)

/**
 需要添加的方法
 @param - 方法类型: - 实例方法; + 类方法
 @param BOOL 返回值类型
 @param UIApplication 方法实体
 @return 返回
 */
AspectPatch(-, BOOL, application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions)
{
    [[FMDBManager sharedInstance] createDB];
    [[FMDBManager sharedInstance] createDataBaseTableWithPlatform:PlatformBroadLink];
    
    return XAMessageForward(application:application didFinishLaunchingWithOptions:launchOptions);
}

@end
#undef AtAspectOfClass
#undef AtAspect
