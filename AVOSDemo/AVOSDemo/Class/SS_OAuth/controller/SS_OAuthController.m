//
//  SS_OAuthController.m
//  AVOSDemo
//
//  Created by chuck on 15-1-27.
//  Copyright (c) 2015年 秋权mac. All rights reserved.
//

#import "SS_OAuthController.h"
#import "AFNetworking.h"
#import "SS_AccountModel.h"
#import "WBaccountTool.h"
#import "SS_MainViewController.h"

@interface SS_OAuthController ()<UIWebViewDelegate>

@end

@implementation SS_OAuthController

- (void)viewDidLoad
{
    [super viewDidLoad];
 //Do any additional setup after loading the view.

    UIWebView * webView = [[UIWebView alloc] init];
    webView.frame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y + 20, self.view.bounds.size.width, self.view.bounds.size.height - 20);
    webView.delegate = self;
    [self.view addSubview:webView];

    NSURL * url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=1358220159&redirect_uri=http://www.baidu.com"];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}
/**
 *  当webView发送一个请求之前都会先调用这个方法, 询问代理可不可以加载这个页面(请求)
 *
 *  @param request        <#request description#>
 *
 *  @return YES : 可以加载页面,  NO : 不可以加载页面
 */

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //页面加载之前先获得code，然后根据这个code来获得access token。
    //并根据token向新浪发起post请求

    NSString * urlString = request.URL.absoluteString;
    NSRange  range = [urlString rangeOfString:@"code="];
    if (range.length) {
        unsigned long loc = range.location + range.length;
        NSString *code = [urlString substringFromIndex:loc];
        // 5.发送POST请求给新浪,  通过code换取一个accessToken.每次code都是不一样的。
        [self accessTokenWithCode:code];
    }
    return YES;
}

#define BASE_TOKEN_URL  @"https://api.weibo.com/oauth2/access_token"

- (void)accessTokenWithCode:(NSString *)code
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"1358220159";
    params[@"client_secret"] = @"bf1fb6c46ad22c9b9b6be3bc115c485f";
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = @"www.baidu.com";

    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];

    [manager POST:BASE_TOKEN_URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        SS_AccountModel * accountModel = [[SS_AccountModel alloc] init];
        [accountModel initWithRespondObject:responseObject];
        [self getUserInfo:accountModel];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@",error);
    }];
}

#define WB_ACCOUNT_FILE_PATH   [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.arch"]
//为什么需要在baseURL中添加 ‘？ ’。否则，在真机调试过程中请求失败，但是再模拟器中加上与否不影响请求的数据。我擦！
- (void)getUserInfo:(SS_AccountModel *)accountModel
{
    SS_AccountModel * userInfoModel = [[SS_AccountModel alloc] init];
    userInfoModel.access_token = accountModel.access_token;
    userInfoModel.expires_in = accountModel.expires_in;
    userInfoModel.remind_id = accountModel.remind_id;
    userInfoModel.uid       = accountModel.uid;
    
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"access_token"] = userInfoModel.access_token;
    params[@"uid"] = userInfoModel.uid;
    
    AFHTTPSessionManager *managerSession = [AFHTTPSessionManager manager];
    managerSession.responseSerializer = [AFJSONResponseSerializer serializer];
    managerSession.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [managerSession GET:@"https://api.weibo.com/2/users/show.json?" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        userInfoModel.name = responseObject[@"name"];
        userInfoModel.profile_image_url = responseObject[@"profile_image_url"];
        userInfoModel.idescription = responseObject[@"description"];
        userInfoModel.gender       = responseObject[@"gender"];
        userInfoModel.location     = responseObject[@"location"];
        
        //归档用户信息，后面还需要头像的图片数据实现归档
        [NSKeyedArchiver archiveRootObject:userInfoModel toFile:WB_ACCOUNT_FILE_PATH];
        
        //跳转到主界面
        self.view.window.rootViewController = [[SS_MainViewController alloc] init];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error:%@",error);
    }];
}

@end
