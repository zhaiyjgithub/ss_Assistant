//
//  SS_CommentController.m
//  AVOSDemo
//
//  Created by chuck on 14-12-12.
//  Copyright (c) 2014年 秋权mac. All rights reserved.
//

#import "SS_CommentController.h"
#import "SS_CommentCell.h"

@interface SS_CommentController ()

@end

@implementation SS_CommentController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1; // 暂时只有一行，仅仅用于评论
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"SS_CommentCell";
    
    SS_CommentCell *cell = (SS_CommentCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[SS_CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return  cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //每次cell的高度的调整都是根据当前cell中的textview的高度来刷新高度
    SS_CommentCell *cell = (SS_CommentCell *)[tableView cellForRowAtIndexPath:indexPath];
    return  cell.commentTextView.contentSize.height;
}

@end
