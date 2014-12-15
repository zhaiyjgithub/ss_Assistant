//
//  SS_DetailOfStoreCell.m
//  AVOSDemo
//
//  Created by chuck on 14-12-7.
//  Copyright (c) 2014年 秋权mac. All rights reserved.
//

#import "SS_DetailOfStoreCell.h"
#import "SS_DetailOfStoreModel.h"

@implementation SS_DetailOfStoreCell

- (void)setDetailOfStoreModel:(SS_DetailOfStoreModel *)detailOfStoreModel
{
    _detailOfStoreModel = detailOfStoreModel;
    self.name.text = detailOfStoreModel.Name;
    self.instruction.text = detailOfStoreModel.instruction;
}


+ (instancetype) instanceWithXib
{
    return  [[[NSBundle mainBundle] loadNibNamed:@"SS_DetailOfStoreCell" owner:nil options:nil] lastObject];
}
@end
