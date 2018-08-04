//
//  TitanModelProtocol.swift
//  SwiftSQLiteDemo
//
//  Created by quanjunt on 2018/8/4.
//  Copyright © 2018年 quanjunt. All rights reserved.
//

import Foundation

protocol TitanModelProtocol {
    var modelProtocol: TitanModelProtocol? { get }
}

extension TitanModelProtocol {
    /// 操作模型必须实现的方法, 通过这个方法获取主键信息
    func primaryKey() -> String {
        return ""
    }
    
    /// 忽略的字段数组
    func ignoreColumnNames() -> [String] {
        return []
    }
    
    
    /// 新字段名称-> 旧的字段名称的映射表格
    func newNameToOldNameDic() -> [String: Any] {
        return [:]
    }
}
