//
//  BroadlinkLogIn.h
//  Heroin
//
//  Created by Benson on 2018/9/11.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import "BaseLogIn.h"
#import "BroadLinkPlugin.h"

NS_ASSUME_NONNULL_BEGIN

@interface BroadlinkLogIn : BaseLogIn

/**
 账号密码登陆
 
 @param userName 用户名
 @param Password 密码  
 @param success 成功调用
 @param failure 失败调用
 */
+ (void)logInWithUserName:(NSString *)userName Password:(NSString *)Password Success:(successBlock)success Failure:(failureBlock)failure;

/**
 短信密码登陆
 
 @param phoneNum 注册手机号码
 @param countrycode 图片验证码
 @param vcode 短信验证码
 @param success 成功调用
 @param failure 失败调用
 */
+ (void)logInWithPhonenum:(NSString *)phoneNum countrycode:(NSString *)countrycode Vcode:(NSString *)vcode Success:(successBlock)success Failure:(failureBlock)failure;

/**
 获取验证码
 
 @param phoneTF 手机号码
 @param success 成功调用
 @param failure 失败调用
 */
+ (void)sendFastVCodeWithPhone:(NSString *)phoneTF Success:(successBlock)success Failure:(failureBlock)failure;

/**
 刷新token
 
 @param success 成功调用
 */
+ (void)RefreshAccessTokenSuccess:(successBlock)success;
@end

NS_ASSUME_NONNULL_END
