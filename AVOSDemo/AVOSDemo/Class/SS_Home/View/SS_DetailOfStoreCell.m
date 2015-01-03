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

#pragma 使用xib文件加载
- (void)awakeFromNib {
    // Initialization code
    [self.comment addTarget:self action:@selector(clickComment:) forControlEvents:UIControlEventTouchUpInside];
}


- (void)clickComment:(id)sender
{
    if (self.commentBlock) {
        self.commentBlock(sender);//使用block执行
    }
}

/*
 *在添加cell之后，为每个cell的按钮实例化它的block
 */
- (void)addBlock:(setCommentIconBlock)block
{
    self.commentBlock = block;
}
- (void)setDetailOfStoreModel:(SS_DetailOfStoreModel *)detailOfStoreModel
{
    _detailOfStoreModel = detailOfStoreModel;
    self.name.text = detailOfStoreModel.storeName;
#pragma TODO--修改UILabel的文字顶部对齐方式
    self.instruction.text = detailOfStoreModel.instruction;
}


+ (instancetype) instanceWithXib
{
    return  [[[NSBundle mainBundle] loadNibNamed:@"SS_DetailOfStoreCell" owner:nil options:nil] lastObject];
}
@end
