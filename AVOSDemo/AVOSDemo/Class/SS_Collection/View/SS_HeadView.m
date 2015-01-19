//
//  SS_HeadView.m
//  AVOSDemo
//
//  Created by chuck on 15-1-18.
//  Copyright (c) 2015年 秋权mac. All rights reserved.
//

#import "SS_HeadView.h"

@implementation SS_HeadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up_os7"] forState:UIControlStateNormal];
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(10, 17.5, 15, 15);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(35, 17.5,150, 15);
}


@end
