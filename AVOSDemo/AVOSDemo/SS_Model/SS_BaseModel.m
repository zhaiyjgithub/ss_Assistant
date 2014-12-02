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
        [self setKeyValues:dic];
    }
    return self;
}
@end
