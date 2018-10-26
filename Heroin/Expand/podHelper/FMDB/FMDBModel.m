//
//  FMDBModel.m
//  Heroin
//
//  Created by Benson on 2018/9/19.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import "FMDBModel.h"
#import <objc/runtime.h>
@interface FMDBModel ()

@property (nonatomic, strong)   FMDatabase          *db;

@end

@implementation FMDBModel

- (FMDBModel *)initWithPath:(NSString *)path fileName:(NSString *)fileName{
    self = [super init];
    if (self) {
        self.db = [FMDatabase databaseWithPath:[NSString stringWithFormat:@"%@/%@",path,fileName]];
        if (![self.db open]) {
            DDLogInfo(@"[数据库打开失败]->%@/%@",path,fileName);
            NSAssert(0, @"数据库打开失败");
        }
    }
    return self;
}

- (void)createTableName:(NSString *)name maker:(void (^)(FMDBMaker *))block{
    FMDBMaker *maker = [[FMDBMaker alloc]init];
    maker.sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' (*)",name];
    maker.tableName = name;
    maker.db = self.db;
    block(maker);
}

- (void)dropTableName:(NSString *)name maker:(void(^)(FMDBMaker *maker))block{
    FMDBMaker *maker = [[FMDBMaker alloc]init];
    maker.sql = [NSString stringWithFormat:@"DROP TABLE %@",name];
    maker.tableName = name;
    maker.db = self.db;
    block(maker);
}

- (void)insertIntoTableName:(NSString *)tableName maker:(void (^)(FMDBMaker *))block{
    FMDBMaker *maker = [[FMDBMaker alloc]init];
    maker.sql = [NSString stringWithFormat:@"INSERT INTO '%@' (*) VALUES (?)",tableName];
    maker.tableName = tableName;
    maker.db = self.db;
    block(maker);
}

- (void)selectFromTableName:(NSString *)tableName maker:(void (^)(FMDBMaker *))block{
    FMDBMaker *maker = [[FMDBMaker alloc]init];
    maker.sql = [NSString stringWithFormat:@"SELECT * FROM %@",tableName];
    maker.tableName = tableName;
    maker.db = self.db;
    block(maker);
}

- (void)selectFromTableName:(NSString *)tableName maker:(void (^)(FMDBMaker *))block resultSet:(void (^)(FMResultSet *))setBlock{
    FMDBMaker *maker = [[FMDBMaker alloc]init];
    maker.sql = [NSString stringWithFormat:@"SELECT * FROM %@",tableName];
    maker.tableName = tableName;
    maker.db = self.db;
    maker.resultBlock = setBlock;
    block(maker);
}

- (void)deleteFromTableName:(NSString *)tableName maker:(void (^)(FMDBMaker *))block{
    FMDBMaker *maker = [[FMDBMaker alloc]init];
    maker.sql = [NSString stringWithFormat:@"DELETE FROM %@",tableName];
    maker.db = self.db;
    block(maker);
}

- (void)updateWithTableName:(NSString *)tableName maker:(void (^)(FMDBMaker *))block{
    FMDBMaker *maker = [[FMDBMaker alloc]init];
    maker.sql = [NSString stringWithFormat:@"UPDATE %@",tableName];
    maker.db = self.db;
    block(maker);
    
}
@end
