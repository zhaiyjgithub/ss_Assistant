//
//  SS_StoreCell.m
//  AVOSDemo
//
//  Created by chuck on 14-12-2.
//  Copyright (c) 2014年 秋权mac. All rights reserved.
//

#import "SS_StoreCell.h"

@implementation SS_StoreCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDetailOfStoreModel:(SS_DetailOfStoreModel *)detailOfStoreModel
{
    _detailOfStoreModel = detailOfStoreModel;
    self.nameLabel.text = detailOfStoreModel.Name;
    self.phoneLabel.text = detailOfStoreModel.phone_host;
}


+ (instancetype)instanceWithXib
{
    return [[[NSBundle mainBundle] loadNibNamed:@"SS_StoreCell" owner:nil options:nil] lastObject];
}

@end
