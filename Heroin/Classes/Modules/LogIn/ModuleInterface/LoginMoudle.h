//
//  LoginMoudle.h
//  Heroin
//
//  Created by Benson on 2018/9/3.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginMoudle : NSObject

@property (nonatomic,copy) NSString * user;
@property (nonatomic,copy) NSString * password;

+ (void)logInWithUserName:(NSString *)userName andPassWorld:(NSString *)passWorld;

+ (void)logInWithPhonenum:(NSString *)phoneNum countrycode:(NSString *)countrycode andVcode:(NSString *)vcode;

@end
