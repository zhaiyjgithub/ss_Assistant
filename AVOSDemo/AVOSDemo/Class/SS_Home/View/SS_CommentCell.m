//
//  SS_CommentCell.m
//  AVOSDemo
//
//  Created by chuck on 14-12-12.
//  Copyright (c) 2014年 秋权mac. All rights reserved.
//

#import "SS_CommentCell.h"

@implementation SS_CommentCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.commentTextView = [[UITextView alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.origin.y+100)];
        self.commentTextView.font = [UIFont fontWithName:@"Arial" size:10.0];
        self.commentTextView.textColor = [UIColor blueColor];
        self.commentTextView.backgroundColor = [UIColor grayColor];
        self.commentTextView.scrollEnabled = YES;
        self.commentTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
        
        [self.contentView addSubview:self.commentTextView];
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

@end
