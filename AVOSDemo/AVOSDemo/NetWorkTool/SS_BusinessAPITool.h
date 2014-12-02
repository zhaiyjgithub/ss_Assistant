//
//  SS_BusinessAPITool.h
//  AVOSDemo
//
//  Created by 秋权mac on 14-11-25.
//  Copyright (c) 2014年 秋权mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpTool.h"

@interface SS_BusinessAPITool : NSObject
+(void)getAllBusiness:(NSString *)uid
              success:(HttpSuccessBlock)success
              failure:(HttpFailureBlock)failure;



@end
