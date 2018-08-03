//
//  Student.m
//  ObjcSQLiteDemo
//
//  Created by quanjunt on 2018/7/25.
//  Copyright © 2018年 quanjunt. All rights reserved.
//

#import "Student.h"

@implementation Student

+ (NSString *)primaryKey {
    return @"stuNum";
}

+ (NSArray *)ignoreColumnNames {
    return @[@"b"];
}

+ (NSDictionary *)newNameToOldNameDic {
    //key: 新, value:旧
    return @{@"age2": @"age"};
}
@end
