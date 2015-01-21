//
//  SS_DetailOfStoreFrame.m
//  AVOSDemo
//
//  Created by chuck on 15-1-12.
//  Copyright (c) 2015年 秋权mac. All rights reserved.
//

#import "SS_DetailOfStoreFrame.h"
#import "NSString+JJ.h"

#define SYSTEM_WITH  [UIScreen mainScreen].bounds.size.width - 70

@implementation SS_DetailOfStoreFrame

- (void)setDetailStoreModel:(SS_DetailOfStoreModel *)detailStoreModel
{
    _detailStoreModel = detailStoreModel;
    
    CGSize instructionSize = [detailStoreModel.instruction sizeWithFont:[UIFont systemFontOfSize:15.0] maxSize:CGSizeMake(SYSTEM_WITH, MAXFLOAT)];
    _instructionFrame = CGRectMake(25, 235, instructionSize.width, instructionSize.height);
    
    CGSize addressSize = [detailStoreModel.instruction sizeWithFont:[UIFont systemFontOfSize:15.0] maxSize:CGSizeMake(SYSTEM_WITH, MAXFLOAT)];
    _addressFrame = CGRectMake(25, _instructionFrame.origin.y  + instructionSize.height + 10, addressSize.width, addressSize.height);
    
    _imageAndLabelHeight = (235 + _instructionFrame.size.height + 10 + _addressFrame.size.height +10);
    
}

@end
