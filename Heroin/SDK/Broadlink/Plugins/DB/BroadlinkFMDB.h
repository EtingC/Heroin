//
//  BroadlinkFMDB.h
//  Heroin
//
//  Created by Benson on 2018/9/26.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDBBase.h"
#import "FMDBModel.h"

@interface BroadlinkFMDB : NSObject <FMDBBase>

@property(strong, nonatomic)FMDBModel *DB;

/**
 新建 数据库
 
 @param dbName 数据 Name
 @return 数据库模型
 */
- (FMDBModel *)CreatDBWithName:(NSString *)dbName;


//条件查询  
- (NSMutableArray *)selectFromTableName:(NSString *)tableName key:(NSString *)key Value:(id)value;



@end
