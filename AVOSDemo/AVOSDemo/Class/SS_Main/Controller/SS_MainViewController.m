//
//  SS_MainViewController.m
//  AVOSDemo
//
//  Created by 秋权mac on 14-11-25.
//  Copyright (c) 2014年 秋权mac. All rights reserved.
//

#import "SS_MainViewController.h"
#import "SS_BuinessController.h"
#import "SS_DetailCollectionController.h"
#import "SS_MineController.h"
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
    
    SS_BuinessController *business = [[SS_BuinessController alloc] init];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:business];
    nav1.delegate = self;
    [self addChildViewController:nav1];
    
    SS_DetailPhoneController *phone = [[SS_DetailPhoneController alloc] init];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:phone];
    nav2.delegate = self;
    [self addChildViewController:nav2];
    
    SS_MineController *mine = [[SS_MineController alloc] init];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:mine];
    nav3.delegate = self;
    [self addChildViewController:nav3];
    
    self.viewControllers = @[nav1, nav2, nav3];
    
    [super viewDidLoad];

}





@end
