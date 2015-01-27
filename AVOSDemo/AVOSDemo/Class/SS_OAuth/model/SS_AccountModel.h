//
//  accountModel.h
//  AVOSDemo
//
//  Created by chuck on 15-1-27.
//  Copyright (c) 2015年 秋权mac. All rights reserved.
//

#import "SS_BaseModel.h"
//要为自定义的数据类型添加归档，需要添加NSCoding协议并重写对应的方法
@interface SS_AccountModel : NSObject <NSCoding>
//access_token
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

- (void)initWithRespondObject:(id)object;
@end
