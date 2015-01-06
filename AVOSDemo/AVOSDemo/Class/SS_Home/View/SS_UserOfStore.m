//
//  phoneCell.m
//  AVOSDemo
//
//  Created by chuck on 14-12-15.
//  Copyright (c) 2014年 秋权mac. All rights reserved.
//

#import "SS_UserOfStore.h"

@implementation phoneCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


+(instancetype)instanceWithXib
{
    return  [[[NSBundle mainBundle] loadNibNamed:@"phoneCell" owner:nil options:nil] lastObject];
}

@end
