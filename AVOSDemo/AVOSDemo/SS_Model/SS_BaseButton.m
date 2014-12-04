//
//  SS_BaseButton.m
//  AVOSDemo
//
//  Created by chuck on 14-12-3.
//  Copyright (c) 2014年 秋权mac. All rights reserved.
//

#import "SS_BaseButton.h"

@implementation SS_BaseButton

- (instancetype)initWithType:(BaseButtonType)type
{
    if (self=[super init]) {
        self.baseButtonType=type;
    }
    return self;
}

- (void)layoutSubviews//重写子类按钮的子控件的布局
{
    [super layoutSubviews];  //重写父类都需要先初始化父类的方法
    
    if (self.BaseButtonType == BaseButtonTypeCenter) {
        //设置按钮的图片位置,如果图片没有就使用origin point
        CGPoint center = self.imageView.center;
        center.x = self.frame.size.width/2;
        center.y = self.imageView.frame.size.height/2;
        self.imageView.center = center;
        //设置title的属性
        CGRect frame = [self titleLabel].frame;
        frame.origin.x = 0;
        frame.origin.y = self.imageView.frame.size.height+5;
        frame.size.width = self.frame.size.width;
        self.titleLabel.frame = frame;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = [UIColor blackColor];
        [self.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    }
    
}

@end
