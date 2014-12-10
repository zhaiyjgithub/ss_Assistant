//
//  SS_DetailOfStoreViewController.m
//  AVOSDemo
//
//  Created by chuck on 14-12-7.
//  Copyright (c) 2014年 秋权mac. All rights reserved.
//

#import "SS_DetailOfStoreViewController.h"
#import "SS_DetailOfStoreCell.h"

@interface SS_DetailOfStoreViewController ()

@end

@implementation SS_DetailOfStoreViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"SS_DetailOfStoreCell_id";
    SS_DetailOfStoreCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [SS_DetailOfStoreCell instanceWithXib];
    }
    SS_DetailOfStoreModel * b_model = self.dataSource[0];
    cell.detailOfStoreModel = b_model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 230;
}

@end
