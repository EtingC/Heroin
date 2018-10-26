//
//  FMDBManager.m
//  Heroin
//
//  Created by Benson on 2018/9/19.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import "FMDBManager.h"
#import "BroadlinkManager.h"

@interface FMDBManager()

@end

@implementation FMDBManager

+ (FMDBManager *)sharedInstance {
    static FMDBManager *Manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Manager = [[FMDBManager alloc] init];
    });
    return Manager;
}


- (NSInteger)createDataBaseTableWithPlatform:(Platform)platfrom {
    NSInteger result = 0;
    switch (platfrom) {
        case PlatformBroadLink:
            [self BroadLinkCreateDataBaseTable];
            break;
            
        default:
            break;
    }
    return result;
}

- (void)truncateWithTableName:(NSString *)tableName Platform:(Platform)platfrom{
    
    switch (platfrom) {
        case PlatformBroadLink:
            [self truncateWithTableName:tableName ]; 
            break;
            
        default:
            break;
    }
}


- (void)insertDataWithTableName:(NSString *)tableName Class:(id)obj Platform:(Platform) platfrom{
    
    switch (platfrom) {
        case PlatformBroadLink:
            [self insertDataWithTableName:tableName Class:obj]; 
            break;
            
        default:
            break;
    }
}

- (NSMutableArray *)selectFromTableName:(NSString *)tableName Platform:(Platform) platfrom{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    switch (platfrom) {
        case PlatformBroadLink:{
            result = [self selectFromTableName:tableName];
        }break;
            
        default:
            break;
    }
    
    return result;
}

#pragma mark - BroadLink func

- (void)createDB{
//    初始化 Broadlink DB
    BroadlinkFMDB *db = [[BroadlinkFMDB alloc] init];
    _BroadLinkdb = [db CreatDBWithName:BroadlinkDBName];
    
}

- (NSInteger)BroadLinkCreateDataBaseTable{
    NSInteger result = 0;
    BroadlinkFMDB *db = [[BroadlinkFMDB alloc] init];
    db.DB = _BroadLinkdb;
    
    result = [db createDataWithTableName:@"BLDNADevice" Class:NSClassFromString(@"BLDNADevice")];
    result = [db createDataWithTableName:@"BLLoginResult" Class:NSClassFromString(@"BLLoginResult")];
    result = [db createDataWithTableName:@"BLUserInfo" Class:NSClassFromString(@"BLUserInfo")];
    result = [db createDataWithTableName:@"BLFamilyIdInfo" Class:NSClassFromString(@"BLFamilyIdInfo")];
    
    //token
    result = [db createDataWithTableName:@"BLOauthResult" Class:NSClassFromString(@"BLOauthResult")];
    //家庭信息
    result = [db createDataWithTableName:@"BLFamilyInfo" Class:NSClassFromString(@"BLFamilyInfo")];

    result = [db createDataWithTableName:@"DeviceBaseInfo" Class:NSClassFromString(@"BLFamilyDeviceInfo")];
    result = [db createDataWithTableName:@"SubDeviceBaseInfo" Class:NSClassFromString(@"BLFamilyDeviceInfo")];
    result = [db createDataWithTableName:@"BLModuleInfo" Class:NSClassFromString(@"BLModuleInfo")];
    result = [db createDataWithTableName:@"BLRoomInfo" Class:NSClassFromString(@"BLRoomInfo")];

    return result;
    
}

- (NSInteger)insertDataWithTableName:(NSString *)tableName Class:(id)obj{
    NSInteger result = 0;
    BroadlinkFMDB *db = [[BroadlinkFMDB alloc] init];
    db.DB = _BroadLinkdb;
    
    result = [db insertDataWithTableName:tableName Class: obj];    
    return result;

}

- (NSMutableArray *)selectFromTableName:(NSString *)tableName { 
        
    NSMutableArray *result = [[NSMutableArray alloc] init];;    
    BroadlinkFMDB *db = [[BroadlinkFMDB alloc] init];
    db.DB = _BroadLinkdb;

    result = [db selectFromTableName:tableName];
    
    return result;
    
}

- (NSInteger)truncateWithTableName:(NSString *)tableName {
    NSInteger result = 0;
    BroadlinkFMDB *db = [[BroadlinkFMDB alloc] init];
    db.DB = _BroadLinkdb;
    
    [db createDataWithTableName:@"BLDNADevice" Class:NSClassFromString(@"BLDNADevice")];
    
    return result;
    
}

@end
