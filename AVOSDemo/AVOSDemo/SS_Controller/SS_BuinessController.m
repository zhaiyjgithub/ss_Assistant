#import "SS_BusinessCell.h"
#import "SS_NavigationCell.h"
#import "SS_BuinessController.h"
#import "SS_BusinessAPITool.h"
#import "SS_StoreViewController.h"

@interface SS_BuinessController ()
@property(nonatomic,strong)NSMutableArray * gd;
@property(nonatomic,strong)NSMutableArray * hn;
@end

@implementation SS_BuinessController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.gd = @[@"广州",@"深圳",@"佛山"];
    self.dataSource = self.gd;
    /*
    [SS_BusinessAPITool getAllBusiness:nil success:^(id result) {
        if (result) {
            NSArray * array =result;  // 获取底层传递过来的数组，并更新数据
            self.dataSource = [NSMutableArray arrayWithArray:array];
            NSLog(@"key:%@",[self.dataSource[5] b_address]);
            [self.tableView reloadData];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"ee:%@",error);
    }];
     
     */
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;//2个分组
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString * cellID = @"SS_Navigation_id";
    
    SS_NavigationCell * cell = (SS_NavigationCell *) [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [SS_NavigationCell instanceWithXib];
    }
    [cell addBlock:^(id sender) {
        UIButton *btn = sender;
        SS_StoreViewController *store = [[SS_StoreViewController alloc] init];
        store.title = @"Mingji";
        [self.navigationController pushViewController:store animated:YES];
        
    }];
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return indexPath.row == 0 ? 150 : 80;
}

@end
