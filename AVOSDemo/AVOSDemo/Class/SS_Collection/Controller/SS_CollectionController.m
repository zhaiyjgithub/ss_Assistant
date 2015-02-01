//
//  SS_CollectionController.m
//  AVOSDemo
//
//  Created by chuck on 15-1-18.
//  Copyright (c) 2015年 秋权mac. All rights reserved.
//

#import "SS_CollectionController.h"
#import "SS_CollectionCell.h"
#import "SS_CollectionFrame.h"
#import "SS_HeadView.h"
#import "SS_titleHeadView.h"
#import "ImageViewTransform.h"

@interface SS_CollectionController ()
@property(nonatomic,strong)NSMutableDictionary *status;
@property(nonatomic,strong)NSArray *naviClassesByButtonTag;
@property(nonatomic,strong)NSArray *keyForStore;
@property(nonatomic,strong)NSMutableArray *allDataSource;
@end

static int lastSection;

@implementation SS_CollectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.status = [[NSMutableDictionary alloc] init];
    _naviClassesByButtonTag = @[@"大排档",@"出行包车",@"休闲娱乐",@"餐饮美食",
                                @"快递物流",@"服装相关",@"学校部门",@"驾校学车",
                                @"横幅海报",@"蛋糕订制",@"周边住宿",@"其他"
                                ];
    _keyForStore = @[@"dapaidang",@"chuxingbaoche",@"xiuxianyule",@"canyinmeishi",
                     @"kuaidiwuliu",@"fuzhuangxiangguan",@"xuexiaobumen",@"jiachexueche",
                     @"hengfuhaibao",@"dangaodingzhi",@"zhoubianzhusu",@"qita"];
}

- (void)viewWillAppear:(BOOL)animated
{
    //[self loadLocalData];
    
    [self updateAllDataSource];
    lastSection = 13;//fix 重新进入时，图标再次旋转的bug
}

