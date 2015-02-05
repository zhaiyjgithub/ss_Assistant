//
//  SS_CollectiionFrame.m
//  AVOSDemo
//
//  Created by chuck on 15-1-18.
//  Copyright (c) 2015年 秋权mac. All rights reserved.
//

#import "SS_CollectionFrame.h"
#import "NSString+JJ.h"

@implementation SS_CollectionFrame

- (void)setInDBModel:(SS_CollectionModelinDB *)inDBModel
{
    _inDBModel = inDBModel;
    
    CGSize instructionSize = [inDBModel.instruction sizeWithFont:[UIFont systemFontOfSize:13.0] maxSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 80, MAXFLOAT)];
    _instructionFrame = CGRectMake(25, 40, instructionSize.width, instructionSize.height);
    
    CGSize addressSize = [inDBModel.address sizeWithFont:[UIFont systemFontOfSize:13.0] maxSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 80, MAXFLOAT)];
    _addressFrame = CGRectMake(25, _instructionFrame.origin.y + _instructionFrame.size.height + 10, addressSize.width, addressSize.height);
    
    _cellHeight = 55 + _instructionFrame.size.height + _addressFrame.size.height ;
}

@end
