//
//  FMDBMaker.m
//  Heroin
//
//  Created by Benson on 2018/9/19.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import "FMDBMaker.h"

@interface FMDBMaker ()

@property (nonatomic, copy)     NSString            *columnStr;
@property (nonatomic, copy)     NSString            *valuesStr;
@property (nonatomic, copy)     NSString            *whereStr;
@property (nonatomic, copy)     NSString            *setStr;

@end

@implementation FMDBMaker

- (FMDBMaker *(^)(void))SQLOG{
    return ^(){
        //NSLog(@"\n sql == %@ \n columnStr == %@ \n valuesStr == %@",self.sql,self.columnStr,self.valuesStr);
        return self;
    };
}

- (FMDBMaker *(^)(NSString *))columnName{
    return ^(NSString *columnName){
        if (self.columnStr && ![self.columnStr isEqualToString:@""]) {
            self.columnStr = [NSString stringWithFormat:@"%@ ,%@",self.columnStr,columnName];
        } else {
            self.columnStr = [NSString stringWithFormat:@"%@",columnName];
        }
        return self;
    };
}

- (FMDBMaker *(^)(void))integer{
    return ^(){
        self.columnStr = [NSString stringWithFormat:@"%@ INTEGER",self.columnStr];
        return self;
    };
}

- (FMDBMaker *(^)(void))text{
    return ^(){
        self.columnStr = [NSString stringWithFormat:@"%@ TEXT",self.columnStr];
        return self;
    };
}

- (FMDBMaker *(^)(void))blob{
    return ^(){
        self.columnStr = [NSString stringWithFormat:@"%@ BLOB",self.columnStr];
        return self;
    };
}

- (FMDBMaker *(^)(void))boolean{
    return ^(){
        self.columnStr = [NSString stringWithFormat:@"%@ BOOL",self.columnStr];
        return self;
    };
}

- (FMDBMaker *(^)(void))primaryKey{
    return ^(){
        self.columnStr = [NSString stringWithFormat:@"%@ PRIMARY KEY",self.columnStr];
        return self;
    };
}

- (FMDBMaker *(^)(void))autoincrement{
    return ^(){
        self.columnStr = [NSString stringWithFormat:@"%@ AUTOINCREMENT",self.columnStr];
        return self;
    };
}

- (FMDBMaker *(^)(void))notNull{
    return ^(){
        self.columnStr = [NSString stringWithFormat:@"%@ NOT NULL",self.columnStr];
        return self;
    };
}

- (FMDBMaker *(^)(void))create{
    return ^(){
        NSMutableString *sql = [NSMutableString stringWithFormat:@"%@",self.sql];
        NSRange range = [sql rangeOfString:@"*"];
        [sql replaceCharactersInRange:range withString:self.columnStr];
//        NSLog(@" FMDBMaker ----- %@",sql);
        BOOL result = [self.db executeUpdate:sql];
        if (result) {
        }
        return self;
    };
}

- (FMDBMaker *(^)(id))values{
    return ^(id anObject) {
        if (![anObject isKindOfClass:[NSObject class]]) {
            NSAssert(0, @"anObject不是一个OC对象");
        } else {
            if ([anObject isKindOfClass:[NSNumber class]]) {
                if (self.valuesStr && ![self.valuesStr isEqualToString:@""]) {
                    self.valuesStr = [NSString stringWithFormat:@"%@ ,%@",self.valuesStr,anObject];
                } else {
                    self.valuesStr = [NSString stringWithFormat:@"%@",anObject];
                }
            } else {
                if (self.valuesStr && ![self.valuesStr isEqualToString:@""]) {
                    self.valuesStr = [NSString stringWithFormat:@"%@ ,'%@'",self.valuesStr,anObject];
                } else {
                    self.valuesStr = [NSString stringWithFormat:@"'%@'",anObject];
                }
            }
        }
        return self;
    };
}

- (FMDBMaker *(^)(void))insert{
    return ^(){
        NSMutableString *sql = [NSMutableString stringWithFormat:@"%@",self.sql];
        NSRange range = [sql rangeOfString:@"*"];
        [sql replaceCharactersInRange:range withString:self.columnStr];
        range = [sql rangeOfString:@"?"];
        [sql replaceCharactersInRange:range withString:self.valuesStr];
//        NSLog(@"sql == %@",sql);
        BOOL result = [self.db executeUpdate:sql];
        if (result) {
            //NSLog(@"插入成功");
        } else {
            //NSLog(@"插入失败");
        }
        return self;
    };
}

- (FMDBMaker *(^)(NSString *))where{
    return ^(NSString *columnName) {
        if (self.whereStr && ![self.whereStr isEqualToString:@""]) {
            self.whereStr = [NSString stringWithFormat:@"%@ %@",self.whereStr,columnName];
        } else {
            self.whereStr = [NSString stringWithFormat:@"WHERE %@",columnName];
        }
        return self;
    };
}

