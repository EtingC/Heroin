//
//  BroadLinkFamily.m
//  Heroin
//
//  Created by Benson on 2018/10/17.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import "BroadLinkFamily.h"
#import "BroadlinkManager.h"
#import "FMDBManager.h"

#import "NSObject+NSDicJson.h"
#import "NSUserDefaults+SafeAccess.h"
@implementation BroadLinkFamily

/**
 查询账号下的家庭

 @param success 成功
 @param failure 失败
 */
+ (void)UserFamilySuccess:(successBlock)success Failure:(failureBlock)failure{
    //查询账号下的家庭
    [[BroadlinkManager sharedManager].familyManager queryLoginUserFamilyIdListWithCompletionHandler:^(BLFamilyIdListGetResult * _Nonnull result){
        if (result.error==0) { 
            //查询账号下的家庭 -->成功
            
            for (BLFamilyIdInfo *FamilyIdInfo in result.idList) {
                [[FMDBManager sharedInstance] insertDataWithTableName:@"BLFamilyIdInfo" Class:FamilyIdInfo Platform:PlatformBroadLink];
            }
            
            NSArray * arr = result.idList;
            if (arr.count>0) { 
                //账号下有家庭                            
                BLFamilyIdInfo * model = arr[0];
                [NSUserDefaults setObject:model.familyId forKey:FAMILYID];
                [NSUserDefaults setObject:model.familyVersion forKey:FAMILYVERSION];
                [NSUserDefaults setBool:YES forKey:ISLOGIN];
                
                success(BroadLinkSuccess);
            }else{
                //账号下没有家庭--》创建家庭   名称为  "*#com_lbest_rm_sfgxh#*"
                failure(BroadLinkFamilyNull);
            }
        }else{
            failure([NSString stringWithFormat:@"%ld",result.error]);
        }
    }];
}

/**
 创建家庭

 @param success 成功
 @param failure 失败
 */
+ (void)createNewFamilySuccess:(successBlock)success Failure:(failureBlock)failure{
    
    BLFamilyInfo * info = [[BLFamilyInfo alloc] init];
    info.familyName = FamliyNAME;
    //创建家庭
    [ [BroadlinkManager sharedManager].familyManager createNewFamilyWithInfo:info iconImage:[UIImage imageNamed:@""] completionHandler:^(BLFamilyInfoResult * _Nonnull result) { 
        
        if (result.error == 0) { 
            //创建家庭 --> 成功
            [[NSUserDefaults standardUserDefaults]setObject:result.familyInfo.familyId forKey:FAMILYID];
            
            [[NSUserDefaults standardUserDefaults]setObject:result.familyInfo.familyVersion forKey:FAMILYVERSION];
            [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:ISLOGIN];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [[FMDBManager sharedInstance] insertDataWithTableName:@"BLFamilyInfo" Class:result.familyInfo Platform:PlatformBroadLink];
//            [SDSFamliyManager sharedInstance].familyinfo =result.familyInfo;            
            
            success(BroadLinkSuccess);
        }else{
            //创建家庭 --> 失败
            failure(BroadLinkTokenError);
        }
    }];
}

/**
 通过获取到的家庭信息 获取设备信息

 @param ids 家庭信息 id
 @param success 成功
 @param failure 失败
 */
+ (void)queryFamilyInfoWithIds:(NSArray *)ids Success:(successBlock)success Failure:(failureBlock)failure{
    
    [[BroadlinkManager sharedManager].familyManager   queryFamilyInfoWithIds:ids completionHandler:^(BLAllFamilyInfoResult * _Nonnull result) {//通过获取到的家庭信息 获取设备信息
        if (result.error == 0) { //成功获取设备信息
            
            for (BLFamilyAllInfo *info in result.allFamilyInfoArray){
                if (info.familyBaseInfo) {
                    [[FMDBManager sharedInstance] insertDataWithTableName:BroadLink_DB_FamilyInfo Class:info.familyBaseInfo Platform:PlatformBroadLink];
                }
                for (BLRoomInfo *RoomInfo in info.roomBaseInfoArray) {
                    [[FMDBManager sharedInstance] insertDataWithTableName:BroadLink_DB_RoomInfo Class:RoomInfo Platform:PlatformBroadLink];
                }
                
                for (BLFamilyDeviceInfo *FamilyDeviceInfo in info.deviceBaseInfo) {
                    [[FMDBManager sharedInstance] insertDataWithTableName:BroadLink_DB_DeviceBaseInfo Class:FamilyDeviceInfo Platform:PlatformBroadLink];
                }
                for (BLFamilyDeviceInfo *FamilyDeviceInfo in info.subDeviceBaseInfo) {
                    [[FMDBManager sharedInstance] insertDataWithTableName:BroadLink_DB_SubDeviceBaseInfo Class:FamilyDeviceInfo Platform:PlatformBroadLink];
                }
                
                for (BLModuleInfo *ModuleInfo in info.subDeviceBaseInfo) {
                    NSLog(@"BLFamilyAllInfo ==> %@",[NSObject getObjectData:ModuleInfo]);
                    [[FMDBManager sharedInstance] insertDataWithTableName:BroadLink_DB_ModuleInfo Class:ModuleInfo Platform:PlatformBroadLink];
                }
            }
            success(BroadLinkSuccess);
        }else{
            failure([NSString stringWithFormat:@"%ld",result.error]);
        }
    }];
}

@end
