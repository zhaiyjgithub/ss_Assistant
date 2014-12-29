//
//  SS_DetailOfStoreModel.m
//  AVOSDemo
//
//  Created by chuck on 14-12-7.
//  Copyright (c) 2014年 秋权mac. All rights reserved.
//

#import "SS_DetailOfStoreModel.h"

@implementation SS_DetailOfStoreModel

- (void)setModelwithModel:(SS_DetailOfStoreModel *)model
{
    self.Name = model.Name;
    self.phone_host = model.phone_host;
    self.phone_dgut = model.phone_dgut;
    self.phone_gdmc = model.phone_gdmc;
    self.phone_dgpt = model.phone_dgpt;
    self.instruction = model.instruction;
    self.key         = model.key;
}

//1,insert
+(void)insertDetailModel:(SS_DetailOfStoreModel*)detailModel{
    //A.查询->如果无此数据-插入 B.有数据，更新或者不作为
    [SS_DetailOfStoreModel insertWhenNotExists:detailModel];
}

//2.query

//where,1-id=9(id=9) 2-order(time desc/asc) 3.count=10
//where== 传递一个字典数据也可以按照SQL语句的where一样传递一个“name = ?”字符串，其中可以包含多个变量
//使用字符串会更加直接一些，减小字典的编写麻烦
//但是出现不适用字典会导致莫名其妙的bug.
+(NSMutableArray*)queryDetailModelWithWhere:(id)where
                                    orderBy:(NSString*)order
                                      count:(NSInteger)count{
//    //A.查询无这个表，创表
//    NSString * tableName =NSStringFromClass([SS_DetailOfStoreModel class]);
//    if ([[SS_BaseModel getUsingLKDBHelper]isExistsWithTableName:tableName where:nil]) {
//    }
  return   [SS_DetailOfStoreModel searchWithWhere:where orderBy:order offset:0 count:count];
}

/*
  *编写复杂的SQL语句来查询
 */
+(NSMutableArray*)queryDetailModelWithComplexSQL:(NSString*)SQL{

    return [[SS_BaseModel getUsingLKDBHelper]searchWithSQL:SQL toClass:[SS_DetailOfStoreModel class]];
    
}

//3.update
/*
 A.易发改名大发
 B.newProperty=大发
 C.key=Name
 D.where(objectID=102321)
  ******
   **重要更新：下面的SQL语句按照之前的格式是无法成功更新数据，因为导致无法正确解析SQL语句
   当前，column是没有单引号，而属性是需要单引号的。其他方式会提示:no such column错误，是因为column添加了单引号。
 ********
 */

+(void)updateDetailModel:(id)key
             oldProperty:(id)oldProperty
             newProperty:(id)newProperty
{
    [[SS_DetailOfStoreModel getUsingLKDBHelper] executeDB:^(FMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"UPDATE SS_DetailOfStoreModel SET %@ = '%@' where %@ = '%@'",key,newProperty,key,oldProperty];
       [db executeUpdate:sql];
    }];
}
/*
 *直接更新整个数据模型,发现上面的无法更新。暂时无法找出原因，可能是SQL语句的原因导致
 *按照当前的方式。如果直接饮用SQL某一个rowid的值，那么where == nil
 *如果需要更新其他rowid的数据，需要alloc 一个新的 model，然后填充该model的数据而不能直接引用。这样才能使用where= @"rowid = 3"
 */
+(void)updateDetailModel:(SS_DetailOfStoreModel*)detailModel
                   where:(NSString*)where{
    
    [SS_DetailOfStoreModel updateToDB:detailModel where:where];

}

//4.delete by the property

+ (void)deleteDetailModel:(id)key property:(id)property
{
    //[db executeUpdate:@"DELETE FROM Personlist WHERE name = ?",@"chuck"];
    [[SS_DetailOfStoreModel getUsingLKDBHelper] executeDB:^(FMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM SS_DetailOfStoreModel where %@ = '%@'",key,property];
        
        [db executeUpdate:sql];
    }];
}


// delete the model
+ (void)deleteDetailModel:(SS_DetailOfStoreModel *)model
{
    BOOL ishas = [[SS_DetailOfStoreModel getUsingLKDBHelper] isExistsModel:model];
    if (ishas) {
        [[SS_DetailOfStoreModel getUsingLKDBHelper] deleteToDB:model];
    }
}


//[SS_DetailOfStoreModel deleteTableData:[SS_DetailOfStoreModel class]];
//清空整个表中某一个模型的数据
+ (void)deleteTableData: (Class)modelClass
{
    [LKDBHelper clearTableData:modelClass];
}
                           




@end
