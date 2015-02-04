//
//  SS_CollectionModelinDB.h
//  AVOSDemo
//
//  Created by chuck on 15-1-21.
//  Copyright (c) 2015年 秋权mac. All rights reserved.
//

#import "SS_BaseModel.h"

@interface SS_CollectionModelinDB : SS_BaseModel
//详情相关,还需要添加地址
@property(nonatomic,copy)NSString * storeName;
@property(nonatomic,copy)NSString * phoneHost;
@property(nonatomic,copy)NSString * phoneDgut;
@property(nonatomic,copy)NSString * phoneGdmc;
@property(nonatomic,copy)NSString * phoneDgpt;
@property(nonatomic,copy)NSString * instruction;
@property(nonatomic,copy)NSString * address;
@property(nonatomic,copy)NSString * key;
@property(nonatomic,copy)NSString * keyToDB;

//数据库接口API
+ (void)insertCollectionModel:(SS_CollectionModelinDB *)inDBModel;
+ (NSMutableArray *)queryCollectionModelWihtWhere:(id)where
                                          orderBy:(NSString *)order
                                            count:(NSUInteger)count;
+ (NSMutableArray *)queryCollectionModelWihtComplexSQL:(NSString *)SQL;
+ (NSMutableArray *)queryCollectionModelWithWhere:(id)key property:(id)property;
+ (void)deleteCollectionModel:(id)key property:(id)property;
+ (void)deleteCollectionModel:(SS_CollectionModelinDB *)model;

@end
