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

- (void)setCommentModel:(SS_CommentModel *)commentModel
{
    _commentModel = commentModel;
    //再这里这是label的位置以及大小信息
    self.commentLabel.text = commentModel.comment;
    //不再使用就的方法
    //CGSize textSize = [commentModel.instruction sizeWithFont:[UIFont systemFontOfSize:13.0] maxSize:CGSizeMake(320, MAXFLOAT)];
    //使用新方法计算文字大小
    CGSize textSize = [commentModel.comment sizeWithFont:[UIFont systemFontOfSize:FONTSIZE] maxSize:CGSizeMake(300, MAXFLOAT)];

    //设置label的大小以及cell的高度
    self.commentLabel.frame = CGRectMake(self.frame.origin.x+COMMENTBOAR_X, self.frame.origin.y +COMMENTBOAR_Y, textSize.width, textSize.height);
    //获取这个cell的高度
    self.commentCellHeight = textSize.height+5;
}



@end
