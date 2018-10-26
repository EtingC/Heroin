//
//  BroadLinkDevice.m
//  Heroin
//
//  Created by Benson on 2018/9/20.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import "BroadlinkManager.h"
#import "FMDBManager.h"
@interface BroadLinkDevice()


@end

@implementation BroadLinkDevice


/**
 获取 LAN Device

 @return LANDevice
 */
+ (NSMutableArray *)getLANDevice{
 
    return [self getDBInfoWithTableName:BroadLink_DB_DNADevice];
}

/**
 获取 Device

 @return Device
 */
+ (NSMutableArray *)getDevice{

    return [self getDBInfoWithTableName:BroadLink_DB_DeviceBaseInfo];
}


/**
 获取数据库 Info

 @param tableName table name 
 @return 数据库数组
 */
+ (NSMutableArray *)getDBInfoWithTableName:(NSString *)tableName{
    return [[FMDBManager sharedInstance] selectFromTableName:tableName Platform:PlatformBroadLink];
}

#pragma mark - user function


@end
