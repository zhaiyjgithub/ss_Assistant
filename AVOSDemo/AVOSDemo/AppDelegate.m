//
//  AppDelegate.m
//  AVOSDemo
//
//  Created by 秋权mac on 14-11-24.
//  Copyright (c) 2014年 秋权mac. All rights reserved.
//

#import "AppDelegate.h"
#import "SS_MainViewController.h"
#import "WBaccountTool.h"
#import "SS_OAuthController.h"

// 5.获得RGB颜色
#define kColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

//
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    if ([WBaccountTool account]) {
        self.window.rootViewController = [[SS_MainViewController alloc] init];
    }else{
        self.window.rootViewController = [[SS_OAuthController alloc] init];
    }
    //改变bar的背景颜色
    [[UINavigationBar appearance] setBarTintColor:kColor(53, 184, 174)];
    //改变bar上面的按钮的颜色
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    //改变标题的颜色以
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1];
    shadow.shadowOffset = CGSizeMake(0, 0);
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
    [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], NSForegroundColorAttributeName,
    nil, NSShadowAttributeName,
    [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0], NSFontAttributeName, nil]];

    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{

}

- (void)applicationDidEnterBackground:(UIApplication *)application
{

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

@end
