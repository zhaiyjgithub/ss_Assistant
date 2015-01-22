//
//  SS_BuinessHeadView.m
//  AVOSDemo
//
//  Created by chuck on 15-1-22.
//  Copyright (c) 2015年 秋权mac. All rights reserved.
//

#import "SS_BuinessHeadView.h"

@implementation SS_BuinessHeadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setImage:[UIImage imageNamed:@"hotStore"] forState:UIControlStateNormal];
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return  CGRectMake(10, 5, 30, 30);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(45, 12.5, 60, 15);
}

@end
