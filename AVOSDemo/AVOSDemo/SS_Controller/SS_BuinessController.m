#import "SS_BusinessCell.h"
#import "SS_NavigationCell.h"
#import "SS_BuinessController.h"
#import "SS_BusinessAPITool.h"
#import "SS_StoreViewController.h"
#import "SS_StoreCell.h"

@interface SS_BuinessController ()
{
    NSArray *naviClassesByButtonTag;
}
@property(nonatomic,strong)NSMutableArray * gd;
@property(nonatomic,strong)NSMutableArray * hn;
@end

@implementation SS_BuinessController

- (id)init
{
    self = [super init];
    if (self) {
        naviClassesByButtonTag = @[@"大排档",@"出行包车",@"休闲娱乐",@"餐饮美食",
                               @"快递物流",@"服装相关",@"学校部门",@"驾校学车",
                               @"横幅海报",@"蛋糕订制",@"周边住宿",@"其他"
                               ];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //这里是首先请求热门商家信息
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
            NSLog(@"btn.tag%d",btn.tag);//根据btn.tag来判断数据哪个按钮，tag已经在创建这个btn时已经确定
            SS_StoreViewController *store = [[SS_StoreViewController alloc] init];
            store.title =naviClassesByButtonTag[btn.tag];//根据title来判断属于哪个页面，从而向后台发起对应的请求
            [self.navigationController pushViewController:store animated:YES];
        }];
        return cell;
    }else{//显示热门商家信息的cell
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
