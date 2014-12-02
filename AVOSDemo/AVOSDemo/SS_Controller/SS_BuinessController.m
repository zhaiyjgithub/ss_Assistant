#import "SS_BusinessCell.h"
#import "SS_BuinessController.h"
#import "SS_BusinessAPITool.h"

@interface SS_BuinessController ()

@end

@implementation SS_BuinessController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * cellID= @"B_Cell";
    
    SS_BusinessCell * cell = (SS_BusinessCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell= [SS_BusinessCell instanceWithXib];
    }
    
    SS_BusinessModel * b_model= self.dataSource[indexPath.row];
    cell.businessModel=b_model;
    return cell;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 80;
}

@end
