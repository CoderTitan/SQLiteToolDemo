//
//  TitanTableToolTest.m
//  ObjcSQLiteDemoTests
//
//  Created by quanjunt on 2018/7/27.
//  Copyright © 2018年 quanjunt. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TitanTableTool.h"

@interface TitanTableToolTest : XCTestCase

@end

@implementation TitanTableToolTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    Class clas = NSClassFromString(@"Student");
    [TitanTableTool tableSortedColumnNames:clas uid:nil];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
