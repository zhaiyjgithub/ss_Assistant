//
//  WBaccountTool.m
//  AVOSDemo
//
//  Created by chuck on 15-1-27.
//  Copyright (c) 2015年 秋权mac. All rights reserved.
//

#import "WBaccountTool.h"


@implementation WBaccountTool

#define WB_ACCOUNT_FILE_PATH   [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.arch"]

+ (void)saveAccount:(SS_AccountModel *)account
{
    [NSKeyedArchiver archiveRootObject:account toFile:WB_ACCOUNT_FILE_PATH];
}

+ (SS_AccountModel *)account
{
    SS_AccountModel * account = [NSKeyedUnarchiver unarchiveObjectWithFile:WB_ACCOUNT_FILE_PATH];
    NSLog(@"account:%@",account.name);
    return account;
}
@end
