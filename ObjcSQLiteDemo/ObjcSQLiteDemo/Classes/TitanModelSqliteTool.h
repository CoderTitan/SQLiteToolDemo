//
//  TitanModelSqliteTool.h
//  ObjcSQLiteDemo
//
//  Created by quanjunt on 2018/7/25.
//  Copyright © 2018年 quanjunt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TitanModelProtocol.h"

@interface TitanModelSqliteTool : NSObject

/**
 拼接创建表格的sql(拼接主键信息)
 */
+ (BOOL)createTable:(Class)clas uid:(NSString *)uid;

@end