- (void)updateAllDataSource
{
    //同样先清除全部数据
    [self.dataSource removeAllObjects];
    for (int i=0;i<12;i++){
        NSMutableArray * classStore = [[NSMutableArray alloc] init];//每一个分类，其中包含了该分类的不同商家
        NSMutableArray * collectionModel = [[NSMutableArray alloc] init];
        collectionModel = [SS_CollectionModelinDB queryCollectionModelWithWhere:@"key" property:_keyForStore[i]];
        for (id model in collectionModel){
            SS_CollectionFrame *frameModel = [[SS_CollectionFrame alloc] init];
            frameModel.inDBModel = model;
            [classStore addObject:frameModel];
        }
        [self.dataSource addObject:classStore];//将该分类添加到全部数据源当中，一共添加12个分类
    }
    [self.tableView reloadData];
}
//需要整理根据key来获取数据
- (void)loadLocalData
{
    //先清除当前数据源中的数据再加载新的数据.修复datasource残留问题。
//    [self.dataSource removeAllObjects];
//    //加载本地数据库的数据
//    NSMutableArray * collectionModel = [[NSMutableArray alloc] init];
//    collectionModel = [SS_CollectionModelinDB queryCollectionModelWithWhere:@"key" property:@"hotStore"];
//    for (id model in collectionModel){
//        SS_CollectionFrame *frameModel = [[SS_CollectionFrame alloc] init];
//        frameModel.inDBModel = model;
//        [self.dataSource addObject:frameModel];
//    }
//    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int result = [self.status[@(section)] intValue];
    if (result == 0) {
        return 0;
    }else{
        return [self.dataSource[section] count];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 12;//一个十二个分组
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SS_CollectionFrame * frame = self.dataSource[indexPath.section][indexPath.row];//self.dataSource[indexPath.row];
    return  frame.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"SS_CollectiionCell_id";
    SS_CollectionCell * cell = (SS_CollectionCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell =  [[SS_CollectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.storeFrame = self.dataSource[indexPath.section][indexPath.row];//self.dataSource[indexPath.row];
    SS_CollectionFrame * b_frame = self.dataSource[indexPath.section][indexPath.row];//self.dataSource[indexPath.row];
    [cell addBlockForPhoneButton:^(id sender) {
        NSString * phoneDGUT = @"理工  ";
        NSString * phoneGDMC = @"广医  ";
        NSString * phoneDGPT = @"东职  ";
        
        phoneDGUT = [phoneDGUT stringByAppendingString:b_frame.inDBModel.phoneDgut];
        phoneGDMC = [phoneGDMC stringByAppendingString:b_frame.inDBModel.phoneGdmc];
        phoneDGPT = [phoneDGPT stringByAppendingString:b_frame.inDBModel.phoneDgpt];
        
        UIActionSheet *phoneActionSheet = [[UIActionSheet alloc] initWithTitle:@"马上联系商家" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:phoneDGUT otherButtonTitles:phoneGDMC,phoneDGPT, nil];
        phoneActionSheet.actionSheetStyle = UIActionSheetStyleDefault;
        [phoneActionSheet showInView:self.view];
    }];

    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
   
    SS_titleHeadView * titleHeadView = [[SS_titleHeadView alloc] init];
    //titleHeadView.userInteractionEnabled = YES;
    titleHeadView.headerViewButton.tag = section;
    [titleHeadView.headerViewButton setTitle:_naviClassesByButtonTag[section] forState:UIControlStateNormal];
    //必须设置titleview的tag，该view对应一个手势，那么手势上面的view就是这个imageview，从而得到这个tag,实现参数的传递
    titleHeadView.tag = section;
    UITapGestureRecognizer * imageViewGuster = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickHeadView:)];
    [titleHeadView addGestureRecognizer:imageViewGuster];
    int result = [self.status[@(section)] intValue];
    //查询状态记录,只更改被触发的headView
    if (lastSection == section) {
        
        if (result == 0){// 1 ---> 0
            [ImageViewTransform imageViewRotateAnimation:titleHeadView.headerViewButton.imageView from:@(M_PI_2) to:@(0.0) duration:0.2];
            titleHeadView.headerViewButton.imageView.transform = CGAffineTransformIdentity;

        }else{// 0 ---> 1
            [ImageViewTransform imageViewRotateAnimation:titleHeadView.headerViewButton.imageView from:@(0.0) to:@(M_PI_2) duration:0.2];
            titleHeadView.headerViewButton.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
        }
    }else{
       // int result = [self.status[@(section)] intValue];
        if (result == 0){// 1 ---> 0
           // [ImageViewTransform imageViewRotateAnimation:titleHeadView.headerViewButton.imageView from:@(M_PI_2) to:@(0.0) duration:0.2];
            titleHeadView.headerViewButton.imageView.transform = CGAffineTransformIdentity;
            
        }else{// 0 ---> 1
          //  [ImageViewTransform imageViewRotateAnimation:titleHeadView.headerViewButton.imageView from:@(0.0) to:@(M_PI_2) duration:0.2];
            titleHeadView.headerViewButton.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
        }

    }
    return titleHeadView;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //先读取当前的数据，然后根据事件操作数据。
    //之前出现的问题就是没有理解好，进入事件后再读取数据源的数据已经太迟了。
    SS_CollectionFrame  * collectionFrame = self.dataSource[indexPath.section][indexPath.row];//self.dataSource[indexPath.row];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dataSource[indexPath.section] removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [SS_CollectionModelinDB deleteCollectionModel:@"storeName" property:collectionFrame.inDBModel.storeName];
    }
}

-(NSString*)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexpath
{
    return @"删除";
}
 
//通过手势对应的imageview的ID来实现参数传递
//后面将会根据不同的key来分发数据到数据源当中
- (void)clickHeadView:(UITapGestureRecognizer *)guster
{
    int section = (int)guster.view.tag;
    lastSection = section;
    int result = [self.status[@(section)] intValue];
    if (result == 0) {
        [self.status setObject:@1 forKey:@(section)];
    }else{
        [self.status setObject:@0 forKey:@(section)];
    }
    [self.tableView reloadData];
}

@end
