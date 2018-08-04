//
//  TitanModelTool.swift
//  SwiftSQLiteDemo
//
//  Created by quanjunt on 2018/8/4.
//  Copyright © 2018年 quanjunt. All rights reserved.
//

import UIKit

class TitanModelTool: TitanModelProtocol {
    var modelProtocol: TitanModelProtocol?
    
    /// 根据类名创建表名
    class func tableName(clas: AnyClass) -> String {
        return String(describing: clas)
    }
    
    
    /// 创建临时表的名字
    class func tempTableName(clas: AnyClass) -> String {
        return String(describing: clas) + "_tmp"
    }
    
    
    /// 获取所有的成员变量, 以及成员变量对应的类型
    class func classIvarNameTypeDic(clas: AnyClass) -> [String: Any] {
        //获取这个类的所有成员变量和类型
        var count: UInt32 = 0
        guard let varList = class_copyIvarList(clas, &count) else { return [:] }
        
        //用于存储的字典
        var nameTypeDic = [String: Any]()
        
        //获取忽略的字段
        var ignoreNames = [String]()
        if clas.responds(to: #selector(modelProtocol.ignoreColumnNames)) {
            ignoreNames = clas.ignoreColumnNames()
        }
    }
    
    
    
    /**
     获取所有的成员变量, 以及成员变量映射到数据库里面对应的类型
     */
    + (NSDictionary *)classIvarNameSqliteTypeDic:(Class)clas;
    
    
    
    /**
     将成员变量和类型拼接成sqlite字符串
     */
    + (NSString *)columnNamesAndTypesStr:(Class)clas;
    
    
    /**
     给所有的成员变量进行排序
     */
    + (NSArray *)allTableSortedIvarNames:(Class)clas;
}
