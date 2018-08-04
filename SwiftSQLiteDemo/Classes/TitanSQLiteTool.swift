//
//  TitanSQLiteTool.swift
//  SwiftSQLiteDemo
//
//  Created by quanjunt on 2018/8/3.
//  Copyright © 2018年 quanjunt. All rights reserved.
//

import Foundation
import SQLite3

// 数据库指针属性
fileprivate var titanDb: OpaquePointer? = nil
class TitanSQLiteTool {
    
    /**
     处理sql语句包括增删改记录, 创建删除表格等无结果集操作
     
     @param sql sql语句
     @param uid 用户唯一标示
     @return 是否处理成功
     */
    @discardableResult
    class func dealSqlite(sql: String, uid: String?) -> Bool {
        //1. 打开数据库
        if !openDB(uid: uid) {
            print("打开数据库失败")
            return false
        }
        
        //2. 执行语句
        let res = sqlite3_exec(titanDb, sql.cString(using: .utf8), nil, nil, nil) == SQLITE_OK
        
        //4. 关闭数据库
        closeDB()
        return res
    }
    
    
    /**
     同时处理多条语句, 并使 事物进行包装
     
     @param sqls sql语句数组
     @param uid 用户的唯一表示
     @return 是否全部处理成功, 如果有一条没有处理成功则会进行回滚操作
     */
    class func dealSqliteArray(sqls: [String], uid: String) -> Bool {
        //1. 开始执行
        beginTransaction(uid: uid)
        
        //2. 遍历所有语句
        for sql in sqls {
            let res = dealSqlite(sql: sql, uid: uid)
            if !res {
                //如果有一条语句出现错误, 则全部语句失败, 回滚数据
                rollbackTransaction(uid: uid)
                return false
            }
        }
        
        //所有语句执行成功, 提交
        commitTransaction(uid: uid)
        
        return true
    }
    
    
    /**
     查询语句, 返回结果集
     
     @param sql sql语句
     @param uid 用户唯一标识
     @return 字典(一行记录)组成的数组
     */
    class func querySqlite(sql: String, uid: String) -> [[String: Any]]? {
        //1. 打开数据库
        if !openDB(uid: uid) {
            print("打开数据库失败")
            return nil
        }
        
        //2. 创建准备语句
        /**
         sqlite3_prepare_v2
         参数1: 一个已经打开的数据库
         参数2: 需要中的sql
         参数3: 参数2取出多少字节的长度 -1 自动计算
         参数4: 准备语句
         参数5: 通过参数3, 取出参数2的长度字节之后, 剩下的字符串
         */
        var ppStmt: OpaquePointer?
        let result = sqlite3_prepare_v2(titanDb, sql.cString(using: .utf8), -1, &ppStmt, nil) == SQLITE_OK
        if !result {
            print("准备语句编译失败")
            return nil
        }
        
        //3. 绑定数据
        
        //4. 执行
        //创建存储字典的大数组
        var rowDicArr = [[String: Any]]()
        //SQLITE_ROW: 代表下一行还有数据
        while sqlite3_step(ppStmt) == SQLITE_ROW {
            // 一行记录 -> 字典
            // 4-1. 获取所有列的个数
            let columnCount = sqlite3_column_count(ppStmt)
            
            //创建存储每一行数据的字典
            var rowDic = [String: Any]()
            
            //4-2. 遍历所有的列
            for i in 0..<columnCount {
                //4-2-1. 获取列名
                //参数一: 准备语句, 参数二: 索引
                guard let columnNameC = sqlite3_column_name(ppStmt, i) else { continue }
                let columnname = String(cString: columnNameC)
                
                //4-2-2. 获取列值
                // 不同列的数据类型, 使用不同的函数进行获取
                //获取列的数据类型
                let type = sqlite3_column_type(ppStmt, i)
                
                //获取列的值
                var value: Any?
                switch (type) {
                case SQLITE_INTEGER:
                    value = sqlite3_column_int(ppStmt, i)
                    break;
                case SQLITE_FLOAT:
                    value = sqlite3_column_double(ppStmt, i)
                    break;
                case SQLITE_BLOB:
                    //sqlite3_column_blob: 返回时void
                    //CFBridgingRelease: 把一个值转成id类型
                    value = Int(bitPattern: sqlite3_column_blob(ppStmt, i))
                    break;
                case SQLITE_NULL:
                    value = ""
                    break;
                case SQLITE_TEXT:
                    value = String(cString: sqlite3_column_text(ppStmt, i))
                    break;
                default:
                    break;
                }
                
                //写入字典
                rowDic[columnname] = value
            }
            
            rowDicArr.append(rowDic)
        }
        
        //5. 重置
        
        //6. 释放资源
        sqlite3_finalize(ppStmt);
        
        //7. 关闭数据库
        closeDB()
        
        return rowDicArr
    }
}


// MARK: 关于事物的操作
extension TitanSQLiteTool {
    /// 开始操作
    class fileprivate func beginTransaction(uid: String?) {
        dealSqlite(sql: "begin reansaction", uid: uid)
    }
    
    /// 提交操作
    class fileprivate func commitTransaction(uid: String?) {
        dealSqlite(sql: "begin reansaction", uid: uid)
    }
    
    /// 回滚操作
    class fileprivate func rollbackTransaction(uid: String?) {
        dealSqlite(sql: "begin reansaction", uid: uid)
    }
}

// MARK: 私有方法
extension TitanSQLiteTool {
    /// 打开数据库
    @discardableResult
    class fileprivate func openDB(uid: String?) -> Bool {
        //1. 路径
        let dbStr = uid ?? ""
        let dbName = dbStr.isEmpty ? "common.sqlite" : dbStr + ".sqlite"
        
        //2.拼接路径
        let dbPath = "\(kCachePath)" + dbName
        
        //3. 打开数据库
        return sqlite3_open(dbPath.cString(using: .utf8), &titanDb) == SQLITE_OK
    }
    
    /// 关闭数据库
    class fileprivate func closeDB() {
        sqlite3_close(titanDb)
    }
}
