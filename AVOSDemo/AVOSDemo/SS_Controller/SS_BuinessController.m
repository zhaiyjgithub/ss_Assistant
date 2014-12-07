#import "SS_BusinessCell.h"
#import "SS_NavigationCell.h"
#import "SS_BuinessController.h"
#import "SS_BusinessAPITool.h"
#import "SS_StoreViewController.h"
#import "SS_StoreCell.h"

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
    if(section == 0) return  1;
    
    return self.dataSource.count;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section == 0){
        static NSString * cellID = @"SS_NavigationCell";
        
        SS_NavigationCell * cell = (SS_NavigationCell *) [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[SS_NavigationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        [cell addBlock:^(id sender) {//为按钮添加block
            UIButton *btn = (UIButton *)sender;
            NSLog(@"btn%@",btn);
            SS_StoreViewController *store = [[SS_StoreViewController alloc] init];
            store.title = @"Mingji";
            [self.navigationController pushViewController:store animated:YES];
            
        }];
        return cell;
    }else{
        static NSString *cellID = @"SS_StoreCell_id";
        
        SS_StoreCell * cell = (SS_StoreCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [SS_StoreCell instanceWithXib];
        }
        return  cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    //return indexPath.section == 0 ? 210 : 80;
    if (indexPath.section == 0) return 210;
    
    return 80;
}

@end
