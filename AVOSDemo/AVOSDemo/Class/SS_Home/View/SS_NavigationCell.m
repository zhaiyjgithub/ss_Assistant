//
//  SS_NavigationCell.m
//  AVOSDemo
//
//  Created by chuck on 14-12-2.
//  Copyright (c) 2014年 秋权mac. All rights reserved.
//

#import "SS_NavigationCell.h"

@implementation SS_NavigationCell

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


+ (instancetype)instanceWithXib
{
    return  [[[NSBundle mainBundle] loadNibNamed:@"SS_NavigationCell" owner:nil options:nil] lastObject];
}
@end
