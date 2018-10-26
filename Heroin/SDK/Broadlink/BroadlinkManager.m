//
//  BroadlinkManager.m
//  Heroin
//
//  Created by Benson on 2018/8/31.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import "BroadlinkManager.h"
#import "FMDBManager.h"
#import "NSObject+NSDicJson.h"
#import "NSUserDefaults+SafeAccess.h"

#import "BroadlinkLogIn.h"
#import "BroadLinkUserInfo.h"
#import "BroadLinkFamily.h"
@interface BroadlinkManager()<BLControllerDelegate>

@end

@implementation BroadlinkManager

+ (BroadlinkManager *)sharedManager
{
    static BroadlinkManager *deviceInfoManager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        deviceInfoManager = [[self alloc] init];
        deviceInfoManager.let.configParam.controllerScriptDownloadVersion = 1;
    });
    return deviceInfoManager;
}

/**
 BroadLink SDK 加载
 */
- (void)loadAppSdk {
    
    DDLogInfo(@"loadAppSdk  ^_^!");

    self.let = [BLLet sharedLetWithLicense:HONYARLicense];        // Init APPSDK
    self.let.debugLog = BL_LEVEL_NONE;                           // Set APPSDK debug log level
    [self.let.controller setSDKRawDebugLevel:BL_LEVEL_NONE];     // Set DNASDK debug log level
    [self.let.controller startProbe:3000];                           // Start probe device
    self.let.controller.delegate = self;
    self.let.configParam.controllerSendCount = 2;
    
    NSString  *licenseID = self.let.configParam.licenseId;
    NSString  *companyID = self.let.configParam.companyId;
    [NSUserDefaults setObject:self.let.configParam.licenseId forKey:LicenseID];
    [NSUserDefaults setObject:self.let.configParam.companyId forKey:CompanyID];
    
    self.account = [BLAccount sharedAccountWithConfigParam:licenseID CompanyId:companyID];
    self.familyManager = [BLFamilyController sharedManagerWithConfigParam:licenseID];
    
}

#pragma mark - BLControllerDelegate
- (Boolean)filterDevice:(BLDNADevice *)device {
    return NO;
}
- (Boolean)shouldAdd:(BLDNADevice *)device {
    return YES;
}
- (void)onDeviceUpdate:(BLDNADevice *)device isNewDevice:(Boolean)isNewDevice {
    if (isNewDevice) {
        
        NSLog(@"[device]%@--%@",device.name,device.did);
        
        [[FMDBManager sharedInstance] insertDataWithTableName:@"BLDNADevice" Class:device Platform:PlatformBroadLink];
         
//        if ([[LiangBaDevice sharedInstance] deviceHasAddedInDeviceArray:device] == NO) {
//            NSLog(@"加入家庭的控制key000：%@",device.controlKey);
//            [[LiangBaDevice sharedInstance] addDeviceToDeviceArray:device];
//        }
    }
}


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
- (void)logInWithUserName:(NSString *)userName PasswordOrVcode:(NSString *)PoV countrycode:(NSString *)countrycode LandMode:(LandMode)mode Success:(successBlock)success Failure:(failureBlock)failure{
    switch (mode) {
        case LandModePassword:{
            //账号密码登陆
            [BroadlinkLogIn logInWithUserName:userName Password:PoV Success:^(id param) {
                [self LoginLogicSuccess:success Failure:failure];
            } Failure:^(id param) {
                failure(param);   
            }];
        }break;
        case LandModeVcode:{
            [BroadlinkLogIn logInWithPhonenum:userName countrycode:PoV Vcode:countrycode Success:^(id param) {
                [self LoginLogicSuccess:success Failure:failure];
            } Failure:^(id param) {
                failure(param);
            }];
        }break;
        default:
            
            break;
    }
}

- (void)LoginLogicSuccess:(successBlock)success Failure:(failureBlock)failure{
    //获取用户信息
    [BroadLinkUserInfo UserInfoWithUserid:[NSUserDefaults arrayForKey:BD_USERID] Success:^(id param) {
        //获取家庭资料
        [BroadLinkFamily UserFamilySuccess:^(id param) {
            success(BroadLinkSuccess);
        } Failure:^(id param) {
            if ([param isEqualToString:BroadLinkFamilyNull] ) {
                [BroadLinkFamily createNewFamilySuccess:^(id param) {
                    success(BroadLinkSuccess);
                } Failure:^(id param) {
                    if ([param isEqualToString:BroadLinkTokenError]) {
                        [BroadlinkLogIn RefreshAccessTokenSuccess:^(id param) {
                            [BroadLinkFamily createNewFamilySuccess:^(id param) {
                                success(BroadLinkSuccess);
                            } Failure:^(id param) {
                                failure(param);
                            }];
                        }];
                    }
                }];
            }else{
                failure(param);   
            }
        }];
    } Failure:^(id param) {
        failure(param);   
    }];
}

@end
