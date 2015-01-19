//
//  SS_CollectionCell.h
//  AVOSDemo
//
//  Created by chuck on 15-1-18.
//  Copyright (c) 2015年 秋权mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SS_CollectionFrame.h"

@interface SS_CollectionCell : UITableViewCell

//typedef void(^buttonBlock)(id sender);
typedef void(^ButtonBlock)(id sender);

@property(nonatomic,strong)ButtonBlock phoneButtonBlock;
@property(nonatomic,strong)SS_CollectionFrame *storeFrame;
@property(nonatomic,weak)UILabel * storeNameLabel;
@property(nonatomic,weak)UILabel * storeInstructionLabel;
@property(nonatomic,weak)UILabel * storeAddesssLabel;
@property(nonatomic,weak)UIButton * storePhoneButton;

@property(nonatomic,weak)UIImageView *addressDot;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)addBlockForPhoneButton:(ButtonBlock)block;
@end
