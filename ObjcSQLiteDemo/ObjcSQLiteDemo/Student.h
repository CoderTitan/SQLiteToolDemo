//
//  Student.h
//  ObjcSQLiteDemo
//
//  Created by quanjunt on 2018/7/25.
//  Copyright © 2018年 quanjunt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TitanModelProtocol.h"

@interface Student : NSObject<TitanModelProtocol>

@property (nonatomic, assign) int stuNum;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) int age2;
@property (nonatomic, assign) float score;

@end
