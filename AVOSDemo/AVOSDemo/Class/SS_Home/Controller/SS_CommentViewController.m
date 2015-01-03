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

@interface SS_CommentViewController ()

@end

@implementation SS_CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavigationBar];
    [self setTextView];
    _commentModel.commentPoster = @"Zack";
    _commentModel.commentClassName = _commentClassName;
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
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)send
{
    //[self.navigationController popViewControllerAnimated:YES];
    
    NSLog(@"_commentClassName:%@",_commentClassName);
    NSDictionary *commentDic = @{@"poster":@"Zack",
                                 @"comment":_commentTextview.text,
                                 @"commentClassName":_commentClassName};
    
    NSLog(@"commentDic:%@",commentDic);
    NSString *path = [NSString stringWithFormat:@"%@/%@",BASEURL,_commentClassName];
    
    NSLog(@"post path:%@",path);
//    
//    [HttpTool postWithPath:path params:commentDic success:^(id result) {
//        NSLog(@"post successfully");
//    } failure:^(NSError *error) {
//        NSLog(@"post failed");
//    }];
    
    [self.commentTextview resignFirstResponder];
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"1" delegate:self cancelButtonTitle:@"2" destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    
    [actionSheet showInView:self.view];
}

- (void)setTextView
{
    SS_SendComment *view = [[SS_SendComment alloc] init];
    view.frame = self.view.bounds;//设置textview的大小。系统会自动拉下64个点
    [self.view addSubview:view];
    self.commentTextview = view;

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:self.commentTextview];
}
/*
    *如果没有任何输入，就会失能发送按钮
 */
- (void)textChange
{
    self.navigationItem.rightBarButtonItem.enabled = (self.commentTextview.text.length != 0);
}
/*
 *移除
 */
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
