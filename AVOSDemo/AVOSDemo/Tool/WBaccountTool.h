//
//  WBaccountTool.h
//  AVOSDemo
//
//  Created by chuck on 15-1-27.
//  Copyright (c) 2015年 秋权mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SS_AccountModel.h"

@interface WBaccountTool : NSObject
+ (void)saveAccount:(SS_AccountModel *)account;
+ (SS_AccountModel *)account;
@end
