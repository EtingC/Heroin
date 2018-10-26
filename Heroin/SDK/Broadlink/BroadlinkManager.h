//
//  BroadlinkManager.h
//  Heroin
//
//  Created by Benson on 2018/8/31.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BLLetAccount/BLLetAccount.h>
#import <BLLetFamily/BLLetFamily.h>
#import <BLLetCore/BLLet.h>

#import "BroadlinkLogIn.h"
#import "BroadLinkDevice.h"

typedef void (^successBlock)(id param);
typedef void (^failureBlock)(id param);

@interface BroadlinkManager : NSObject

@property(nonatomic,strong)  BLAccount * account;
@property(nonatomic,strong)  BLLet *let;
@property (nonatomic,strong) BLFamilyController *familyManager;

+ (BroadlinkManager *)sharedManager;

/**
 BroadLink SDK 加载
 */
- (void)loadAppSdk;

#pragma mark - 登陆
/**
 登陆
 
 @param userName 用户名/手机号码
 @param PoV 用户密码/短信验证码
 @param countrycode 图片验证码
 @param mode 登陆模式
 @param success 成功
 @param failure 失败
 */
- (void)logInWithUserName:(NSString *)userName PasswordOrVcode:(NSString *)PoV countrycode:(NSString *)countrycode LandMode:(LandMode)mode Success:(successBlock)success Failure:(failureBlock)failure;



@end
