//
//  phoneCell.m
//  AVOSDemo
//
//  Created by chuck on 14-12-15.
//  Copyright (c) 2014年 秋权mac. All rights reserved.
//

#import "phoneCell.h"

@implementation phoneCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

+(instancetype)instanceWithXib
{
    return  [[[NSBundle mainBundle] loadNibNamed:@"phoneCell" owner:nil options:nil] lastObject];
}

@end
