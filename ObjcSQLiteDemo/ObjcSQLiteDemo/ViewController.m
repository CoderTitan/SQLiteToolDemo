//
//  ViewController.m
//  ObjcSQLiteDemo
//
//  Created by quanjunt on 2018/7/25.
//  Copyright © 2018年 quanjunt. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *dic = @{
                          @"d": @"real", // double
                          @"f": @"real", // float
                          
                          @"i": @"integer",  // int
                          @"q": @"integer", // long
                          @"Q": @"integer", // long long
                          @"B": @"integer", // bool
                          
                          @"NSData": @"blob",
                          @"NSDictionary": @"text",
                          @"NSMutableDictionary": @"text",
                          @"NSArray": @"text",
                          @"NSMutableArray": @"text",
                          
                          @"NSString": @"text"
                          };
    NSMutableArray *result = [NSMutableArray array];
    [dic enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *obj, BOOL * _Nonnull stop) {
        [result addObject:[NSString stringWithFormat:@"%@ %@", key, obj]];
    }];
    
    NSString *str = [result componentsJoinedByString:@","];
    NSLog(@"%@", str);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
