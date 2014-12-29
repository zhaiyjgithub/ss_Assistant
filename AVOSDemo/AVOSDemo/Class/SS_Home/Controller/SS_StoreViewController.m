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
#import "MJRefresh.h"


static BOOL needToUpdate = YES;

@interface SS_StoreViewController ()<MJRefreshBaseViewDelegate>
{
    NSDictionary *uidOfRequest ;
}
@property(nonatomic,weak)MJRefreshFooterView *footer;
@property(nonatomic,weak)MJRefreshHeaderView *header;

@end

@implementation SS_StoreViewController

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
    
    uidOfRequest = @{
                     @"大排档":@"classes/t_hotStore"
                     };
    // Do any additional setup after loading the view from its nib.
    
    [self loadLocalData];//先加载本地数据
    [self setupRefreshView];
    
   
}
-(void)viewDidAppear:(BOOL)animated{//然后加载网络数据
    if (needToUpdate == YES) {
        needToUpdate = NO;
        NSLog(@"222222222222222");
        [self loadNetworkData];
    }
}
#pragma mark -网络
-(void)loadNetworkData{

    NSString *pathOfRequest = [uidOfRequest valueForKey:self.title];
    if (pathOfRequest !=nil) {
        [SS_BusinessAPITool getAllBusiness:pathOfRequest success:^(id result) {
            NSArray * array =result;  // 获取底层传递过来的数组，并更新数据
            self.dataSource = [NSMutableArray arrayWithArray:array];
            [self.tableView reloadData];
        } failure:^(NSError *error) {
            [SS_BusinessAPITool getAllBusiness:pathOfRequest success:^(id result) {
                NSArray * array =result;  // 获取底层传递过来的数组，并更新数据
                self.dataSource = [NSMutableArray arrayWithArray:array];
                [self.tableView reloadData];
                NSLog(@"再次发起请求成功:");
            } failure:^(NSError *error) {
            }];

        }];
        
    }else{
        NSLog(@"失败!:%@",self.title);
    }
}
#pragma mark 本地
-(void)loadLocalData{
#pragma TODO-- for count == 20
    self.dataSource =[SS_DetailOfStoreModel queryDetailModelWithWhere:nil orderBy:nil count:6];
    [self.tableView reloadData];

      
}

#pragma  设置上拉以及下拉刷新控件
- (void)setupRefreshView
{
    //定义上拉刷新
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.tableView;
    header.delegate = self;
    self.header = header;
    
    //定义下拉刷新
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.tableView;
    footer.delegate = self;
    self.footer = footer;
    
}
#pragma 必须调用析构来释放
- (void) dealloc
{
    [self.header free];
    [self.footer free];
}

/*
 *重写协议的方法，开始刷新数据时调用
 */

- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if ([refreshView isKindOfClass:[MJRefreshFooterView class]]) {
        [self loadMoreData];
    }else{
        [self loadNewData];
    }
}

#pragma  加载数据
- (void)loadMoreData
{
    NSLog(@"load more data");
    [self.footer endRefreshing];
}
#pragma 记载数据
- (void)loadNewData
{
    NSLog(@"load new data");
    [self.header endRefreshing];
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
    detailController.title = [detailController.dataSource[0] Name];//根据数据源的下标获取数据
    [self.navigationController pushViewController:detailController animated:YES];
}


@end
