//
//  accountModel.m
//  AVOSDemo
//
//  Created by chuck on 15-1-27.
//  Copyright (c) 2015年 秋权mac. All rights reserved.
//

#import "SS_AccountModel.h"

@implementation SS_AccountModel
/*
 @property(nonatomic,copy)NSString * access_token;
 @property(nonatomic,copy)NSString * expires_in;
 @property(nonatomic,copy)NSString * remind_id;
 @property(nonatomic,copy)NSString * uid;
 //userInfo
 @property(nonatomic,copy)NSString * name;
 @property(nonatomic,copy)NSString * profile_image_url;//使用小头像图片
 @property(nonatomic,copy)NSString * idescription;
 @property(nonatomic,copy)NSString * gender;
 @property(nonatomic,copy)NSString * location;
 */

- (void)initWithRespondObject:(id)object
{
    self.access_token = object[@"access_token"];
    self.expires_in = object[@"expires_in"];
    self.remind_id = object[@"remind_id"];
    self.uid       = object[@"uid"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
        self.remind_id = [aDecoder decodeObjectForKey:@"remind_id"];
        self.uid  = [aDecoder decodeObjectForKey:@"uid"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [aCoder encodeObject:self.remind_id forKey:@"remind_id"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
}

@end
