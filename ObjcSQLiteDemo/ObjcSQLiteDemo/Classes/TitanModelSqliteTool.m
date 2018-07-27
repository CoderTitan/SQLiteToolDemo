//
//  TitanModelSqliteTool.m
//  ObjcSQLiteDemo
//
//  Created by quanjunt on 2018/7/25.
//  Copyright © 2018年 quanjunt. All rights reserved.
//

#import "TitanModelSqliteTool.h"
#import "TItanSQLiteTool.h"
#import "TitanModelTool.h"

@implementation TitanModelSqliteTool


/**
 拼接创建表格的sql(拼接主键信息)
 */
+ (BOOL)createTable:(Class)clas uid:(NSString *)uid {
    //1. 拼接创建表格的sql语句
    //create table if not exists 表名(字段1 字段1类型, 字段2 字段2类型 (约束),...., primary key(字段))
    
    //1-1. 获取表格名称
    NSString *tableName = [TitanModelTool tableName:clas];
    
    if (![clas respondsToSelector:@selector(primaryKey)]) {
        NSLog(@"如果想要操作这个模型, 必须要实现+ (NSString *)primaryKey;这个方法, 来告诉我主键信息");
        return NO;
    }
    
    NSString *primary = [clas primaryKey];
    
    //1-2. 获取一个模型的所有字段和类型
    NSString *createSql = [NSString stringWithFormat:@"create table if not exists %@(%@, primary key(%@))", tableName, [TitanModelTool columnNamesAndTypesStr:clas], primary];
    
    //2. 执行语句
    return [TItanSQLiteTool deal:createSql uid:uid];;
}


@end
