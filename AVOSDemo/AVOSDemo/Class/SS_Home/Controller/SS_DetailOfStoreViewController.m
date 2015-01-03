//
//  SS_DetailOfStoreViewController.m
//  AVOSDemo
//
//  Created by chuck on 14-12-7.
//  Copyright (c) 2014年 秋权mac. All rights reserved.
//

#import "SS_DetailOfStoreViewController.h"
#import "SS_DetailOfStoreCell.h"
#import "phoneCell.h"
#import "SS_CommentCell.h"
#import "SS_CommentViewController.h"
#import "MJRefresh.h"
#import "controllerCommon.h"
#import "titleCell.h"
#import "SS_BusinessAPITool.h"


@interface SS_DetailOfStoreViewController ()
{
    int countOfPhone;
}

@property(nonatomic,assign)CGFloat cellHeight;
@end

@implementation SS_DetailOfStoreViewController


- (void)viewWillAppear:(BOOL)animated
{
    //加载网络的评论数据,先加载0-15个评论
    SS_DetailOfStoreModel *model = self.dataSource[0];
    NSString *commentClassNamePath = [NSString stringWithFormat:@"classes/%@",model.commentClassName];
    //NSLog(@"评论的路径名称:%@",commentClassNamePath);
    //发起连接
    
    [SS_BusinessAPITool getAllBusinessWithCommentModel:commentClassNamePath success:^(id result) {
        if (result) {
            NSArray * array = result;
            self.commentDataSource = [NSMutableArray arrayWithArray:array];
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        [SS_BusinessAPITool getAllBusinessWithCommentModel:commentClassNamePath success:^(id result) {
            NSLog(@"再次请求成功");
            if (result) {
                NSArray * array = result;
                self.commentDataSource = [NSMutableArray arrayWithArray:array];
                [self.tableView reloadData];
            }
        } failure:^(NSError *error) {
            NSLog(@"再次请求失败");
        }];
    }];
}

#pragma mark - TODO,加载评论数据,加载的数量后面要修改
- (void)viewDidLoad
{
    [super viewDidLoad];//没有先加载父类，就会导致黑屏挂掉
   
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(tableviewCellLongPressed:)];
    
    longPress.delegate = self;//当前VC需要添加手势事件的协议<UIGestureRecognizerDelegate>
    longPress.minimumPressDuration = 1.0;
    [self.tableView addGestureRecognizer:longPress];
    
    SS_DetailOfStoreModel *model = self.dataSource[0];//根据内容选择显示cell的数目
    if([model.phoneDgpt isEqualToString:@"-"]) countOfPhone+=1;
    if([model.phoneGdmc isEqualToString:@"-"]) countOfPhone+=1;
    if([model.phoneDgut isEqualToString:@"-"]) countOfPhone+=1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)   return 1;
    else if(section == 1)  return (3-countOfPhone);
    else    return  self.commentDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        if (indexPath.section == 0) {
            static NSString * cellID = @"SS_DetailOfStoreCell_id";
            SS_DetailOfStoreCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            
            if (!cell) {
                cell = [SS_DetailOfStoreCell instanceWithXib];
            }
            SS_DetailOfStoreModel * b_model = self.dataSource[0];
            cell.detailOfStoreModel = b_model;
            // NSLog(@"虚拟评论内容:%@");
            //cell.userInteractionEnabled = NO;//该方法会把这个cell以及cell内的所有控件的事件都会被关闭
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];//使用该事件就不会了。
            [cell addBlock:^(id sender) {
                SS_CommentViewController *commentController = [[SS_CommentViewController alloc] init];
                //commentController.className = [self className];//传递对应商家的类别名称作为上传的评论类别名称
                //当前以默认方式传送 t_mingjidapaidang-->.commentClassName
                commentController.commentClassName = @"t_mingjidapaidang";
                [self.navigationController pushViewController:commentController animated:YES];
            }];
            return cell;
        }else if(indexPath.section == 1) {
            static NSString *cellID = @"phoneCell_id";
            phoneCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell) {
                cell = [phoneCell instanceWithXib];
            }
            if (indexPath.row == 0) {
                cell.schoolName.text = @"理工";
                cell.schoolPhone.text = [self.dataSource[0] phoneDgut];
            }else if (indexPath.row == 1){
                cell.schoolName.text = @"广医";
                cell.schoolPhone.text = [self.dataSource[0] phoneGdmc];
            }else{
                cell.schoolName.text = @"东职";
                cell.schoolPhone.text = [self.dataSource[0] phoneDgpt];
            }
            return cell;
        }else{
            if (indexPath.row) {
                NSLog(@"indexpath.row:%d",indexPath.row);
                
                static NSString *cellID = @"SS_CommentCell_id";
                SS_CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
                if (!cell) {
                    cell = [[SS_CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
                }
                cell.commentModel = self.commentDataSource[indexPath.row - 1];
                _cellHeight = cell.commentCellHeight;//获取cell的真正高度
                return  cell;
                
            }else{
                static NSString *cellID = @"TitleCell_id";
                commentTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
                if (!cell) {
                    cell = [[commentTitleCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellID];
                    
                    cell.TitleLabel.text = @"评论";
                }
                return cell;
            }
        }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
            return DETAIL_STORE_CELL_HEIGHT;
    }else if(indexPath.section == 1)  return  PHONE_CELL_HEIGHT;
    else {
        if (indexPath.row) {
            return _cellHeight;
        }else
            return 20;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
        if (section == 1)   return 10;
        else if(section == 0)  return 0;
        else    return 15;
}

#pragma  增加长按触发电话功能
- (void)tableviewCellLongPressed:(UILongPressGestureRecognizer *)gestureRecongnizer
{
    if (gestureRecongnizer.state == UIGestureRecognizerStateEnded) {
        CGPoint point = [gestureRecongnizer locationInView:self.tableView];
        NSIndexPath *path = [self.tableView indexPathForRowAtPoint:point];
        if (path.section == 1) {//再次拨打电话
            NSLog(@"path.row===%d",path.row);
        }
    }
}


@end
