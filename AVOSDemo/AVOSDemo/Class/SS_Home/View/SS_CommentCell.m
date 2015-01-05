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
    UILabel *commmentLabel = [[UILabel alloc] init];
    commmentLabel.numberOfLines = 0; //显示多行
    self.commentLabel = commmentLabel;//引用该按钮
    //设置该label的字体以及大小，否则在下面计算过程中会调用默认的系统字体大小
    self.commentLabel.font = [UIFont systemFontOfSize:FONTSIZE];
    
    [self.contentView addSubview:commmentLabel];
}
//在请求时候就建立好数据属性设置，并保存再数据源当中
- (void)setCommentFrame:(SS_CommentFrame *)commentFrame
{
    _commentFrame = commentFrame;
    //获取评论Label的高度以及内容
    self.commentLabel.frame = commentFrame.commentLabelFrame;
    self.commentLabel.text = commentFrame.commmentModel.comment;
    //获取对应的cell的高度
    self.commentCellHeight = commentFrame.CellHeight;
  
}
@end
