//
//  BroadlinkFMDB.m
//  Heroin
//
//  Created by Benson on 2018/9/26.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import "BroadlinkFMDB.h"
#import <objc/runtime.h>

#import <BLLetAccount/BLLetAccount.h>
#import <BLLetFamily/BLLetFamily.h>
#import <BLLetCore/BLLet.h>
#import "BroadLinkPlugin.h"

#import "NSObject+NSDicJson.h"
#import "NSDictionary+JSONString.h"
#import "NSString+DictionaryValue.h"

@interface BroadlinkFMDB()
@property (strong, nonatomic) NSDictionary *MainKey;
@end

@implementation BroadlinkFMDB

- (instancetype)init{
    self = [super init];
    if (self) {
        [self initData];
    }
    return self;
}

/**
 新建DB 

 @param dbName 数据库名字
 @return 数据库模型
 */
- (FMDBModel *)CreatDBWithName:(NSString *)dbName {
    
    if (![self checkTableName:dbName]) {
        dbName = defaultDBName;
    }
    
    FMDBModel *db = [[FMDBModel alloc] initWithPath:kPathDocument fileName:[dbName stringByAppendingString:@".sqlite"]];    
    return db;
}

/**
 新建表

 @param tableName 数据表名字
 @param obj 数据模型
 @return 0 成功 / !0 失败
 */
- (NSInteger)createDataWithTableName:(NSString *)tableName Class:(id)obj{//创建数据表
    
    DDLogInfo(@"新建表 [%@]",tableName);
    NSInteger Result = 0;
    //方案一
    [_DB createTableName:tableName maker:^(FMDBMaker *maker) {
        maker.columnName(@"id").integer().primaryKey().autoincrement().notNull();
        NSDictionary *dic = [NSObject classPropsFor:obj];
        [self create:maker Dic:dic];
        maker.create();
    }];
    //方案二
    /**
     if ([obj isKindOfClass:[BLRoomInfo class]]) {
     Result = [self createDataWithTableName:tableName BLRoomInfo:obj];
     }else if ([obj isKindOfClass:[BLFamilyInfo class]]){
     Result = [self createDataWithTableName:tableName BLFamilyInfo:obj];
     }else if ([obj isKindOfClass:[BLFamilyDeviceInfo class]]){
     Result = [self createDataWithTableName:tableName BLFamilyDeviceInfo:obj];
     } **/
    return Result;
}
    
/**
 插入数据

 @param tableName 数据表名字
 @param obj 数据模型
 @return 0 成功 / !0 失败
 */
- (NSInteger)insertDataWithTableName:(NSString *)tableName Class:(id)obj {//插入数据
    
    NSInteger Result = 0;
    NSString *mainKey = _MainKey[tableName];
    NSMutableArray *resultDic = [[NSMutableArray alloc] init];
    resultDic = [self selectFromTableName:tableName key:[self nameExtension:mainKey] Value:[obj valueForKey:mainKey]];
    
    if (resultDic.count) {
        Result = [self updateWithTableName:tableName Class:obj key:mainKey];
    }else {
        //方案一
        DDLogDebug(@"插入数据 [%@]",tableName);
        [_DB insertIntoTableName:tableName maker:^(FMDBMaker *maker) {
            
            [self insert:maker obj:obj];
            maker.insert();
        }]; 
    }
    //方案二
    /**
     if ([obj isKindOfClass:[BLRoomInfo class]]) {
     Result = [self createDataWithTableName:tableName BLRoomInfo:obj];
     }else if ([obj isKindOfClass:[BLFamilyInfo class]]){
     Result = [self createDataWithTableName:tableName BLFamilyInfo:obj];
     }else if ([obj isKindOfClass:[BLFamilyDeviceInfo class]]){
     Result = [self createDataWithTableName:tableName BLFamilyDeviceInfo:obj];
     } **/
    return Result;
}

/**
 更新数据

 @param tableName 数据表名字
 @param obj 数据模型
 @param key 主键
 @return 0 成功 / !0 失败
 */
