
#import "SS_BaseModel.h"

@interface SS_DetailOfStoreModel : SS_BaseModel
@property(nonatomic,copy)NSString * Name;
@property(nonatomic,copy)NSString * phone_host;
@property(nonatomic,copy)NSString * phone_dgut;
@property(nonatomic,copy)NSString * phone_gdmc;
@property(nonatomic,copy)NSString * phone_dgpt;
@property(nonatomic,copy)NSString * instruction;
@property(nonatomic,copy)NSString * key;


- (void)setModelwithModel:(SS_DetailOfStoreModel *)model;

//1,insert
+(void)insertDetailModel:(SS_DetailOfStoreModel*)detailModel;

//2.query

//where,1-id=9(id=9) 2-order(time desc/asc) 3.count=10
+(NSMutableArray*)queryDetailModelWithWhere:(id)where
                                    orderBy:(NSString*)order
                                      count:(NSInteger)count;


+(NSMutableArray*)queryDetailModelWithComplexSQL:(NSString*)SQL;

//3.update
/*
 A.易发改名大发
 B.newProperty=大发
 C.key=Name
 D.where(objectID=102321)
 */
+(void)updateDetailModel:(id)key
             oldProperty:(id)oldProperty
             newProperty:(id)newProperty;

+(void)updateDetailModel:(SS_DetailOfStoreModel*)detailModel
                                    where:(NSString*)where;

//4.dellete
+ (void)deleteDetailModel:(id)key property:(id)property;

//5
+ (void)deleteDetailModel:(SS_DetailOfStoreModel *)model;

//6
+ (void)deleteTableData: (Class)modelClass;
@end
