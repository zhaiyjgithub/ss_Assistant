//
//  MainViewController.h
//  美美列表
//
//  Created by namebryant on 14-7-13.
//  Copyright (c) 2014年 Meimei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTabbarController : UITabBarController<UINavigationControllerDelegate>

/**
 *  初始化一个子控制器
 *
 *  @param childVc           需要初始化的子控制器
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
//- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName;
//
//
@property(nonatomic,assign)BOOL isBarHidden;
@property(nonatomic,strong) UIView *tabView;
@property(nonatomic,strong) UIImageView *slideBg;
@property (nonatomic,strong) NSMutableArray *buttons;
@property (nonatomic, readonly)UIViewController *selectedController;

@property(nonatomic,strong) UIButton *selectedButton;
@property (nonatomic,assign) int currentSelectedIndex;

- (void)selectedTab:(UIButton *)button;
@end