- (NSInteger)updateWithTableName:(NSString *)tableName Class:(id)obj key:(NSString *)key{
    
    DDLogDebug(@"更新数据 [%@]",tableName);
    NSInteger result = 0;
    [_DB updateWithTableName:tableName maker:^(FMDBMaker *maker) {
        
        [self up:maker obj:obj key:key];
        maker.update();
    }];
    return result;
}

/**
 查询

 @param tableName 数据表名字
 @return 数据数组
 */
- (NSMutableArray *)selectFromTableName:(NSString *)tableName {
    
    NSMutableArray *ResultSetArray = [[NSMutableArray alloc] init];
    [_DB selectFromTableName:tableName maker:^(FMDBMaker *maker) {
        maker.select();
        
    } resultSet:^(FMResultSet *set) {
        while (set.next) {
            [ResultSetArray addObject:[self getInfo:set ClassName:tableName]];
        }
    }];
    return ResultSetArray;
}

- (NSMutableArray *)selectFromTableName:(NSString *)tableName Class:(id)obj key:(NSString *)key{
    
    NSMutableArray *ResultSetArray = [[NSMutableArray alloc] init];
    id value = [obj valueForKey:key];
    ResultSetArray = [self selectFromTableName:tableName key:key Value:value];
    return ResultSetArray;
}

- (NSMutableArray *)selectFromTableName:(NSString *)tableName key:(NSString *)key Value:(id)value{
    
    NSMutableArray *ResultSetArray = [[NSMutableArray alloc] init];
    [_DB selectFromTableName:tableName maker:^(FMDBMaker *maker) {
        
        maker.where(key).DBequalTo(value);
        maker.select();
    } resultSet:^(FMResultSet *set) {
        while (set.next) {
            [ResultSetArray addObject:[self getInfo:set ClassName:tableName]];
        }

    }];
    return ResultSetArray;
}

#pragma mark - User mode (Creat New DataBase)

- (void)create:(FMDBMaker *)maker Dic:(NSDictionary *)dic{
    
    for (NSString *key in dic) {
        if ( [@"NSString" compare:dic[key]] == NSOrderedSame ) {
            maker.columnName([self nameExtension:key]).text(); 
        }else if ([@"q" compare:dic[key]] == NSOrderedSame ||
                  [@"i" compare:dic[key]] == NSOrderedSame ||
                  [@"f" compare:dic[key]] == NSOrderedSame ||
                  [@"Q" compare:dic[key]] == NSOrderedSame){
            maker.columnName([self nameExtension:key]).integer(); 
        }else if ([@"B" compare:dic[key]] == NSOrderedSame){
            maker.columnName([self nameExtension:key]).boolean(); 
        }else if([@"NSArray" compare:dic[key]] == NSOrderedSame ){
            maker.columnName([self nameExtension:key]).text(); 
        }
    }
}

#pragma mark - User mode (insert/up Data)

- (void)insert:(FMDBMaker *)maker obj:(id)obj{
    [self insertOrUp:maker Obj:obj Type:DBEEVENTInsert];
}

- (void)up:(FMDBMaker *)maker obj:(id)obj key:(NSString *)key{
    [self insertOrUp:maker Obj:obj Type:DBEEVENTUp];
    id value = [obj valueForKey:key];
    maker.where([self nameExtension:key]).DBequalTo(value);
    
}

- (void)insertOrUp:(FMDBMaker *)maker Obj:(id)obj Type:(DBEEVENT)type{
    NSDictionary *dic = [NSObject classPropsFor:[obj class]];
    for (NSString *key in dic) {
        id value = [obj valueForKey:key];
        if(value == nil)   
        {
            value = [NSNull null];   
        }
        
        if ( [@"NSString" compare:dic[key]] == NSOrderedSame ) {
            
            [self column:maker Name:key Values:value Type:type];
        }else if ([@"q" compare:dic[key]] == NSOrderedSame ||
                  [@"i" compare:dic[key]] == NSOrderedSame ||
                  [@"f" compare:dic[key]] == NSOrderedSame ||
                  [@"Q" compare:dic[key]] == NSOrderedSame){
            
            [self column:maker Name:key Values:value Type:type];
        }else if([@"B" compare:dic[key]] == NSOrderedSame){
            
            [self column:maker Name:key Values:value Type:type];
        }else if([@"NSArray" compare:dic[key]] == NSOrderedSame ){
            
            NSMutableString *str = [[NSMutableString alloc] init];
            BOOL Add = NO;
            for (id val in value) {
                if (Add) {
                    [str appendString:@"&&"];
                }
                Add = YES;
                NSDictionary *d = [NSObject getObjectData:val];
                [str appendString:[d JSONString]];
            }
            [self column:maker Name:key Values:str Type:type];
        }
    }
}

