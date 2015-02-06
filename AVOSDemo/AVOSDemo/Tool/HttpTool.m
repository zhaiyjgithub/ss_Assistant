//
//  HttpTool.m
//  七栋空间
//
//  Created by 秋权mac on 14-10-29.
//  Copyright (c) 2014年 秋权mac. All rights reserved.
//

#import "HttpTool.h"
#import "AFNetworking.h"
#import "NSDate+JJ.h"
#import "NSString+JJ.h"

@implementation HttpTool


#pragma mark -上传图片
+(void)upLoadimage:(UIImage*)image
              path:(NSString*)path
             param:(NSDictionary*)param
           success:(HttpSuccessBlock)success
           failure:(HttpFailureBlock)failure{
    
    AFHTTPRequestOperationManager *httpManager = [AFHTTPRequestOperationManager manager];
    NSData * imageData=UIImageJPEGRepresentation(image, 1.0);
    
    [httpManager POST:path parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData name:@"head" fileName:@"jjjjjjjj.jpg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
        NSLog(@"失败原因:%@---%@",error,operation);
    }];
    
    
    
}
#pragma mark -GET
+ (void)getWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure{
    
    [HttpTool requestWithPath:path params:params success:success failure:failure method:@"GET"];
}
#pragma mark -POST
+ (void)postWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure{
    
    [HttpTool requestWithPath:path params:params success:success failure:failure method:@"POST"];
}

+ (void)headWithPath:(NSString *)path
              params:(NSDictionary *)params
             success:(HttpSuccessBlock)success
             failure:(HttpFailureBlock)failure{
    
    [HttpTool requestWithPath:path params:params success:success failure:failure method:@"HEAD"];
    
}
#pragma mark -设置网络照片到视图中
//+ (void)downloadImage:(NSString *)url place:(UIImage *)place imageView:(UIImageView *)imageView success:(imageSuccessBlock)success{
//
//
//
//    [imageView setImageWithURL:[NSURL URLWithString:url] placeholderImage:place options:SDWebImageLowPriority];
//
//
//
//}
#pragma mark -下载文件
+(void)downloadFile:(NSString *)fileURL{
    
    
    // NSURLRequest * urlRequset = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:fileURL]];
    
}

#pragma mark -辅助方法
#define AVOS_APP_ID     @"72907i3d7jby7f2k7dqcyh4zxha98vlam9bt5mfnaou9uub1"
#define AVOS_APP_KEY    @"4eqkwgix5tahmiqo0rvjtyhhyrexn73iyp2xb9jtsdpe1jlj"
#define AVOS_MASTER_KEY @"klvprm7xdmo39qy9mxetd2959tx7e4x6ykcbhm200d669p2y"


+ (void)requestWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure method:(NSString *)method
{
    
    
    //2.拼接完整请求参数
    NSMutableDictionary *allParams = [NSMutableDictionary dictionary];
    // a.拼接传进来的参数
    if (params) {
        [allParams setDictionary:params];
        //        if (UID) {
        //            [allParams addEntriesFromDictionary:@{USER_UID:UID}];
        //
        //        }
        //
    }
    
    
    
    
#pragma mark -开始POST +GET +PUT +DEL
    
    //1,config
    NSURLSessionConfiguration  * sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfiguration.timeoutIntervalForRequest=10;
    
////    [client setDefaultHeader:@"X-AVOSCloud-Application-Id" value:@"mdx1l0uh1p08tdpsk8ffn4uxjh2bbhl86rebrk3muph08qx7"];
////    //A.计算时间
//    NSString * now_time = [NSDate getTimeStampWith13Date:[NSDate date]];//
//    NSString * appKey=AVOS_MASTER_KEY;
//    NSString * fullStr =[NSString stringWithFormat:@"%@%@",now_time,appKey];
////    //B.生成MD5字符串
//    NSString * md5Key =[fullStr MD5Hash];
//    NSString * requestKey =[NSString stringWithFormat:@"%@,%@,%@",md5Key,now_time,AVOS_MASTER_KEY];
////
    
    NSDictionary *headDic =@{@"Content-Type":@"application/json",
                             @"X-AVOSCloud-Application-Id":AVOS_APP_ID,
                             @"X-AVOSCloud-Application-Key":AVOS_APP_KEY};
    
    [sessionConfiguration setHTTPAdditionalHeaders:headDic]; //增加HTTP header
    
    
    
    
    
    AFHTTPSessionManager * httpManager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:BASEURL] sessionConfiguration:sessionConfiguration];
    httpManager.responseSerializer =[AFJSONResponseSerializer serializer];
    httpManager.requestSerializer = [AFJSONRequestSerializer serializer];//当时没有添加上传的
    //出现了无法post的bug。但是新浪微博也是可以偶然成功
    
    
    //3.发送请求
    if ([method isEqualToString:@"GET"]) {
        
        NSURLSessionDataTask * getTask = [httpManager GET:path parameters:allParams success:^(NSURLSessionDataTask *task, id responseObject) {
            
            // NSLog(@"URL地址:%@",task.currentRequest);
            if (responseObject[@"success"]&&[responseObject[@"success"] isEqualToNumber:@(0)]) {
                success(nil);
                return;
            }
            success(responseObject);
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            //
            failure(error);
        }];
        
        [getTask resume];
        
        
    }else if ([method isEqualToString:@"POST"]){
        
        NSURLSessionDataTask * postTask = [httpManager POST:path parameters:allParams success:^(NSURLSessionDataTask *task, id responseObject) {
            //
            // NSLog(@"URL地址:%@",task.currentRequest);
            if (responseObject[@"success"]&&[responseObject[@"success"] isEqualToNumber:@(0)]) {
                success(nil);
                return;
            }
            success(responseObject);
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            //
            NSLog(@"URL错误:%@",error);
            failure(error);
        }];
        
        [postTask resume];
    }
    else if ([method isEqualToString:@"HEAD"]){
        
        NSURLSessionDataTask * postTask = [httpManager HEAD:path parameters:allParams success:^(NSURLSessionDataTask *task) {
            //
            success(task.response);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            //
            failure(error);
        }];
        [postTask resume];
        
    }
}


