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
#import "SS_CommentViewController.h"

@interface SS_DetailOfStoreViewController ()
{
    int count;
}
@end

@implementation SS_DetailOfStoreViewController


- (void)viewDidLoad
{
    [super viewDidLoad];//没有先加载父类，就会导致黑屏挂掉
   
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(tableviewCellLongPressed:)];
    
    longPress.delegate = self;//当前VC需要添加手势事件的协议<UIGestureRecognizerDelegate>
    longPress.minimumPressDuration = 1.0;
    [self.tableView addGestureRecognizer:longPress];
    
    SS_DetailOfStoreModel *model = self.dataSource[0];//根据内容选择显示cell的数目
    if([model.phone_dgpt isEqualToString:@"-"]) count+=1;
    if([model.phone_gdmc isEqualToString:@"-"]) count+=1;
    if([model.phone_dgut isEqualToString:@"-"]) count+=1;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;//暂时有两个分组，不包含评论分组
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0) {
        return 1;
    }else /*if(section == 1)*/{//如果所在商家没有某一间学校的电话，则不显示该学校的cell
        return (3-count);
    }
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
        //cell.userInteractionEnabled = NO;//该方法会把这个cell以及cell内的所有控件的事件都会被关闭
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];//使用该事件就不会了。
        [cell addBlock:^(id sender) {
            SS_CommentViewController *commentController = [[SS_CommentViewController alloc] init];
            [self.navigationController pushViewController:commentController animated:YES];
        }];
       return cell;
    }else /*if (indexPath.section == 1)*/{
        static NSString *cellID = @"phoneCell_id";
        phoneCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [phoneCell instanceWithXib];
        }
        if (indexPath.row == 0) {
            cell.schoolName.text = @"理工";
            cell.schoolPhone.text = [self.dataSource[0] phone_dgut];
        }else if (indexPath.row == 1){
            cell.schoolName.text = @"广医";
            cell.schoolPhone.text = [self.dataSource[0] phone_gdmc];
        }else{
            cell.schoolName.text = @"东职";
            cell.schoolPhone.text = [self.dataSource[0] phone_dgpt];
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 150;
    }else{
        return  60;
    }
}

- (void)tableviewCellLongPressed:(UILongPressGestureRecognizer *)gestureRecongnizer
{
    if (gestureRecongnizer.state == UIGestureRecognizerStateEnded) {
        NSLog(@"touch ended");
        CGPoint point = [gestureRecongnizer locationInView:self.tableView];
        NSIndexPath *path = [self.tableView indexPathForRowAtPoint:point];
        if (path.section == 1) {//再次拨打电话
            NSLog(@"path.row===%d",path.row);
        }
    }
}


@end
