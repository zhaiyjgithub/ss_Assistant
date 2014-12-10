//
//  SS_StoreViewController.m
//  AVOSDemo
//
//  Created by chuck on 14-12-2.
//  Copyright (c) 2014年 秋权mac. All rights reserved.
//

#import "SS_StoreViewController.h"
#import "SS_StoreCell.h"
#import "SS_DetailOfStoreViewController.h"
#import "SS_BusinessAPITool.h"


@interface SS_StoreViewController ()
{
    NSDictionary *uidOfRequest ;
       
}
@end

@implementation SS_StoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        uidOfRequest = @{
        @"大排档":@"classes/t_hotStore"
                         };
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    /*
        根据导航的按钮，向后台发起请求。
     */
    NSString *pathOfRequest = [uidOfRequest valueForKey:self.title];
    if (pathOfRequest !=nil) {
         [SS_BusinessAPITool getAllBusiness:pathOfRequest success:^(id result) {
           if (result) {
             NSArray * array =result;  // 获取底层传递过来的数组，并更新数据
             self.dataSource = [NSMutableArray arrayWithArray:array];
             //NSLog(@"name:%@",[self.dataSource[2] Name]);//数组保存的是模型对象
             [self.tableView reloadData];
          }
         } failure:^(NSError *error) {
             NSLog(@"ee:%@",error);
         }];
        
    }else{
        NSLog(@"失败!:%@",self.title);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
    static NSString *cellID = @"SS_StoreCell_id";
    
    SS_StoreCell * cell = (SS_StoreCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [SS_StoreCell instanceWithXib];
    }
    //使用模型来更新数据
     SS_DetailOfStoreModel * b_model = self.dataSource[indexPath.row];
     cell.detailOfStoreModel = b_model;
    return  cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //点击该row的cell，先从数据源从获取当前的数据，然后跳转到下一个商家详情界面。
    SS_DetailOfStoreViewController *detailController = [[SS_DetailOfStoreViewController alloc] init];
    //将使用model，首先数据模型与字典之间的转换。而不适用直接的方式赋值
    detailController.dataSource[0] = self.dataSource[indexPath.row];//获取某一间商店的数据
    detailController.title = [self.dataSource[0] Name];//根据数据源的下标获取数据
    [self.navigationController pushViewController:detailController animated:YES];
}


@end
