//
//  SS_DetailOfStoreViewController.h
//  AVOSDemo
//
//  Created by chuck on 14-12-7.
//  Copyright (c) 2014年 秋权mac. All rights reserved.
//

#import "SS_BaseViewController.h"
#import "SS_DetailOfStoreModel.h"
#import "SS_CollectionModelinDB.h"

@interface SS_DetailOfStoreViewController : SS_BaseViewController<UIGestureRecognizerDelegate,UIActionSheetDelegate>

@property(nonatomic,strong)SS_DetailOfStoreModel *detailOfModel;
@property(nonatomic,strong)SS_CollectionModelinDB *inDBModel;
@property(nonatomic,strong)NSMutableArray *commentDataSource;

@end
