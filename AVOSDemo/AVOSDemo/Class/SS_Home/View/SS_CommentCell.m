//
//  SS_CommentCell.m
//  AVOSDemo
//
//  Created by chuck on 14-12-21.
//  Copyright (c) 2014年 秋权mac. All rights reserved.
//

#import "SS_CommentCell.h"
#import "NSString+JJ.h"
#import "cellCommon.h"
#import "controllerCommon.h"
#import "cellCommon.h"

@implementation SS_CommentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //add init code ....
        [self addLabel];
    }
    return  self;
}

- (void)addLabel
{
    //评论者
    UILabel *poster =  [[UILabel alloc] init];
    poster.font = [UIFont systemFontOfSize: 14.0];
    poster.frame = CGRectMake(15, 10, COMMENT_POSTER_WIDTH, COMMENT_POSTER_HEIGHT);
    self.commentPoster = poster;
    [self.contentView addSubview:poster];
    
    //评论时间
    UILabel *postTime = [[UILabel alloc] init];
    postTime.font = [UIFont systemFontOfSize:14.0];
    postTime.frame = CGRectMake(poster.frame.origin.x + COMMENT_POSTER_WIDTH + 10, poster.frame.origin.y, 80, COMMENT_POSTER_HEIGHT);
    postTime.textColor = [UIColor grayColor];
    self.commentTime = postTime;
    [self.contentView addSubview:postTime];
    
    UILabel *commentLabel = [[UILabel alloc] init];
    commentLabel.numberOfLines = 0; //显示多行
    //设置该label的字体以及大小，否则在下面计算过程中会调用默认的系统字体大小
    commentLabel.font = [UIFont systemFontOfSize:FONTSIZE];
    commentLabel.textColor = [UIColor grayColor];
    self.commentLabel = commentLabel;
    [self.contentView addSubview:commentLabel];

}
//在请求时候就建立好数据属性设置，并保存再数据源当中
- (void)setCommentFrame:(SS_CommentFrame *)commentFrame
{
    _commentFrame = commentFrame;
    NSRange commentTimeRange = {0,10};
    //获取评论Label的高度以及内容
    self.commentLabel.frame = commentFrame.commentLabelFrame;
    self.commentLabel.text = commentFrame.commmentModel.comment;
    self.commentPoster.text = commentFrame.commmentModel.commentPoster;
    self.commentTime.text = [commentFrame.commmentModel.createdAt substringWithRange:commentTimeRange];
    //获取对应的cell的高度
    self.commentCellHeight = commentFrame.CellHeight;
  
}
@end
