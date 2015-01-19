//
//  SS_CollectiionFrame.h
//  AVOSDemo
//
//  Created by chuck on 15-1-18.
//  Copyright (c) 2015年 秋权mac. All rights reserved.
//

#import "SS_BaseModel.h"
#import "SS_DetailOfStoreModel.h"

@interface SS_CollectionFrame : SS_BaseModel
@property(nonatomic,strong)SS_DetailOfStoreModel *detailStoreModel;
@property(nonatomic,assign,readonly)CGFloat cellHeight;
@property(nonatomic,assign,readonly)CGRect  instructionFrame;
@property(nonatomic,assign,readonly)CGRect  addressFrame;
@end
