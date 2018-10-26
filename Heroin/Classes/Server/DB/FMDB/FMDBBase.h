//
//  FMDBBase.h
//  Heroin
//
//  Created by Benson on 2018/9/26.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FMDBBase <NSObject>

@optional
//初始化DB
- (instancetype)initDB;

/**
 新建表
 
 @param tableName 数据表 Name
 @param obj 数据模型
 @return 0:成功 !0:失败
 */
- (NSInteger)createDataWithTableName:(NSString *)tableName Class:(id)obj;

/**
 插入数据

 @param tableName 数据表 Name
 @param obj 数据模型
 @return 0:成功 !0:失败
 */
- (NSInteger)insertDataWithTableName:(NSString *)tableName Class:(id)obj;//插入数据

/**
 更新数据

 @param tableName 数据表 Name
 @param obj 数据模型
 @param key 数据模型主键
 @return 0:成功 !0:失败
 */
- (NSInteger)updateWithTableName:(NSString *)tableName Class:(id)obj key:(NSString *)key;

/**
 查询列表

 @param tableName 数据表 Name
 @return 数据数组
 */
- (NSMutableArray *)selectFromTableName:(NSString *)tableName;

/**
 查询数据

 @param tableName 数据表 Name
 @param obj 数据模型
 @param key 数据模型主键
 @return 数据数组
 */
- (NSMutableArray *)selectFromTableName:(NSString *)tableName Class:(id)obj key:(NSString *)key;

/**
 查询数据

 @param tableName 数据表 Name
 @param key 数据键
 @param value 数据值
 @return 数据数组
 */
- (NSMutableArray *)selectFromTableName:(NSString *)tableName key:(NSString *)key Value:(id)value;
@end
