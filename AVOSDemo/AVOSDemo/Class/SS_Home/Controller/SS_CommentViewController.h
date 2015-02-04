//
//  SS_CommentViewController.h
//  AVOSDemo
//
//  Created by chuck on 14-12-18.
//  Copyright (c) 2014年 秋权mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SS_CommentModel.h"
#import "SS_SendComment.h"

@interface SS_CommentViewController : UIViewController <UIActionSheetDelegate,UIAlertViewDelegate>
@property(nonatomic,weak)SS_SendComment *commentTextview;
@property(nonatomic,strong)NSString *commentClassName;
@end
