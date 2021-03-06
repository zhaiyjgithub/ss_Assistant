

#import "SS_BusinessAPITool.h"
#import "SS_BusinessModel.h"
#import "SS_DetailOfStoreModel.h"
#import "SS_CommentModel.h"

#define SS_GET_ALL_BUSINESS_API @""   
@implementation SS_BusinessAPITool
+(void)getAllBusiness:(NSString *)uid
              success:(HttpSuccessBlock)success
              failure:(HttpFailureBlock)failure{
    [HttpTool getWithPath:uid params:nil success:^(id result) {//底层修改为使用uid来发起请求
        if (!result) {
            success (nil);
            return;
        }
        NSArray * busArray = result[@"results"];//AVOS的返回确定的key== results;
        NSMutableArray * arrayM = [NSMutableArray array];
        for (NSDictionary * dic in busArray) {
            //修改为当前新的数据模型，后面该函数需要重构一下
            SS_DetailOfStoreModel * bM=[[SS_DetailOfStoreModel alloc]initWithDictionary:dic];
            //[SS_DetailOfStoreModel insertDetailModel:bM];//不能当前使用，必须通过引用的方式修改
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

+(void)getAllBusinessWithCommentModel:(NSString *)uid
              success:(HttpSuccessBlock)success
              failure:(HttpFailureBlock)failure{
    [HttpTool getWithPath:uid params:nil success:^(id result) {//底层修改为使用uid来发起请求
        if (!result) {
            success (nil);
            return;
        }
        NSArray * busArray = result[@"results"];//AVOS的返回确定的key== results;
        NSMutableArray * arrayM = [NSMutableArray array];
        for (NSDictionary * dic in busArray) {
            //修改为当前新的数据模型，后面该函数需要重构一下
            SS_CommentModel * bM=[[SS_CommentModel alloc] initWithDictionary:dic];
            [arrayM addObject:bM];
        }
        success(arrayM);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


@end


