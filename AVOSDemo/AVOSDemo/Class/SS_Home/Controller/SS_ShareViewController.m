//
//  SS_ShareViewController.m
//  AVOSDemo
//
//  Created by chuck on 15-1-31.
//  Copyright (c) 2015年 秋权mac. All rights reserved.
//

#import "SS_ShareViewController.h"
#import "MBProgressHUD+MJ.h"
#import "AFNetworking.h"
#import "WBaccountTool.h"

// 5.获得RGB颜色
#define kColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]


#define SEND_WEIBO_URL  @"https://api.weibo.com/2/statuses/update.json"
#define SEND_WEIBO_WITH_IMAGE_URL   @"https://upload.api.weibo.com/2/statuses/upload.json"

@interface SS_ShareViewController () <UIActionSheetDelegate>

@end

@implementation SS_ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableBar];
    [self setupShareTextView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self.shareTextView becomeFirstResponder];
}

- (void)setupTableBar
{
    self.title = @"分享至微博";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelToSend)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(confirmToSend)];
}

- (void)cancelToSend
{
    [self.shareTextView resignFirstResponder];
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"是否放弃已编辑内容" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"放弃编辑" otherButtonTitles:nil, nil];
    [actionSheet showInView:self.view];
}

- (void)confirmToSend
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [WBaccountTool account].access_token;
    params[@"status"] = self.shareTextView.text;
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    /*
    [manager POST:SEND_WEIBO_URL parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
       // NSLog(@"send successfully:%@",responseObject);
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error:%@",error);
    }];
     */
    
    //上传图片需要使用另外一个POST方法
    [manager POST:SEND_WEIBO_WITH_IMAGE_URL parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSData * imageData = UIImagePNGRepresentation(self.imageToUpLoad.image);
        [formData appendPartWithFileData:imageData name:@"pic" fileName:@"ss" mimeType:@"image/png"];
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
        NSLog(@"error:%@",error);
    }];
    
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupShareTextView
{
    UITextView * textView = [[UITextView alloc] init];
    textView.frame = self.view.frame;
    textView.font = [UIFont systemFontOfSize:16.0];
    textView.textColor = [UIColor lightGrayColor];
    textView.text = @"我正在使用SS_Asistant: ";
    self.shareTextView = textView;
    [self.view addSubview:textView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:self.shareTextView];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.navigationItem.rightBarButtonItem.tintColor = kColor(0xeb, 0xeb, 0xeb);
}

/*
 *如果没有任何输入，就会失能发送按钮
 */
- (void)textChange
{
    if(self.shareTextView.text.length != 0){
        self.shareTextView.textColor = [UIColor blackColor];
        self.navigationItem.rightBarButtonItem.enabled = YES;
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    }else{
        self.shareTextView.textColor = [UIColor lightGrayColor];
        self.shareTextView.text = nil;
        self.navigationItem.rightBarButtonItem.enabled = NO;
        self.navigationItem.rightBarButtonItem.tintColor = kColor(0xeb, 0xeb, 0xeb);
    }
}

/*
 *移除
 */
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == [actionSheet destructiveButtonIndex]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}





@end
