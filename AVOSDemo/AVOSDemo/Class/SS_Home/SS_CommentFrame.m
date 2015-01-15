//
//  SS_CommentFrame.m
//  AVOSDemo
//
//  Created by chuck on 15-1-4.
//  Copyright (c) 2015年 秋权mac. All rights reserved.
//

#import "SS_CommentFrame.h"
#import "NSString+JJ.h"
#import "cellCommon.h"

#define COMMENT_LABEL_FONTSIZE  13.0
#define COMMENT_LABEL_BOARDER_X  10.0
#define COMMENT_LABEL_BOARDER_Y  5.0

@implementation SS_CommentFrame

- (void)setCommmentModel:(SS_CommentModel *)commmentModel
{
    _commmentModel = commmentModel;/////???
  
    CGSize textSize = [commmentModel.comment sizeWithFont:[UIFont systemFontOfSize:FONTSIZE] maxSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, MAXFLOAT)];
    _commentLabelFrame = CGRectMake(COMMENT_LABEL_BOARDER_X, COMMENT_LABEL_BOARDER_Y, textSize.width, textSize.height);
    _CellHeight = (textSize.height + COMMENT_LABEL_BOARDER_Y*2);
}
@end
