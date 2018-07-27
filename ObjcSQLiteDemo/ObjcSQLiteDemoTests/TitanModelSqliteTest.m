//
//  TitanModelSqliteTest.m
//  ObjcSQLiteDemoTests
//
//  Created by quanjunt on 2018/7/25.
//  Copyright © 2018年 quanjunt. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TitanModelTool.h"
#import "Student.h"

@interface TitanModelSqliteTest : XCTestCase

@end

@implementation TitanModelSqliteTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testIvarNameType {
    NSString *dicStr = [TitanModelTool columnNamesAndTypesStr:[Student class]];
    NSLog(@"%@", dicStr);
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
