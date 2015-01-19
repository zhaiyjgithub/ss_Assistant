//
//  SS_DetailOfStoreFrame.m
//  AVOSDemo
//
//  Created by chuck on 15-1-12.
//  Copyright (c) 2015年 秋权mac. All rights reserved.
//

#import "SS_DetailOfStoreFrame.h"
#import "NSString+JJ.h"

#define SYSTEM_WITH  [UIScreen mainScreen].bounds.size.width - 100

@implementation SS_DetailOfStoreFrame

- (void)setDetailStoreModel:(SS_DetailOfStoreModel *)detailStoreModel
{
    _detailStoreModel = detailStoreModel;
   
    
    CGSize instructionSize = [detailStoreModel.instruction sizeWithFont:[UIFont systemFontOfSize:13.0] maxSize:CGSizeMake(SYSTEM_WITH, MAXFLOAT)];
    //商家图片的高度已经商家名称的高度已经确定了
    //暂时是用评论的内容作为地址的高度
    _instructionFrame = CGRectMake(10, 235, instructionSize.width, instructionSize.height);
    
    CGSize addressSize = [detailStoreModel.instruction sizeWithFont:[UIFont systemFontOfSize:13.0] maxSize:CGSizeMake(SYSTEM_WITH, MAXFLOAT)];
    
    _addressFrame = CGRectMake(10, 245 + instructionSize.height, addressSize.width, addressSize.height);
    
    _imageAndLabelHeight = (245 + instructionSize.height + addressSize.height);
    
}

@end
