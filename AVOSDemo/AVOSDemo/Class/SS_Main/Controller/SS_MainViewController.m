//
//  SS_MainViewController.m
//  AVOSDemo
//
//  Created by 秋权mac on 14-11-25.
//  Copyright (c) 2014年 秋权mac. All rights reserved.
//

#import "SS_MainViewController.h"
#import "SS_BuinessController.h"
#import "SS_CollectionController.h"
#import "SS_MineController.h"
#import "SS_OAuthController.h"

@interface SS_MainViewController ()

@end

@implementation SS_MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad //重写UITabView，添加三个导航控制器
{
    
    [self setupAllChildViewControllers];
    
    [super viewDidLoad];
}

- (void)setupAllChildViewControllers
{
    SS_BuinessController *buiness = [[SS_BuinessController alloc] init];
    [self setupChildViewController:buiness title:@"首页" imageName:@"icon_tabbar_01" selectImageName:@"icon_tabbar_01_h"];
    
    SS_CollectionController * collection = [[SS_CollectionController alloc] init];
    [self setupChildViewController:collection title:@"收藏" imageName:@"icon_tabbar_02" selectImageName:@"icon_tabbar_02_h"];
    
    SS_MineController * mine = [[SS_MineController alloc] init];
    [self setupChildViewController:mine title:@"个人" imageName:@"icon_tabbar_03" selectImageName:@"icon_tabbar_03_h"];
    
    SS_OAuthController * oath = [[SS_OAuthController alloc] init];
    [self setupChildViewController:oath title:@"授权" imageName:@"icon_tabbar_03" selectImageName:@"icon_tabbar_03_h"];
}

- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectImageName:(NSString *)selectImageName
{
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childVc];
    
    [self addChildViewController:nav];
}



@end
