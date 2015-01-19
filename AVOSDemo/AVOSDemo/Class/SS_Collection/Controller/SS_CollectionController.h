//
//  SS_CollectionController.h
//  AVOSDemo
//
//  Created by chuck on 15-1-18.
//  Copyright (c) 2015年 秋权mac. All rights reserved.
//

#import "SS_BaseViewController.h"

@interface SS_CollectionController : SS_BaseViewController <UIActionSheetDelegate>
@property(nonatomic,assign,readonly)CGFloat cellHeight;
@property(nonatomic,assign,readonly)CGRect  instructionFrame;
@property(nonatomic,assign,readonly)CGRect  addressFrame;
@end
