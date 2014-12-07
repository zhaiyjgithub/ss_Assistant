//
//  SS_DetailOfStoreCell.h
//  AVOSDemo
//
//  Created by chuck on 14-12-7.
//  Copyright (c) 2014年 秋权mac. All rights reserved.
//

#import "SS_BaseCell.h"
#import "SS_DetailOfStoreModel.h"

@interface SS_DetailOfStoreCell : SS_BaseCell

@property (weak, nonatomic) IBOutlet UIButton *nameOfLogo;
@property(nonatomic,strong)SS_DetailOfStoreModel * detailOfStoreModel;

+ (instancetype)instanceWithXib;

@end
