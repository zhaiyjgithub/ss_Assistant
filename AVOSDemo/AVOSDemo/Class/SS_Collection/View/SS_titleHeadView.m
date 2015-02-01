//
//  SS_titleHeadView.m
//  AVOSDemo
//
//  Created by chuck on 15-1-18.
//  Copyright (c) 2015年 秋权mac. All rights reserved.
//

#import "SS_titleHeadView.h"
#import "UIImage+MJ.h"
#import "SS_HeadView.h"

// 5.获得RGB颜色
#define kColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
//颜色
#define Color(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@implementation SS_titleHeadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        [self setImageview];
    }
    return  self;
}
- (void)setImageview
{
    self.image = [UIImage resizedImageWithName:@"timeline_card_top_background_line"];
    
    SS_HeadView *headView = [[SS_HeadView alloc] init];
    [headView setTitleColor:kColor(11, 100, 190) forState:UIControlStateNormal];
    //headView.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    headView.enabled = NO;
    self.headerViewButton = headView;
    [self addSubview:headView];
}

@end
