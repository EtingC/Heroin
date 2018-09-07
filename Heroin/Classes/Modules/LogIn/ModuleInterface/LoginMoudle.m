//
//  LoginMoudle.m
//  Heroin
//
//  Created by Benson on 2018/9/3.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import "LoginMoudle.h"

#import "BroadlinkManager.h"
#import "UserInfoManager.h"
#import "SDSFamliyManager.h"

#import "MBProgressHUD+XX.h"
@implementation LoginMoudle

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    
    return self;
}


//账号密码登录
+ (void)logInWithUserName:(NSString *)userName andPassWorld:(NSString *)passWorld
{
    [[BroadlinkManager sharedManager].account  login:userName password:passWorld completionHandler:^(BLLoginResult * _Nonnull result) { //通过accessToken 获取 userid
        if (result.error == 0) { //获取 userid-->成功
            [[NSUserDefaults standardUserDefaults]setObject:result.loginsession forKey:SESSION];
            [[NSUserDefaults standardUserDefaults]setObject:[UserInfoManager sharedTool].password forKey:@"PASSWORD"];
            [[NSUserDefaults standardUserDefaults] setObject:@[result.userid] forKey:@"thisIsUserID"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [BroadlinkManager sharedManager].familyManager.loginSession = result.loginsession;
            [[BroadlinkManager sharedManager].account getUserInfo:@[result.userid] completionHandler:^(BLGetUserInfoResult * _Nonnull result) { //通过userid-->获取用户的 nickname  userid  iconUrl
                if (result.error == 0){ ////通过userid-->获取用户的 nickname  userid  iconUrl -->成功
                    NSArray * userInfo = result.info;
                    BLUserInfo * userIf = userInfo.firstObject;
                    [[NSUserDefaults standardUserDefaults]setObject:userIf.nickname forKey:NICKNAME];
                    [[NSUserDefaults standardUserDefaults]setObject:userIf.userid forKey:ACCOUNT];
                    [[NSUserDefaults standardUserDefaults]setObject:userIf.iconUrl forKey:ICONURL];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    [BroadlinkManager sharedManager].familyManager.loginUserid = userIf.userid;
                    NSString *userIdInfoStr = [BroadlinkManager sharedManager].familyManager.loginUserid;
                    NSString *sessionInfoStr = [BroadlinkManager sharedManager].familyManager.loginSession;
                    NSLog(@"usid:***********%@,%@",userIdInfoStr,sessionInfoStr);
                    
                    
                    [[BroadlinkManager sharedManager].familyManager queryLoginUserFamilyIdListWithCompletionHandler:^(BLFamilyIdListGetResult * _Nonnull result) { //查询账号下的家庭
                        if (result.error==0) { //查询账号下的家庭 -->成功
                            
                            NSArray * arr = result.idList;
                            if (arr.count>0) { //账号下有家庭
                                
                                BLFamilyIdInfo * model = arr[0];
                                [[NSUserDefaults standardUserDefaults]setObject:model.familyId forKey:FAMILYID];
                                [[NSUserDefaults standardUserDefaults]setObject:model.familyVersion forKey:FAMILYVERSION];
                                [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:ISLOGIN];
                                [[NSUserDefaults standardUserDefaults] synchronize];
                                
                                dispatch_async(dispatch_get_main_queue(), ^{
#warning kAKNotificationUserLoggedIn
                                    //                                    [[NSNotificationCenter defaultCenter] postNotificationName:kAKNotificationUserLoggedIn object:nil];
                                });
                                
                            }else{ //账号下没有家庭--》创建家庭   名称为  "*#com_lbest_rm_sfgxh#*"
                                BLFamilyInfo * info = [[BLFamilyInfo alloc]init];
                                info.familyName = FamliyNAME;
                                [ [BroadlinkManager sharedManager].familyManager createNewFamilyWithInfo:info iconImage:[UIImage imageNamed:@""] completionHandler:^(BLFamilyInfoResult * _Nonnull result) { //创建家庭
                                    if (result.error == 0) { //创建家庭 --》成功
                                        
                                        [[NSUserDefaults standardUserDefaults]setObject:result.familyInfo.familyId forKey:FAMILYID];
                                        [[NSUserDefaults standardUserDefaults]setObject:result.familyInfo.familyVersion forKey:FAMILYVERSION];
                                        [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:ISLOGIN];
                                        [[NSUserDefaults standardUserDefaults] synchronize];
#warning hideInView
//                                        dispatch_async(dispatch_get_main_queue(), ^{
//                                            [UsingHUD hideInView:[DeviceInfoManager getCurrentVC].view];
//                                        });
                                        [SDSFamliyManager sharedInstance].familyinfo =result.familyInfo;
#warning kAKNotificationUserLoggedIn
//                                        [[NSNotificationCenter defaultCenter] postNotificationName:kAKNotificationUserLoggedIn object:nil];
                                        
                                    }else{//创建家庭 --》失败 - 》刷新token - >再次创建家庭
                                        
                                        [[BroadlinkManager sharedManager].account refreshAccessToken:[UserInfoManager sharedTool].RefreshToken clientId:LiangBaClientID clientSecret:CLIENT_SECRET completionHandler:^(BLOauthResult * _Nonnull result) {
                                            
                                            [[NSUserDefaults standardUserDefaults]setObject:result.refreshToken forKey:REFRESHTOKEN];
                                            [[NSUserDefaults standardUserDefaults]setObject:result.accessToken forKey:DEVICETOKEN];
                                            [[NSUserDefaults standardUserDefaults] synchronize];
                                            
                                            
                                            
                                            [ [BroadlinkManager sharedManager].familyManager createNewFamilyWithInfo:info iconImage:[UIImage imageNamed:@""] completionHandler:^(BLFamilyInfoResult * _Nonnull result) { //创建家庭
                                                if (result.error == 0) { //创建家庭 --》成功
                                                    
                                                    [[NSUserDefaults standardUserDefaults]setObject:result.familyInfo.familyId forKey:FAMILYID];
                                                    [[NSUserDefaults standardUserDefaults]setObject:result.familyInfo.familyVersion forKey:FAMILYVERSION];
                                                    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:ISLOGIN];
                                                    [[NSUserDefaults standardUserDefaults] synchronize];
                                                    dispatch_async(dispatch_get_main_queue(), ^{
//                                                        [UsingHUD hideInView:[DeviceInfoManager getCurrentVC].view];
                                                    });
                                                    [SDSFamliyManager sharedInstance].familyinfo =result.familyInfo;
                                                    
//                                                    [[NSNotificationCenter defaultCenter] postNotificationName:kAKNotificationUserLoggedIn object:nil];
                                                    
                                                }else{//创建家庭 --》失败
                                                    [[NSUserDefaults standardUserDefaults]setObject:@"NO" forKey:ISLOGIN];
                                                    dispatch_async(dispatch_get_main_queue(), ^{
//                                                        [UsingHUD hideInView:[DeviceInfoManager getCurrentVC].view];
                                                        [MBProgressHUD showAutoMessage:result.msg];
                                                    });
                                                }
                                            }];
                                            
                                        }];
                                    }
                                }];
                            }
                        }else{ //查询账号下的家庭 -->失败---- >再次查询家庭信息
                            
                            [[BroadlinkManager sharedManager].familyManager queryLoginUserFamilyIdListWithCompletionHandler:^(BLFamilyIdListGetResult * _Nonnull result) { //查询账号下的家庭
                                if (result.error==0) { //查询账号下的家庭 -->成功
                                    
                                    NSArray * arr = result.idList;
                                    if (arr.count>0) { //账号下有家庭
                                        
                                        BLFamilyIdInfo * model = arr[0];
                                        [[NSUserDefaults standardUserDefaults]setObject:model.familyId forKey:FAMILYID];
                                        [[NSUserDefaults standardUserDefaults]setObject:model.familyVersion forKey:FAMILYVERSION];
                                        [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:ISLOGIN];
                                        [[NSUserDefaults standardUserDefaults] synchronize];
                                        
                                        dispatch_async(dispatch_get_main_queue(), ^{
//                                            [UsingHUD hideInView:[DeviceInfoManager getCurrentVC].view];
//                                            [[NSNotificationCenter defaultCenter] postNotificationName:kAKNotificationUserLoggedIn object:nil];
                                        });
                                        
                                    }else{ //账号下没有家庭--》创建家庭   名称为  "*#com_lbest_rm_sfgxh#*"
                                        BLFamilyInfo * info = [[BLFamilyInfo alloc]init];
                                        info.familyName = FamliyNAME;
                                        [ [BroadlinkManager sharedManager].familyManager createNewFamilyWithInfo:info iconImage:[UIImage imageNamed:@""] completionHandler:^(BLFamilyInfoResult * _Nonnull result) { //创建家庭
                                            if (result.error == 0) { //创建家庭 --》成功
                                                
                                                [[NSUserDefaults standardUserDefaults]setObject:result.familyInfo.familyId forKey:FAMILYID];
                                                [[NSUserDefaults standardUserDefaults]setObject:result.familyInfo.familyVersion forKey:FAMILYVERSION];
                                                [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:ISLOGIN];
                                                [[NSUserDefaults standardUserDefaults] synchronize];
                                                dispatch_async(dispatch_get_main_queue(), ^{
//                                                    [UsingHUD hideInView:[DeviceInfoManager getCurrentVC].view];
                                                });
                                                [SDSFamliyManager sharedInstance].familyinfo =result.familyInfo;
//                                                [[NSNotificationCenter defaultCenter] postNotificationName:kAKNotificationUserLoggedIn object:nil];
                                            }else{//创建家庭 --》失败
                                                [[NSUserDefaults standardUserDefaults]setObject:@"NO" forKey:ISLOGIN];
                                                dispatch_async(dispatch_get_main_queue(), ^{
//                                                    [UsingHUD hideInView:[DeviceInfoManager getCurrentVC].view];
                                                    [MBProgressHUD showAutoMessage:result.msg];
                                                });
                                            }
                                        }];
                                    }
                                    
                                }else{ //查询账号下的家庭 -->失败
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        
                                        [[NSUserDefaults standardUserDefaults]setObject:@"NO" forKey:ISLOGIN];
//                                        [UsingHUD hideInView:[DeviceInfoManager getCurrentVC].view];
                                        [MBProgressHUD showAutoMessage:result.msg];
                                        NSLog(@"%@",result.msg);
                                    });
                                }
                            }];
                        }
                    }];
                }else{ ////通过userid-->获取用户的 nickname  userid  iconUrl -->失败
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[NSUserDefaults standardUserDefaults]setObject:@"NO" forKey:ISLOGIN];
//                        [UsingHUD hideInView:[DeviceInfoManager getCurrentVC].view];
                        [MBProgressHUD showAutoMessage:result.msg];
                    });
                }
            }];
        }else{ //通过accessToken 获取 userid-->失败
            [[NSUserDefaults standardUserDefaults]setObject:@"NO" forKey:ISLOGIN];
            dispatch_async(dispatch_get_main_queue(), ^{
//                [UsingHUD hideInView:[DeviceInfoManager getCurrentVC].view];
                [MBProgressHUD showAutoMessage:result.msg];
            });
        }
    }];
}


+ (void)logInWithPhonenum:(NSString *)phoneNum countrycode:(NSString *)countrycode andVcode:(NSString *)vcode{
    
}


@end
