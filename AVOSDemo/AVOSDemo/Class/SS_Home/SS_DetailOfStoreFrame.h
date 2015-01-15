//
//  SS_DetailOfStoreFrame.h
//  AVOSDemo
//
//  Created by chuck on 15-1-12.
//  Copyright (c) 2015年 秋权mac. All rights reserved.
//

#import "SS_BaseModel.h"
#include "SS_DetailOfStoreModel.h"

@interface SS_DetailOfStoreFrame : SS_BaseModel
@property(nonatomic,strong)SS_DetailOfStoreModel *detailStoreModel;
@property(nonatomic,assign,readonly)CGFloat imageAndLabelHeight;
@property(nonatomic,assign,readonly)CGRect  instructionFrame;
@property(nonatomic,assign,readonly)CGRect  addressFrame;

@end