//上传图片,暂时支持JPEG/png两种格式
//也可以通过路径方式上传图片。只需要修改为appendPartWithFileURL,填入文件路径即可。
+ (void)uploadImageWithImageName:(NSString *)baseURL imageName:(NSString *)imageName
                    newImageName:(NSString *)newImageName
{
    NSURLSessionConfiguration *session = [NSURLSessionConfiguration defaultSessionConfiguration];
    session.timeoutIntervalForRequest = 20;
    
    NSDictionary *headerDic = @{@"Content-Type":@"image/png",
                                       @"X-AVOSCloud-Application-Id":AVOS_APP_ID,
                                       @"X-AVOSCloud-Application-Key":AVOS_APP_KEY};
    if ([imageName hasSuffix:@".jpg"]){
        [headerDic setValue:@"Content-Type" forKey:@"image/jpeg"];
    }
    [session setHTTPAdditionalHeaders:headerDic];
    NSData *imageData = nil;
    //获取图片数据
    UIImage *image = [UIImage imageNamed:imageName];
    if ([imageName hasSuffix:@".jpg"]){
        imageData = UIImageJPEGRepresentation(image, 1.0);
    }
    else{
        imageData = UIImagePNGRepresentation(image);
    }
    
    NSString *url = [baseURL stringByAppendingString:imageName];
    
    NSMutableURLRequest * request = [[AFHTTPRequestSerializer serializer]
        multipartFormRequestWithMethod:@"POST" URLString:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            [formData appendPartWithFileData:imageData name:@"file" fileName:newImageName mimeType:[headerDic objectForKey:@"Content-Type"]];
        } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc]
                                    initWithSessionConfiguration:session];
    
    NSProgress *progress = nil;
    
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:&progress completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@",error);
        }else{
            NSLog(@"%@-%@",response,responseObject);
        }
    }];
    
    [uploadTask resume];
}

//下载图片，下载的图片全部放在cache当中，每次先查找cache再进行网络请求
//e.g. @"http://ac-72907i3d.qiniudn.com/r4iUAgjhSgBeBAoLKWG1C2Vd8JvrkKdDJCL4wKIu.png"
//type:Content-Type== image/png
+ (void)downLoadImageWithURL:(NSString *)url Content_Type:(NSString *)type
{

    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];

    NSDictionary *headDic = @{@"Content-Type":type,
                              @"X-AVOSCloud-Application-Id":AVOS_APP_ID,
                              @"X-AVOSCloud-Application-Key":AVOS_APP_KEY
                              };
    [configuration setHTTPAdditionalHeaders:headDic];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];

    NSURL *URL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];

    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"File downloaded to: %@", filePath);
    }];

    [downloadTask resume];
}



@end
