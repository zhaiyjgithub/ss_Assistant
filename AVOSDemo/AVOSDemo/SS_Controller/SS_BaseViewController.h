//
//  SS_BaseViewController.h
//  AVOSDemo
//
//  Created by 秋权mac on 14-11-25.
//  Copyright (c) 2014年 秋权mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SS_BaseViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *   tableView;
@property (nonatomic,strong)NSMutableArray     *   dataSource;
@end
