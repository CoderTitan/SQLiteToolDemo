//
//  TitanSqliteTest.m
//  ObjcSQLiteDemoTests
//
//  Created by quanjunt on 2018/7/25.
//  Copyright © 2018年 quanjunt. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TItanSQLiteTool.h"
#import "TitanModelSqliteTool.h"

@interface TitanSqliteTest : XCTestCase

@end

@implementation TitanSqliteTest


/**
 测试是否可以正常执行sql语句
 */
- (void)testExample {
    // 创建表格的语句
    NSString *sql = @"create table if not exists student(id integer primary key autoincrement, name text not null, age integer, score real)";
    BOOL result = [TItanSQLiteTool deal:sql uid:nil];
    XCTAssertEqual(result, YES);
}


- (void)testQuery {
    //删除所有记录
    NSString * delStr = @"delete from student1";
    BOOL deleteSql = [TItanSQLiteTool deal:delStr uid:nil];
    XCTAssertEqual(deleteSql, YES);
    
    
    //添加记录
    NSString *insert = @"insert into student1(id, name, age, score) values (1, 'sz', 18, 0)";
    BOOL res = [TItanSQLiteTool deal:insert uid:nil];
    XCTAssertEqual(res, YES);
    
    //添加记录
    NSString *insert1 = @"insert into student1(id, name, age, score) values (2, 'jun', 19, 90)";
    BOOL res1 = [TItanSQLiteTool deal:insert1 uid:nil];
    XCTAssertEqual(res1, YES);
    
    
    NSString *sql = @"select * from student1";
    NSMutableArray *result = [TItanSQLiteTool querySql:sql uid:nil];
    NSLog(@"%@", result);
    
}


- (void)testTable {
    Class clas = NSClassFromString(@"Student");
    BOOL res = [TitanModelSqliteTool createTable:clas uid:nil];
    XCTAssertEqual(res, YES);
}




@end
