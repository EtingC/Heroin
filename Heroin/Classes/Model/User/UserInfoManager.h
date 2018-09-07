//
//  UserInfoManager.h
//  Heroin
//
//  Created by Benson on 2018/9/3.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoManager : NSObject

+ (instancetype)sharedTool;
@property(nonatomic,copy) NSString * account;
@property (nonatomic,copy) NSString *password;
@property(nonatomic,copy) NSString *RefreshToken;
@property(nonatomic,copy) NSString *AccessToken;
@property (nonatomic,assign) BOOL login;
@property (nonatomic,copy) NSString * FirstLogin;

@end
