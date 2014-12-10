//
//  SS_StoreCell.h
//  AVOSDemo
//
//  Created by chuck on 14-12-2.
//  Copyright (c) 2014年 秋权mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SS_DetailOfStoreModel.h"

@interface SS_StoreCell : UITableViewCell

@property(nonatomic,strong)SS_DetailOfStoreModel * detailOfStoreModel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

+ (instancetype)instanceWithXib;
@end
