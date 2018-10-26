//
//  BroadLinkUserInfo.m
//  Heroin
//
//  Created by Benson on 2018/10/17.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import "BroadLinkUserInfo.h"
#import "BroadlinkManager.h"
#import "FMDBManager.h"
#import "NSUserDefaults+SafeAccess.h"

@implementation BroadLinkUserInfo

/**
 获取用户的 nickname  userid  iconUrl

 @param useridArray userid 数组
 @param success 成功调用
 @param failure 失败调用
 */
+ (void)UserInfoWithUserid:(NSArray<NSString *> *)useridArray Success:(successBlock)success Failure:(failureBlock)failure{
    
    [[BroadlinkManager sharedManager].account getUserInfo:useridArray completionHandler:^(BLGetUserInfoResult * _Nonnull result) {
        if (result.error == 0){ 
            //通过userid-->获取用户的 nickname  userid  iconUrl -->成功
            
            for (BLUserInfo *userInfo in result.info) {
                [[FMDBManager sharedInstance] insertDataWithTableName:@"BLUserInfo" Class:userInfo Platform:PlatformBroadLink];
            }
            
            NSArray * userInfo = result.info;
            BLUserInfo * userIf = userInfo.firstObject;
            
            [NSUserDefaults setObject:userIf.nickname forKey:NICKNAME];
            [NSUserDefaults setObject:userIf.userid forKey:ACCOUNT];
            [NSUserDefaults setObject:userIf.iconUrl forKey:ICONURL];
            
            [BroadlinkManager sharedManager].familyManager.loginUserid = userIf.userid;
            NSString *userIdInfoStr = [BroadlinkManager sharedManager].familyManager.loginUserid;
            NSString *sessionInfoStr = [BroadlinkManager sharedManager].familyManager.loginSession;
            
            NSLog(@"usid:[%@-%@]",userIdInfoStr,sessionInfoStr);
            
            success(BroadLinkSuccess);
            
        }else{
            //通过userid-->获取用户的 nickname  userid  iconUrl -->失败
            failure([NSString stringWithFormat:@"%ld",result.error]);
        }
    }];    
}


@end
