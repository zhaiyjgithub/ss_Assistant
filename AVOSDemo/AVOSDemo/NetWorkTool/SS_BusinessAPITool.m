

#import "SS_BusinessAPITool.h"
#import "SS_BusinessModel.h"
#define SS_GET_ALL_BUSINESS_API @""   
@implementation SS_BusinessAPITool
+(void)getAllBusiness:(NSString *)uid
              success:(HttpSuccessBlock)success
              failure:(HttpFailureBlock)failure{

    
//    NSDictionary * params =@{@"uid":uid};
    [HttpTool getWithPath:@"classes/t_Business" params:nil success:^(id result) {
        
        if (!result) {
            success (nil);
            return;
        }
        NSArray * busArray = result[@"results"];
        NSMutableArray * arrayM = [NSMutableArray array];
        for (NSDictionary * dic in busArray) {
            SS_BusinessModel * bM=[[SS_BusinessModel alloc]initWithDictionary:dic];
            [arrayM addObject:bM];
        }
        success(arrayM);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

+(void)postAllBUsindess:(NSString *)className
                params:(NSDictionary *)params
                success:(HttpSuccessBlock)success
                failure:(HttpFailureBlock)failure{
    NSString *postPath = [[NSString alloc] initWithFormat:@"classes/%@",className];
    
    [HttpTool postWithPath:postPath params:params success:^(id result) {
        if (!result) {
            success(nil);
            return;
        }
        success(result);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}


@end


