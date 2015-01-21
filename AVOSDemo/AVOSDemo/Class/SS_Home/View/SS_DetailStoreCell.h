//
//  SS_DetailStoreCell.h
//  AVOSDemo
//
//  Created by chuck on 15-1-12.
//  Copyright (c) 2015年 秋权mac. All rights reserved.
//

#import "SS_BaseCell.h"
#import "SS_DetailOfStoreFrame.h"

typedef void(^ButtonBlock)(id sender);

@interface SS_DetailStoreCell : SS_BaseCell <UIActionSheetDelegate,UIAlertViewDelegate>
@property(nonatomic,strong)SS_DetailOfStoreFrame *detailStoreFrame;
@property(nonatomic,strong)ButtonBlock commentBlock;
@property(nonatomic,strong)ButtonBlock phoneBlock;
@property(nonatomic,strong)ButtonBlock collectionBlock;
@property(nonatomic,strong)ButtonBlock shareBlock;
@property(nonatomic,weak)UIImageView *storeImage;
@property(nonatomic,weak)UILabel *storeName;
@property(nonatomic,weak)UILabel  *storeInstruction;
@property(nonatomic,weak)UILabel *storeAddress;
@property(nonatomic,weak)UIImageView *storeInstructionIcon;
@property(nonatomic,weak)UIImageView *storeAddressIcon;//地址图标

@property(nonatomic,weak)UIButton *collectBtn;
@property(nonatomic,weak)UIButton *commentBtn;
@property(nonatomic,weak)UIButton *shareBtn;
@property(nonatomic,weak)UIButton *phoneBtn;

@property(nonatomic,assign)CGFloat detailStoreCellHeight;

- (UIButton *)addBtnWithTitle:(NSString *)title image:(NSString *)image bImage:(NSString *)bImage index:(int)index;
- (void)addBlock:(ButtonBlock)commentBlock phoneBlock:(ButtonBlock)phoneBlock
 collectionBlock:(ButtonBlock)collectionBlock shareBlock:(ButtonBlock)shareBlock;
@end
