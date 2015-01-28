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
    self.name = object[@"name"];
    self.profile_image_url = object[@"profile_image_url"];
    self.idescription = object[@"idescription"];
    self.gender = object[@"gender"];
    self.location = object[@"loaction"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
        self.remind_id = [aDecoder decodeObjectForKey:@"remind_id"];
        self.uid  = [aDecoder decodeObjectForKey:@"uid"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.profile_image_url = [aDecoder decodeObjectForKey:@"profile_image_url"];
        self.idescription = [aDecoder decodeObjectForKey:@"idescription"];
        self.gender = [aDecoder decodeObjectForKey:@"gender"];
        self.location = [aDecoder decodeObjectForKey:@"location"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [aCoder encodeObject:self.remind_id forKey:@"remind_id"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.profile_image_url forKey:@"profile_image_url"];
    [aCoder encodeObject:self.idescription forKey:@"idescription"];
    [aCoder encodeObject:self.gender forKey:@"gender"];
    [aCoder encodeObject:self.location forKey:@"location"];
}

@end
