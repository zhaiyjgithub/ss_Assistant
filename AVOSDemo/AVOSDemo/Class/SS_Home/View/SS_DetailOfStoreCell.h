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
@property(nonatomic,strong)SS_DetailOfStoreModel * detailOfStoreModel;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *instruction;
@property (weak, nonatomic) IBOutlet UILabel *phone_dgut;
@property (weak, nonatomic) IBOutlet UILabel *phone_dgpt;
@property (weak, nonatomic) IBOutlet UILabel *phone_dgmc;


+ (instancetype)instanceWithXib;

@end
