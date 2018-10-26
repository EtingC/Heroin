//
//  FMDBMaker.h
//  Heroin
//
//  Created by Benson on 2018/9/19.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>

typedef void(^FMResultSetBlock)(FMResultSet *);
@interface FMDBMaker : NSObject

@property (nonatomic, copy)         NSString        *sql;
@property (nonatomic, strong)       FMDatabase      *db;
@property (nonatomic, copy)         NSString        *tableName;
@property (nonatomic, assign)       FMResultSetBlock    resultBlock;
//@property (nonatomic, getter=update)   void        update;

#pragma mark - 三种基本数据格式
- (FMDBMaker *(^)(void))integer;
- (FMDBMaker *(^)(void))text;
- (FMDBMaker *(^)(void))blob;
- (FMDBMaker *(^)(void))boolean;

#pragma mark - 列属性
- (FMDBMaker *(^)(void))primaryKey;
- (FMDBMaker *(^)(void))autoincrement;
- (FMDBMaker *(^)(void))notNull;

#pragma mark - 逻辑操作
- (FMDBMaker *(^)(NSString *))where;
- (FMDBMaker *(^)(id))AND;
- (FMDBMaker *(^)(id))OR;

- (FMDBMaker *(^)(id))greateThan;
- (FMDBMaker *(^)(id))greateThanOrEqualTo;
- (FMDBMaker *(^)(id))DBequalTo;
- (FMDBMaker *(^)(id))lessThan;
- (FMDBMaker *(^)(id))lessThanOrEqualTo;
/**
 打印sqlite语句
 */
- (FMDBMaker *(^)(void))SQLOG;
/**
 列属性
 */
- (FMDBMaker *(^)(NSString *))columnName;
/**
 创建表
 */
- (FMDBMaker *(^)(void))create;
- (FMDBMaker *(^)(id))values;
- (FMDBMaker *(^)(NSString *))set;
- (FMDBMaker *(^)(id))assignment;
- (FMDBMaker *(^)(void))insert;
- (FMDBMaker *(^)(void))select;
- (FMDBMaker *(^)(void))Delete;
- (FMDBMaker *(^)(void))update;
- (FMDBMaker *(^)(void))truncate;

@end
