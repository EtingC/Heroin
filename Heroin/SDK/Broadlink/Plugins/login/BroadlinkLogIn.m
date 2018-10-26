//
//  BroadlinkLogIn.m
//  Heroin
//
//  Created by Benson on 2018/9/11.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import "BroadlinkManager.h"
#import "UserInfoManager.h"
#import "SDSFamliyManager.h"
#import "FMDBManager.h"

#import "NSUserDefaults+SafeAccess.h"

@implementation BroadlinkLogIn


/**
 账号密码登陆
 
 @param userName 用户名
 @param Password 密码  
 @param success 成功调用
 @param failure 失败调用
 */
+ (void)logInWithUserName:(NSString *)userName Password:(NSString *)Password Success:(successBlock)success Failure:(failureBlock)failure {
    DDLogInfo(@"账号密码登录-> [User_Name: %@]",userName);
    
    [[BroadlinkManager sharedManager].account login:userName password:Password completionHandler:^(BLLoginResult * _Nonnull result) {
        if (result.error == 0) {
            //通过accessToken 获取 userid --> 成功 
            //数据存储 NSUserDefault
    
            [NSUserDefaults setObject:result.loginsession forKey:BD_SESSION];
            [NSUserDefaults setObject:@[result.userid] forKey:BD_USERID];
            
            //登陆信息 写入数据库
            [[FMDBManager sharedInstance] insertDataWithTableName:BroadLink_DB_LoginResult Class:result Platform:PlatformBroadLink];
            
            [BroadlinkManager sharedManager].familyManager.loginSession = result.loginsession;
            DDLogDebug(@"账号密码登录 成功");
            
            success(BroadLinkSuccess);
        }else{
            //通过accessToken 获取 userid-->失败
            DDLogError(@"账号密码登录 失败-> [msg: %@]",result.msg);
            failure([NSString stringWithFormat:@"%ld",result.error]);
        }
    }];
}

/**
 短信密码登陆
 
 @param phoneNum 注册手机号码
 @param countrycode 图片验证码
 @param vcode 短信验证码
 @param success 成功调用
 @param failure 失败调用
 */
+ (void)logInWithPhonenum:(NSString *)phoneNum countrycode:(NSString *)countrycode Vcode:(NSString *)vcode Success:(successBlock)success Failure:(failureBlock)failure {
    DDLogInfo(@"短信验证码登录-> [phoneNum: %@]",phoneNum);
    
    [[BroadlinkManager sharedManager].account fastLoginWithPhoneOrEmail:phoneNum countrycode:countrycode vcode:vcode completionHandler:^(BLLoginResult * _Nonnull result) {
        if (result.error == 0) {
            //通过accessToken 获取 userid --> 成功 
            //数据存储 NSUserDefault
            [[NSUserDefaults standardUserDefaults] setObject:result.loginsession forKey:BD_SESSION];
            [[NSUserDefaults standardUserDefaults] setObject:[UserInfoManager sharedTool].password forKey:@"PASSWORD"];
            [[NSUserDefaults standardUserDefaults] setObject:@[result.userid] forKey:@"thisIsUserID"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            //登陆信息 写入数据库
            [[FMDBManager sharedInstance] insertDataWithTableName:BroadLink_DB_LoginResult Class:result Platform:PlatformBroadLink];
            
            [BroadlinkManager sharedManager].familyManager.loginSession = result.loginsession;
            DDLogDebug(@"账号密码登录 成功");
            
            success(BroadLinkSuccess);            
        }else{
            //通过accessToken 获取 userid-->失败
            DDLogError(@"短信验证码登录 失败-> [msg: %@]",result.msg);
            failure([NSString stringWithFormat:@"%ld",result.error]);
        }
    }]; 
}

/**
 获取验证码
 
 @param phoneTF 手机号码
 @param success 成功调用
 @param failure 失败调用
 */
+ (void)sendFastVCodeWithPhone:(NSString *)phoneTF Success:(successBlock)success Failure:(failureBlock)failure{
#warning 需要判断手机号码 未完成  暂时定位中国号码
    
    [[BroadlinkManager sharedManager].account sendFastVCode:phoneTF countryCode:@"0086" completionHandler:^(BLBaseResult * _Nonnull result) {
        if (result.error == 0) {
            [MBProgressHUD showAutoMessage:@"获取验证码成功"];
            success(@"获取验证码成功");
        }else{
            [MBProgressHUD showAutoMessage:result.msg];
            failure([NSString stringWithFormat:@"%ld",result.error]);
        }
    }];
}

/**
 刷新token

 @param success 成功调用
 */
+ (void)RefreshAccessTokenSuccess:(successBlock)success{
    
    [[BroadlinkManager sharedManager].account refreshAccessToken:[UserInfoManager sharedTool].RefreshToken clientId:HONYARClientID clientSecret:CLIENT_SECRET completionHandler:^(BLOauthResult * _Nonnull result) {
        
        [[NSUserDefaults standardUserDefaults]setObject:result.refreshToken forKey:REFRESHTOKEN];
        [[NSUserDefaults standardUserDefaults]setObject:result.accessToken forKey:DEVICETOKEN];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        [[FMDBManager sharedInstance] insertDataWithTableName:@"BLOauthResult" Class:result Platform:PlatformBroadLink];
        
        success(BroadLinkSuccess);
    }];
}





@end
