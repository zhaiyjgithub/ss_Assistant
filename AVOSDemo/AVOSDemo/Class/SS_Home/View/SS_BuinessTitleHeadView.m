//
//  SS_BuinessTitleHeadView.m
//  AVOSDemo
//
//  Created by chuck on 15-1-22.
//  Copyright (c) 2015年 秋权mac. All rights reserved.
//

#import "SS_BuinessTitleHeadView.h"
#import "UIImage+MJ.h"

// 5.获得RGB颜色
#define kColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
//颜色
#define Color(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@implementation SS_BuinessTitleHeadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
        [self setImageview];
    }
    return  self;
}
- (void)setImageview
{
    //self.image = [UIImage resizedImageWithName:@"timeline_card_top_background_line"];
    [self setBackgroundColor:kColor(0xeb, 0xeb, 0xeb)];
    SS_BuinessHeadView *headView = [[SS_BuinessHeadView alloc] init];
    headView.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [headView setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [headView setTitle:@"热门商家" forState:UIControlStateNormal];
    headView.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    headView.enabled = NO;
    self.headerViewButton = headView;
    [self addSubview:headView];
}

@end
