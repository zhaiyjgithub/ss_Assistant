//
//  SS_DetailOfStoreModel.m
//  AVOSDemo
//
//  Created by chuck on 14-12-7.
//  Copyright (c) 2014年 秋权mac. All rights reserved.
//

#import "SS_DetailOfStoreModel.h"

@implementation SS_DetailOfStoreModel


//1,insert
+(void)insertDetailModel:(SS_DetailOfStoreModel*)detailModel{
    //A.查询->如果无此数据-插入 B.有数据，更新或者不作为
    [SS_DetailOfStoreModel insertWhenNotExists:detailModel];
}

//2.query

//where,1-id=9(id=9) 2-order(time desc/asc) 3.count=10
+(NSMutableArray*)queryDetailModelWithWhere:(NSString*)where
                                    orderBy:(NSString*)order
                                      count:(NSInteger)count{
//    //A.查询无这个表，创表
//    NSString * tableName =NSStringFromClass([SS_DetailOfStoreModel class]);
//    if ([[SS_BaseModel getUsingLKDBHelper]isExistsWithTableName:tableName where:nil]) {
//    }
  return   [SS_DetailOfStoreModel searchWithWhere:where orderBy:order offset:0 count:count];
}


+(NSMutableArray*)queryDetailModelWithComplexSQL:(NSString*)SQL{

    return [[SS_BaseModel getUsingLKDBHelper]searchWithSQL:SQL toClass:[SS_DetailOfStoreModel class]];
    
}

//3.update
/*
 A.易发改名大发
 B.newProperty=大发
 C.key=Name
 D.where(objectID=102321)
 */
+(void)updateDetailModel:(id)newProperty
                     key:(id)key
                   where:(NSString*)where{

    [[SS_BaseModel getUsingLKDBHelper]executeDB:^(FMDatabase *db) {
        NSString * sql = [NSString stringWithFormat:@"UPDATE SS_DetailOfStoreModel SET %@ = %@ where %@",key,newProperty,where];
        [db executeUpdate:sql];

    }];

}

+(void)updateDetailModel:(SS_DetailOfStoreModel*)detailModel
                   where:(NSString*)where{
    
    [SS_DetailOfStoreModel updateToDB:detailModel where:where];

}

//4.del
@end
