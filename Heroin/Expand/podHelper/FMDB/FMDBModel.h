//
//  FMDBModel.h
//  Heroin
//
//  Created by Benson on 2018/9/19.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDBMaker.h"

@interface FMDBModel : NSObject

/**
 初始化对象
 @param path 数据库保存路径
 @param fileName 数据库名称
 @return 返回对象
 */
- (FMDBModel *)initWithPath:(NSString *)path fileName:(NSString *)fileName;

/**
 创建数据库表
 @param name 表名
 @param block 操作对象
 */
- (void)createTableName:(NSString *)name maker:(void(^)(FMDBMaker *maker))block;

/**
 删除数据库表
 @param name 表名
 @param block 操作对象
 */
- (void)dropTableName:(NSString *)name maker:(void(^)(FMDBMaker *maker))block;

/**
 插入数据
 @param tableName 表名
 @param block 操作对象
 */
- (void)insertIntoTableName:(NSString *)tableName maker:(void(^)(FMDBMaker *maker))block;
/**
 查询数据
 @param tableName 查询的表格
 @param block 操作对象
 */
- (void)selectFromTableName:(NSString *)tableName maker:(void(^)(FMDBMaker *maker))block;
- (void)selectFromTableName:(NSString *)tableName maker:(void(^)(FMDBMaker *maker))block resultSet:(void(^)(FMResultSet *set))setBlock;
/**
 删除表中数据
 
 @param tableName 需要删除数据的表名
 @param block 操作对象
 */
- (void)deleteFromTableName:(NSString *)tableName maker:(void(^)(FMDBMaker *maker))block;
/**
 更新数据库中数据
 @param tableName 需要更新数据的表名
 @param block 操作对象
 */
- (void)updateWithTableName:(NSString *)tableName maker:(void(^)(FMDBMaker *maker))block;
@end
