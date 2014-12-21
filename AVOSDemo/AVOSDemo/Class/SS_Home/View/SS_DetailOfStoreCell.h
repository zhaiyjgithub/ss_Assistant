//
//  SS_DetailOfStoreCell.h
//  AVOSDemo
//
//  Created by chuck on 14-12-7.
//  Copyright (c) 2014年 秋权mac. All rights reserved.
//

#import "SS_BaseCell.h"
#import "SS_DetailOfStoreModel.h"

typedef void(^setCommentIconBlock) (id sender);

@interface SS_DetailOfStoreCell : SS_BaseCell
@property(nonatomic,strong)setCommentIconBlock commentBlock;
@property(nonatomic,strong)SS_DetailOfStoreModel * detailOfStoreModel;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *instruction;
@property (weak, nonatomic) IBOutlet UIButton *comment;
@property(nonatomic,assign)NSInteger cellHeight;

- (void)addBlock:(setCommentIconBlock)block;
+ (instancetype)instanceWithXib;

@end