- (FMDBMaker *(^)(id))greateThan{
    return ^(id anObject) {
        self.whereStr = [NSString stringWithFormat:@"%@ > '%@'",self.whereStr,anObject];
        return self;
    };
}

- (FMDBMaker *(^)(id))greateThanOrEqualTo{
    return ^(id anObject) {
        self.whereStr = [NSString stringWithFormat:@"%@ >='%@'",self.whereStr,anObject];
        return self;
    };
}

- (FMDBMaker *(^)(id))DBequalTo{
    return ^(id anObject) {
        self.whereStr = [NSString stringWithFormat:@"%@ == '%@'",self.whereStr,anObject];
        return self;
    };
}

- (FMDBMaker *(^)(id))lessThan{
    return ^(id anObject) {
        self.whereStr = [NSString stringWithFormat:@"%@ < '%@'",self.whereStr,anObject];
        return self;
    };
}

- (FMDBMaker *(^)(id))lessThanOrEqualTo{
    return ^(id anObject) {
        self.whereStr = [NSString stringWithFormat:@"%@ <= '%@'",self.whereStr,anObject];
        return self;
    };
}

- (FMDBMaker *(^)(id))AND{
    return ^(id anObject) {
        self.whereStr = [NSString stringWithFormat:@"%@ AND",self.whereStr];
        return self;
    };
}

- (FMDBMaker *(^)(id))OR{
    return ^(id anObject) {
        self.whereStr = [NSString stringWithFormat:@"%@ OR",self.whereStr];
        return self;
    };
}

- (FMDBMaker *(^)(void))select{
    return ^(){
        NSMutableString *sql = [NSMutableString stringWithFormat:@"%@",self.sql];
        if (self.columnStr && ![self.columnStr isEqualToString:@""]) {
            NSRange range = [sql rangeOfString:@"*"];
            [sql replaceCharactersInRange:range withString:self.columnStr];
        }
        if (self.whereStr && ![self.whereStr isEqualToString:@""]) {
            [sql insertString:[NSString stringWithFormat:@" %@",self.whereStr] atIndex:sql.length];
        }
        FMResultSet *set = [self.db executeQuery:sql];
        self.resultBlock(set);
        //        while ([set next]) {
        //            //NSLog(@"%@",[set stringForColumn:@"name"]);
        //        }
        return self;
    };
}

- (FMDBMaker *(^)(void))Delete{
    return ^(){
        NSMutableString *sql;
        if (self.whereStr && ![self.whereStr isEqualToString:@""]) {
            sql = [NSMutableString stringWithFormat:@"%@ %@",self.sql,self.whereStr];
        } else {
            sql = [NSMutableString stringWithFormat:@"%@",self.sql];
        }
        //        //NSLog(@"%@",sql);
        BOOL result = [self.db executeUpdate:sql];
        if (result) {
            //            //NSLog(@"删除成功");
        } else {
            //            //NSLog(@"删除失败");
        }
        return self;
    };
}

- (FMDBMaker *(^)(NSString *))set{
    return ^(NSString *columnName){
        if ([self.setStr containsString:@"SET"]) {
            self.setStr = [NSString stringWithFormat:@"%@, %@",self.setStr,columnName];
        }else{
            self.setStr = [NSString stringWithFormat:@"SET %@",columnName];
        }
        return self;
    };
}

- (FMDBMaker *(^)(id))assignment{
    return ^(id values){
        self.setStr = [NSString stringWithFormat:@"%@ = '%@'",self.setStr,values];
        return self;
    };
}

- (FMDBMaker *(^)(void))update{
    return ^(){
        NSMutableString *sql;
        if (self.setStr && self.whereStr) {
            //UPDATE tableName SET name = liujing WHERE address == guiyang
            /*
             maker.set("name").equalTo("liujing").where("address").equalTo("guiyang");
             */
            sql = [NSMutableString stringWithFormat:@"%@ %@ %@",self.sql,self.setStr,self.whereStr];
        } else {
            NSAssert(0, @"setStr/whereStr不能为空");
        }
        //        //NSLog(@"%@",sql);
        BOOL result = [self.db executeUpdate:sql];
        if (result) {
            //NSLog(@"数据修改成功");
        } else {
            //NSLog(@"数据修改失败");
        }
        return self;
    };
}
- (FMDBMaker *(^)(void))truncate{
    return ^(){
        NSMutableString *sql;
        if (self.whereStr && ![self.whereStr isEqualToString:@""]) {
            sql = [NSMutableString stringWithFormat:@"%@ %@",self.sql,self.whereStr];
        } else {
            sql = [NSMutableString stringWithFormat:@"%@",self.sql];
        }
        
        BOOL result = [self.db executeUpdate:sql];
        if (result) {
            NSLog(@"truncate 成功");
        } else {
            NSLog(@"truncate 失败");
        }
        return self;
    };
}


@end