- (void)column:(FMDBMaker *)maker Name:(NSString *)key Values:(id) anObject Type:(NSInteger)type{
    switch (type) {
        case DBEEVENTUp:{
            maker.set([self nameExtension:key]).assignment(anObject);
                        
        }break;
        case DBEEVENTInsert:
            maker.columnName([self nameExtension:key]).values(anObject);
            break;   
        default:
            break;
    }
} 

#pragma mark - User mode (select Table)

- (BLFamilyDeviceInfo *)getInfo:(FMResultSet *)ResultSet ClassName:(NSString *)Name{
    
    id obj = NSClassFromString([self getClassName:Name]);
    NSDictionary *dic = [NSObject classPropsFor:obj];
    obj = [[NSClassFromString([self getClassName:Name]) alloc] init];
    for (NSString *key in dic) {
        if ( [@"NSString" compare:dic[key]] == NSOrderedSame ) {
            [obj setValue:[ResultSet stringForColumn:[self nameExtension:key]] forKey:key];
        }else if ([@"q" compare:dic[key]] == NSOrderedSame ||
                  [@"i" compare:dic[key]] == NSOrderedSame ||
                  [@"f" compare:dic[key]] == NSOrderedSame ||
                  [@"Q" compare:dic[key]] == NSOrderedSame){
            [obj setValue:[NSNumber numberWithInt:[ResultSet doubleForColumn:[self nameExtension:key]]] forKey:key]; 
            
        }else if([@"B" compare:dic[key]] == NSOrderedSame){
            [obj setValue:[NSNumber numberWithInt:[ResultSet boolForColumn:[self nameExtension:key]]] forKey:key];  
        }else if([@"NSArray" compare:dic[key]] == NSOrderedSame ){
            NSString *strs = [ResultSet stringForColumn:[self nameExtension:key]];
            NSArray *array = [strs componentsSeparatedByString:@"&&"]; 
            [obj setValue:array forKey:key];
        }
    }
    return obj;
}


- (BLFamilyIdInfo *) getFamilyIdInfo:(FMResultSet *)ResultSet{
    BLFamilyIdInfo *FamilyIdInfo = [[BLFamilyIdInfo alloc] init];
    FamilyIdInfo.shareFlag = [[ResultSet stringForColumn:@"shareFlag"] intValue];
    FamilyIdInfo.familyVersion = [ResultSet stringForColumn:@"familyVersion"];
    FamilyIdInfo.familyName = [ResultSet stringForColumn:@"familyName"];
    FamilyIdInfo.familyId = [ResultSet stringForColumn:@"familyId"];
    
    return FamilyIdInfo;
}


#pragma mark - User mode

- (void)initData{
    
    _MainKey = @{@"BLRoomInfo":@"roomId",
                 @"BLModuleInfo":@"moduleId",
                 @"SubDeviceBaseInfo":@"did",
                 @"DeviceBaseInfo":@"did",
                 @"BLFamilyInfo":@"familyId",
                 @"BLFamilyIdInfo":@"familyId",
                 @"BLUserInfo":@"userid",
                 @"BLDNADevice":@"did",
                 @"BLLoginResult":@"userid"
                 };
}

- (NSString *)nameExtension:(NSString *)name{
    return [@"BroadLink" stringByAppendingString:name];
}

- (BOOL)checkTableName:(NSString *)tableName {
    if (tableName == nil || tableName.length == 0 || [tableName rangeOfString:@" "].location != NSNotFound) {
        DDLogInfo(@"ERROR, table name: %@ format error.", tableName);
        return NO;
    }
    return YES;
}

- (NSString *)getClassName:(NSString *)tableName{
    NSDictionary *className=@{
                              @"DeviceBaseInfo":@"BLFamilyDeviceInfo"
                              };
    
    return className[tableName]?className[tableName]:tableName;
}


@end
