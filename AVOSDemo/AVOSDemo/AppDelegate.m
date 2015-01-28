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

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    if ([WBaccountTool account]) {
        self.window.rootViewController = [[SS_MainViewController alloc] init];

    }else{
        self.window.rootViewController = [[SS_OAuthController alloc] init];
    }
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
