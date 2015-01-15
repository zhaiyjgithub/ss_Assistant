//
//  SS_DetailOfStoreViewController.m
//  AVOSDemo
//
//  Created by chuck on 14-12-7.
//  Copyright (c) 2014年 秋权mac. All rights reserved.
//

#import "SS_DetailOfStoreViewController.h"
//#import "SS_DetailOfStoreCell.h"
#import "SS_CommentCell.h"
#import "SS_CommentViewController.h"
#import "MJRefresh.h"
#import "controllerCommon.h"
#import "SS_BusinessAPITool.h"
#import "SS_CommentFrame.h"
#import "SS_DetailOfStoreFrame.h"
#import "SS_DetailStoreCell.h"


@interface SS_DetailOfStoreViewController ()
@end

@implementation SS_DetailOfStoreViewController


- (void)viewWillAppear:(BOOL)animated
{
    //加载网络的评论数据,先加载0-15个评论
    SS_DetailOfStoreFrame *Storeframe = self.dataSource[0];
    SS_DetailOfStoreModel *model = Storeframe.detailStoreModel;
    NSString *commentClassNamePath = [NSString stringWithFormat:@"classes/%@",model.commentClassName];
    //NSLog(@"评论的路径名称:%@",commentClassNamePath);
    //发起连接
    //
    [SS_BusinessAPITool getAllBusinessWithCommentModel:commentClassNamePath success:^(id result) {
        if (result) {
            NSArray * array = result;
            NSMutableArray * frameArray = [[NSMutableArray array] init];
            for (id model in array){
                SS_CommentFrame *frame = [[SS_CommentFrame alloc] init];
                frame.commmentModel = model;
                [frameArray addObject:frame];
            }
            //从底层的数据后去cell的属性
            self.commentDataSource = frameArray;//[NSMutableArray arrayWithArray:array];
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        
        [SS_BusinessAPITool getAllBusinessWithCommentModel:commentClassNamePath success:^(id result) {
            NSLog(@"再次请求成功");
            if (result) {
                NSArray * array = result;
                NSMutableArray * frameArray = [[NSMutableArray array] init];
                for (id model in array){
                    SS_CommentFrame *frame = [[SS_CommentFrame alloc] init];
                    frame.commmentModel = model;
                    [frameArray addObject:frame];
                }
                //从底层的数据后去cell的属性
                self.commentDataSource = frameArray;//[NSMutableArray arrayWithArray:array];
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
   /*
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(tableviewCellLongPressed:)];
    
    longPress.delegate = self;//当前VC需要添加手势事件的协议<UIGestureRecognizerDelegate>
    longPress.minimumPressDuration = 1.0;
    [self.tableView addGestureRecognizer:longPress];
   */
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)   return 1;
    else
        return  self.commentDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        if (indexPath.section == 0) {
            static NSString * cellID = @"SS_DetailStoreCell_id";
           // SS_DetailOfStoreCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            
            SS_DetailStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            
            if (!cell) {
                //cell = [SS_DetailOfStoreCell instanceWithXib];
                cell = [[SS_DetailStoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            }
            //SS_DetailOfStoreModel * b_model = self.dataSource[0];
            SS_DetailOfStoreFrame *b_frame = self.dataSource[0];
           // cell.detailOfStoreModel = b_frame.detailStoreModel;
            cell.detailStoreFrame = b_frame;
            // NSLog(@"虚拟评论内容:%@");
            //cell.userInteractionEnabled = NO;//该方法会把这个cell以及cell内的所有控件的事件都会被关闭
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];//使用该事件就不会了。
            [cell addBlock:^(id sender) {
                SS_CommentViewController *commentController = [[SS_CommentViewController alloc] init];
                //commentController.className = [self className];//传递对应商家的类别名称作为上传的评论类别名称
                //当前以默认方式传送 t_mingjidapaidang-->.commentClassName
                commentController.commentClassName = b_frame.detailStoreModel.commentClassName;
                [self.navigationController pushViewController:commentController animated:YES];
            } phoneBlock:^(id sender) {
                UIActionSheet *phoneActionSheet = [[UIActionSheet alloc] initWithTitle:@"马上联系商家" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"理工" otherButtonTitles:@"广医",@"东职", nil];
                phoneActionSheet.actionSheetStyle = UIActionSheetStyleDefault;
                [phoneActionSheet showInView:self.view];
            }];
            return cell;
        }else{
            static NSString *cellID = @"SS_CommentCell_id";
            SS_CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell) {
                cell = [[SS_CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            }
            cell.commentFrame = self.commentDataSource[indexPath.row];//因为下标==‘0’使用评论的眉头
            return  cell;

        }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return DETAIL_STORE_CELL_HEIGHT;
    }else {
        SS_CommentFrame *cellFrame = self.commentDataSource[indexPath.row];
        return cellFrame.CellHeight;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section == 0 ? 0 : 25;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return section == 0 ? @" " : @"评论";
}
/*
#pragma  增加长按触发电话功能
- (void)tableviewCellLongPressed:(UILongPressGestureRecognizer *)gestureRecongnizer
{
    //将使用actionsheet代替当前的长按手势
    if (gestureRecongnizer.state == UIGestureRecognizerStateEnded) {
        CGPoint point = [gestureRecongnizer locationInView:self.tableView];
        NSIndexPath *path = [self.tableView indexPathForRowAtPoint:point];
        if (path.section == 1) {//再次拨打电话
            NSLog(@"path.row===%d",path.row);
        }
    }
}
*/

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //从数据源中获取商家的电话数据，然后拨号
}

@end
