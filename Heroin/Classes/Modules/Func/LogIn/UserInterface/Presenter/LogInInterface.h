//
//  LogInInterface.h
//  Heroin
//
//  Created by Benson on 2018/8/6.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, LogInModel){
    LogInModelAccountLogin = 0, //账号密码登陆
    LogInModelVCodeLogin,//验证码登陆
    LogInModelRegister, //注册
    LogInModelPasswordSecurity, //密码隐藏/密码可见
    LogInModelForgetPassword,// 忘记密码
    LogInModelSMSLogin,//SMS 登陆
    LogInModelVCode,//获取验证码
};
@protocol LogInInterface <NSObject>

@end


@protocol PasswordLogInInterface <ZIKViewRoutable>
- (void)onClearText;
- (void)changeSecret;
- (void)onLoginResult:(Boolean) result code:(int) code;
@end

@protocol RegisterInterface <ZIKViewRoutable>
@property(nonatomic,copy) NSString *phoneStr;
- (void)onClearText;
- (void)changeSecret;
- (void)onLoginResult:(Boolean) result code:(int) code;
@end

@protocol CaptchaInterface <ZIKViewRoutable>

@end

@protocol SMSLogInInterface <ZIKViewRoutable>

@end

