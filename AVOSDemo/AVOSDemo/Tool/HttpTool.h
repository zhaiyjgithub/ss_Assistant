//
//  HttpTool.h
//  七栋空间
//
//  Created by 秋权mac on 14-10-29.
//  Copyright (c) 2014年 秋权mac. All rights reserved.
//

#import <Foundation/Foundation.h>

#define BASEURL @"https://leancloud.cn:443/1"
#define IMAGE_BASE_URL   @"https://leancloud.cn:443/1/files/"



@interface HttpTool : NSObject



typedef void(^HttpSuccessBlock)(id result);
typedef void(^HttpFailureBlock)(NSError * error);
typedef void(^imageSuccessBlock)(CGSize imageSize);

/**
 *  根据URL路径跟请求参数完成GET请求
 *
 *  @param path         详细路径
 *  @param param        请求参数
 *  @param successBlock 请求成功
 *  @param failureBlock 请求失败
 */
+ (void)getWithPath:(NSString *)path
             params:(NSDictionary *)params
            success:(HttpSuccessBlock)success
            failure:(HttpFailureBlock)failure;

/**
 *  根据URL路径跟请求参数完成GET请求
 *
 *  @param path         详细路径
 *  @param param        请求参数
 *  @param successBlock 请求成功
 *  @param failureBlock 请求失败
 */

+ (void)postWithPath:(NSString *)path
              params:(NSDictionary *)params
             success:(HttpSuccessBlock)success
             failure:(HttpFailureBlock)failure;





+ (void)headWithPath:(NSString *)path
              params:(NSDictionary *)params
             success:(HttpSuccessBlock)success
             failure:(HttpFailureBlock)failure;

//- (NSURLSessionDataTask *)HEAD:(NSString *)URLString
//                    parameters:(NSDictionary *)parameters
//                       success:(void (^)(NSURLSessionDataTask *task))success
//                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 *  下载资源文件
 *
 *  @param fileURL 文件路径
 */
+(void)downloadFile:(NSString *)fileURL;

/**
    使用URLSession上传图片
 */
+(void)upLoadimage:(UIImage*)image
              path:(NSString*)path
             param:(NSDictionary*)param
           success:(HttpSuccessBlock)success
           failure:(HttpFailureBlock)failure;

+ (void)uploadImageWithImageName:(NSString *)baseURL imageName:(NSString *)imageName
                    newImageName:(NSString *)newImageName;

+ (void)downLoadImageWithURL:(NSString *)url Content_Type:(NSString *)type;
@end
