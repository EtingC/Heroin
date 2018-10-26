//
//  FMDBManager.h
//  Heroin
//
//  Created by Benson on 2018/9/19.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BroadlinkFMDB.h"

@interface FMDBManager : NSObject

@property(nonatomic, strong) FMDBModel *BroadLinkdb;

+ (FMDBManager *)sharedInstance;

- (void)createDB;

/**
 创建数据

 @param platfrom 平台
 @return 0:成功 !0:失败
 */
- (NSInteger)createDataBaseTableWithPlatform:(Platform)platfrom;

/**
 清空表中的数据

 @param tableName 数据表名字
 @param platfrom 平台
 */
- (void)truncateWithTableName:(NSString *)tableName Platform:(Platform) platfrom;

/**
 插入数据

 @param tableName 数据表名字
 @param obj 数据模型
 @param platfrom 平台
 */
- (void)insertDataWithTableName:(NSString *)tableName Class:(id)obj Platform:(Platform) platfrom;


/**
 查询数据

 @param tableName 数据表名字
 @param platfrom 平台
 @return 查询数据列表
 */
- (NSMutableArray *)selectFromTableName:(NSString *)tableName Platform:(Platform) platfrom;

@end
