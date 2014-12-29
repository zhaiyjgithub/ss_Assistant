//#import "SS_BusinessCell.h"
#import "SS_NavigationCell.h"
#import "SS_BuinessController.h"
#import "SS_BusinessAPITool.h"
#import "SS_StoreViewController.h"
#import "SS_StoreCell.h"
#import "SS_DetailOfStoreModel.h"
#import "SS_DetailOfStoreViewController.h"

#define HOT_STORE_PATH      @"classes/t_hotStore"

static BOOL needToUpdate = YES;


@interface SS_BuinessController ()
{
    NSArray *naviClassesByButtonTag;
}
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
    
    [self loadLocalData];//修改为先加载本地数据，然后加载服务器数据

    //自定义返回按钮
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] init];
    backBtn.title = @"返回";
    self.navigationItem.backBarButtonItem = backBtn;
}

- (void)viewDidAppear:(BOOL)animated
{
    //后台加载网络数据以及更新数据库数据
    if (needToUpdate == YES) {
        NSLog(@"need to update");
        needToUpdate = NO;
        [self loadNetData];
    }
}
#pragma mark - 根据后面需求，按照查询约束来插入以及查询数据
- (void)loadLocalData
{
    //加载数据库数据，
    self.dataSource = [SS_DetailOfStoreModel queryDetailModelWithWhere:nil orderBy:nil count:10];
    [self.tableView reloadData];

}
/*
 2014/14/28 12:15出现get请求一次请求成功，一次失败重复性现象，暂时还没有找到问题所在
 为了避免影响到其他，就是用失败一次后重复请求。
 */
- (void)loadNetData
{
    //请求服务器的最新数据，注意请求的数据的个数要与数据库里面的个数保持一致
    [SS_BusinessAPITool getAllBusiness:HOT_STORE_PATH success:^(id result) {
        if (result) {
            NSArray * array =result;  // 获取底层传递过来的数组，并更新数据
            self.dataSource = [NSMutableArray arrayWithArray:array];
            [self updateLocalData:self.dataSource];
            [self.tableView reloadData];
            
        }
    } failure:^(NSError *error) {
        [SS_BusinessAPITool getAllBusiness:HOT_STORE_PATH success:^(id result) {
            if (result) {
                NSLog(@"重新获取数据成功");
                NSArray * array =result;  // 获取底层传递过来的数组，并更新数据
                self.dataSource = [NSMutableArray arrayWithArray:array];
                [self updateLocalData:self.dataSource];
                [self.tableView reloadData];
            }
        } failure:^(NSError *error) {
        }];

    }];

}
#pragma mark - 网络数据更新数据库中热门商家的数据
#pragma mark - TODO,count == 50 需要修改，只是假设本地数据库固定50个数据作为热门数据
- (void)updateLocalData:(NSMutableArray *)dataSource
{
    NSMutableArray *hotStore = [[NSMutableArray alloc] initWithArray:[SS_DetailOfStoreModel queryDetailModelWithWhere:@{@"key":@"hotStore"} orderBy:nil count:50]];
    //删除本地SQL数据，再根据网络数据更新本地SQL数据
    for (id model in hotStore){
        [SS_DetailOfStoreModel deleteDetailModel:model];
    }
    for (id model in dataSource){
        [SS_DetailOfStoreModel insertDetailModel:model];
    }
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
            cell = [[SS_NavigationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];//代码实现的cell
        }
        [cell addBlock:^(id sender) {//为按钮添加block
            UIButton *btn = (UIButton *)sender;
           // NSLog(@"btn.tag%d",btn.tag);//根据btn.tag来判断数据哪个按钮，tag已经在创建这个btn时已经确定
            SS_StoreViewController *store = [[SS_StoreViewController alloc] init];
            store.title =naviClassesByButtonTag[btn.tag];//根据title来判断属于哪个页面，从而向后台发起对应的请求
            [self.navigationController pushViewController:store animated:YES];
        }];
        return cell;
    }else{//显示门商家信息的cell
        static NSString *cellID = @"SS_StoreCell_id";
        
        SS_StoreCell * cell = (SS_StoreCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [SS_StoreCell instanceWithXib];//使用Xib建立的cell，使用方法都是不同的。
        }
        //使用模型来更新数据
         SS_DetailOfStoreModel * b_model = self.dataSource[indexPath.row];
         cell.detailOfStoreModel = b_model;
        
        return  cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    //return indexPath.section == 0 ? 210 : 80;
    if (indexPath.section == 0) return 210;
    
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        //点击该row的cell，先从数据源从获取当前的数据，然后跳转到下一个商家详情界面。
        SS_DetailOfStoreViewController *detailController = [[SS_DetailOfStoreViewController alloc] init];
        //将使用model，首先数据模型与字典之间的转换。而不适用直接的方式赋值
        detailController.dataSource[0] = self.dataSource[indexPath.row];//获取某一间商店的数据
        detailController.title = [self.dataSource[0] Name];//根据数据源的下标获取数据
        [self.navigationController pushViewController:detailController animated:YES];
    }
}

@end
