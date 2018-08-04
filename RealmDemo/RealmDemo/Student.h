//
//  Student.h
//  RealmDemo
//
//  Created by quanjunt on 2018/7/30.
//  Copyright © 2018年 quanjunt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface Student : RLMObject

@property int num;
@property NSString *name;

@end
RLM_ARRAY_TYPE(Student)

