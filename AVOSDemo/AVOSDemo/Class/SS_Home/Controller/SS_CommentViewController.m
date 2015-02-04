//
//  SS_CommentViewController.m
//  AVOSDemo
//
//  Created by chuck on 14-12-18.
//  Copyright (c) 2014年 秋权mac. All rights reserved.
//

#import "SS_CommentViewController.h"
#import "SS_SendComment.h"
#import "HttpTool.h"
#import "MBProgressHUD+MJ.h"
#import "WBaccountTool.h"

// 5.获得RGB颜色
#define kColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]


@interface SS_CommentViewController ()

@end

@implementation SS_CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavigationBar];
    [self setTextView];
    //从当前归档中获取用户的信息即可
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    [self.commentTextview becomeFirstResponder];//作为键盘的第一响应者.如果没有添加就需要点击一下textview才能弹出虚拟键盘
}

- (void)setupNavigationBar
{
    self.title = @"发送评论";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
}

- (void)cancel
{
    //需要添加action sheet来作为一个提醒放弃已经编写的评论
    [self.commentTextview resignFirstResponder];
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"是否放弃已编辑内容" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"放弃编辑" otherButtonTitles:nil, nil];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    
    [actionSheet showInView:self.view];

   
}
- (void)send
{
    //[self.navigationController popViewControllerAnimated:YES];
    
    NSLog(@"_commentClassName:%@",_commentClassName);
    NSString * commentPoster = [WBaccountTool account].name;
    NSDictionary *commentDic = @{@"poster":commentPoster,
                                 @"comment":_commentTextview.text,
                                 @"commentClassName":_commentClassName};
    
    NSLog(@"commentDic:%@",commentDic);
    NSString *path = [NSString stringWithFormat:@"classes/%@",_commentClassName];
    
    NSLog(@"post path:%@",path);
    
    [HttpTool postWithPath:path params:commentDic success:^(id result) {
        NSLog(@"successfully");
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(NSError *error) {
        NSLog(@"error:%@",error);
    }];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setTextView
{
    SS_SendComment *view = [[SS_SendComment alloc] init];
    view.frame = self.view.bounds;//设置textview的大小。系统会自动拉下64个点
    view.font = [UIFont systemFontOfSize:16.0];
    self.commentTextview = view;
    [self.view addSubview:view];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:self.commentTextview];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.navigationItem.rightBarButtonItem.tintColor = kColor(0xeb, 0xeb, 0xeb);
}
/*
    *如果没有任何输入，就会失能发送按钮
 */


- (void)textChange
{
    if(self.commentTextview.text.length != 0){
        self.navigationItem.rightBarButtonItem.enabled = YES;
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    }else{
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
    if (buttonIndex == [actionSheet cancelButtonIndex]) {
        ;
    }else if (buttonIndex == [actionSheet destructiveButtonIndex]){
         [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == [alertView cancelButtonIndex]) {
        [self.commentTextview resignFirstResponder];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
