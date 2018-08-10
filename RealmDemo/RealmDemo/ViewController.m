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
    
    NSLog(@"%@", NSHomeDirectory());
    
    // 写入数据的方式
//    [self creatStudent];
    
    
    //更新数据
//    [self updateStudent];
    
    
    //删除数据
//    [self deleteStudent];
    
    //查询数据
//    [self queryDates];
    
    
    //获取Realm对象
    RLMRealm *realm = [RLMRealm defaultRealm];
    Student *stu2 = [[Student alloc]initWithValue:@{@"num": @12, @"name":@"titan"}];
    [realm transactionWithBlock:^{
        [realm addOrUpdateObject:stu2];
    }];
    [realm transactionWithBlock:^{
        [Student createOrUpdateInRealm:realm withValue:@{@"num": @11, @"name":@"titan11"}];
    }];
}


/// 写入数据的方式
- (void)creatStudent {
    //初始化模型的方式
    //两种方式, 字典和数组
    //    Student *stu1 = [[Student alloc]initWithValue:@[@1, @"jun"]];
//    Student *stu2 = [[Student alloc]initWithValue:@{@"num": @2, @"name":@"titan"}];
//    Student *stu3 = [[Student alloc]init];
//    stu3.num = 3;
//    stu3.name = @"titanjun";
    
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
    for (int i = 0; i < 10; i++) {
        NSString *str = [NSString stringWithFormat:@"titan--%d", i];
        [realm transactionWithBlock:^{
            //添加模型
            [Student createInRealm:realm withValue:@{@"num": @(i), @"name": str}];
        }];
    }
    
    
    //方式三:
//    [realm transactionWithBlock:^{
//        //添加模型
//        [Student createInRealm:realm withValue:@{@"num": @3, @"name":@"coder"}];
//    }];
}


/// 更新指定数据
- (void)updateStudent {
    
    //获取Realm对象
    RLMRealm *realm = [RLMRealm defaultRealm];
    
//    Student *stu4 = [[Student alloc]initWithValue:@{@"num": @4, @"name":@"titan4"}];
//    //添加数据
//    // 这个模型stu, 已经被realm 所管理, 而且, 已经和磁盘上的对象, 进行的地址映射
//    [realm transactionWithBlock:^{
//        //添加模型
//        [realm addObject:stu4];
//    }];
//
//    // 这里修改的模型, 一定是被realm所管理的模型
//    [realm transactionWithBlock:^{
//        stu4.name = @"coder4";
//    }];
//
    
    RLMResults *results = [Student objectsWhere:@"num = 4"];
    Student *stu = results.firstObject;
    [realm transactionWithBlock:^{
        stu.name = @"titanking";
    }];
}

/// 删除数据
- (void)deleteStudent {
    //获取Realm对象
    RLMRealm *realm = [RLMRealm defaultRealm];
    // 删除的模型, 一定要求是被realm所管理的
    
    /*根据条件删除一条数据 */
    RLMResults *results = [Student objectsWhere:@"name = 'titanking'"];
    Student *titan1 = results.firstObject;
    [realm transactionWithBlock:^{
        [realm deleteObject:titan1];
    }];
    
    
    /*删除所有符合条件的数据
    RLMResults *results = [Student objectsWhere:@"name = 'coder'"];
    for (Student *stu in results) {
        [realm transactionWithBlock:^{
            [realm deleteObject:stu];
        }];
    }
    */
    
/*删除表中所有的数据
 [realm transactionWithBlock:^{
    [realm deleteAllObjects];
 }];
     */
    
    /*场景, 根据主键删除一个模型
     // 1. 根据主键, 查询到这个模型(这个模型, 就是被realm数据库管理的模型)
    Student *res = [Student objectInRealm:realm forPrimaryKey:@4];
    //2. 删除该模型
    [realm transactionWithBlock:^{
        [realm deleteObject:res];
    }];
    */
}


/// 查询数据
- (void)queryDates {
    /*
    //1. 获取所有数据
    RLMResults *resArr = [Student allObjects];
    NSLog(@"%@", resArr);

    //2. 添加一条数据
    RLMRealm *realm = [RLMRealm defaultRealm];
    Student *stu = [[Student alloc]initWithValue:@[@10, @"coder"]];
    [realm transactionWithBlock:^{
        [realm addObject:stu];
    }];

    //3. 一旦检索执行之后, RLMResults 将随时保持更新
    NSLog(@"%@", resArr);
     */
    
    //条件查询
    RLMResults *stuArr = [Student objectsWhere:@"num > 7"];
    NSLog(@"%@", stuArr);
    
    //排序
    //排序不会对原数组进行操作, 会返回一个新的数组
    RLMResults *stuArr2 = [stuArr sortedResultsUsingKeyPath:@"name" ascending:YES];
    NSLog(@"%@", stuArr2);
    
    
    //链式查询
    RLMResults *stuArr3 = [stuArr2 objectsWhere:@"num > 8"];
    //可以不断的根据上一个查询结果进行查询
    RLMResults *stuArr4 = [stuArr3 objectsWhere:@"num > 9"];
    NSLog(@"%@", stuArr4);
}
@end
