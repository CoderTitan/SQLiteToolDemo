//
//  TitanModelProtocol.h
//  ObjcSQLiteDemo
//
//  Created by quanjunt on 2018/7/25.
//  Copyright © 2018年 quanjunt. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TitanModelProtocol <NSObject>

@required
+ (NSString *)primaryKey;

@optional
+ (NSArray *)ignoreColumnNames;


@end
