//
//  SS_BaseModel.m
//  AVOSDemo
//
//  Created by 秋权mac on 14-11-25.
//  Copyright (c) 2014年 秋权mac. All rights reserved.
//

#import "SS_BaseModel.h"

@implementation SS_BaseModel
-(instancetype)initWithDictionary:(NSDictionary*)dic{

    if (self=[super init]) {
        [self setKeyValues:dic];//使用了数据字典转模型数据的方法。方法封装好，方便使用
    }
    return self;
}

//重载选择 使用的LKDBHelper
+(LKDBHelper *)getUsingLKDBHelper
{
    static LKDBHelper* db;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString* dbpath = [NSHomeDirectory() stringByAppendingPathComponent:@"DB/SS.sqlite"];
        NSLog(@"路径:%@",dbpath);
        db = [[LKDBHelper alloc]initWithDBPath:dbpath];
        //or
        //        db = [[LKDBHelper alloc]init];
    });
    return db;
}@end
