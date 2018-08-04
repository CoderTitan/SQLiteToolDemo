//
//  ViewController.m
//  RealmDemo
//
//  Created by quanjunt on 2018/7/30.
//  Copyright © 2018年 quanjunt. All rights reserved.
//

#import "ViewController.h"
#import <Realm/Realm.h>
#import "Student.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    
    
}


/// 写入数据的方式
- (void)creatStudent {
    //初始化模型的方式
    //两种方式, 字典和数组
    //    Student *stu1 = [[Student alloc]initWithValue:@[@1, @"jun"]];
    Student *stu2 = [[Student alloc]initWithValue:@{@"num": @2, @"name":@"titan"}];
    
    //获取Realm对象
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    //写入方式
    /**
     方式一:
     //开始写入事务
     [realm beginWriteTransaction];
     //添加模型对象
     [realm addObject:stu1];
     //提交写入事务
     [realm commitWriteTransaction];
     */
    
    //方式二:
        [realm transactionWithBlock:^{
            //添加模型
            [realm addObject:stu2];
        }];
    
    
    //方式三:
    [realm transactionWithBlock:^{
        //添加模型
        [Student createInRealm:realm withValue:@{@"num": @3, @"name":@"coder"}];
    }];
}


/// 更新指定数据
- (void)updateStudent {
    
}
@end
