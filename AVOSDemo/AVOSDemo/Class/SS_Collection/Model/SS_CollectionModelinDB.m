//
//  SS_CollectionModelinDB.m
//  AVOSDemo
//
//  Created by chuck on 15-1-21.
//  Copyright (c) 2015年 秋权mac. All rights reserved.
//

#import "SS_CollectionModelinDB.h"

@implementation SS_CollectionModelinDB

//重写table函数，自动创建table，以当前为命名

+ (NSString *)getTableName
{
    return @"SS_CollectionModelinDB";
}

+ (void)insertCollectionModel:(SS_CollectionModelinDB *)inDBModel
{
    [[SS_CollectionModelinDB getUsingLKDBHelper] insertWhenNotExists:inDBModel];
}


+ (NSMutableArray *)queryCollectionModelWihtWhere:(id)where
                                          orderBy:(NSString *)order
                                            count:(NSUInteger)count
{
    return [SS_CollectionModelinDB searchWithWhere:where orderBy:order offset:0 count:count];
}

+ (NSMutableArray *)queryCollectionModelWihtComplexSQL:(NSString *)SQL
{
    return [[SS_CollectionModelinDB getUsingLKDBHelper] searchWithSQL:SQL toClass:[SS_CollectionModelinDB class]];
}

+ (void)deleteCollectionModel:(id)key property:(id)property
{
    [[SS_CollectionModelinDB getUsingLKDBHelper] executeDB:^(FMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM SS_DetailOfStoreModel where %@ = '%@'",key,property];
        [db executeUpdate:sql];
    }];
}

+ (void)deleteCollectionModel:(SS_CollectionModelinDB *)model
{
    BOOL ishas = [[SS_CollectionModelinDB getUsingLKDBHelper] isExistsModel:model];
    if (ishas) {
        [[SS_CollectionModelinDB getUsingLKDBHelper] deleteToDB:model];
    }
}

@end