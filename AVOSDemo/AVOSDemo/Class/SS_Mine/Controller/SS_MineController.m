//
//  SS_MineController.m
//  AVOSDemo
//
//  Created by 秋权mac on 14-11-25.
//  Copyright (c) 2014年 秋权mac. All rights reserved.
//

#import "SS_MineController.h"
#import "AFNetworking.h"

@interface SS_MineController () <UIWebViewDelegate>

@end

@implementation SS_MineController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIWebView * webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
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
        NSLog(@"rang:%@",NSStringFromRange(range));
        int loc = range.location + range.length;
        NSString *code = [urlString substringFromIndex:loc];
        NSLog(@"code:%@",code);
        // 5.发送POST请求给新浪,  通过code换取一个accessToken
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
        NSLog(@"successfully");
        NSLog(@"respondObject:%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failed");
        NSLog(@"error:%@",error);
    }];
    //同样可以使用session来代替operation发起post请求
}


@end
