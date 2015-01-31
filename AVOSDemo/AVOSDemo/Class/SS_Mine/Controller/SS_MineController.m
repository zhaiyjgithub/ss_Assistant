//
//  SS_MineController.m
//  AVOSDemo
//
//  Created by 秋权mac on 14-11-25.
//  Copyright (c) 2014年 秋权mac. All rights reserved.
//

#import "SS_MineController.h"
#import "AFNetworking.h"
#import "UserImageCell.h"
#import "userInfoCell.h"
#import "WBaccountTool.h"

@interface SS_MineController ()

@end

@implementation SS_MineController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;//头像，简介，性别与地区！
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section == 0 ? 1 : 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.section == 0 ? 215 : 60;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return section == 0 ? 0 : 15;
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString * cellID = @"userImage_id";
        UserImageCell * cell = (UserImageCell *)[ tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[UserImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        
        return cell;
    }else if (indexPath.section == 1 && indexPath.row == 0){
        static NSString * cellID = @"userInfoCell_id";
        userInfoCell * cell = (userInfoCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[userInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.cellImage.image =[UIImage imageNamed:@"userInfolocation"];
        cell.cellLabel.text = [WBaccountTool account].location;
        
        return cell;
    }else{
        static NSString * cellID = @"userInfoCell_id";
        userInfoCell * cell = (userInfoCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[userInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.cellImage.image =[UIImage imageNamed:@"school_os7"];
        cell.cellLabel.text = @"东莞理工学院";
        
        return cell;
    }
    
}

@end
