//
//  GVUserDefaults+Properties.h
//  Heroin
//
//  Created by Benson on 2018/7/25.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import "GVUserDefaults.h"

#define UserProperties [GVUserDefaults standardUserDefaults]
@interface GVUserDefaults (Properties)

#pragma mark - personinfo
@property (nonatomic,weak) NSString *userName;
@property (nonatomic,weak) NSString *name;
@property (nonatomic,weak) NSString *role;

@property(nonatomic,weak)NSDate *MBJsPatchTime;

#pragma mark - 是否是第一次启动APP程序
@property (nonatomic,assign) BOOL isNoFirstLaunch;

@end

