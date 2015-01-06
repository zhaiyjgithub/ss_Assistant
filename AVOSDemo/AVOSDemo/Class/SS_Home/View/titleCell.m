//
//  commentTitleCell.m
//  AVOSDemo
//
//  Created by chuck on 14-12-22.
//  Copyright (c) 2014年 秋权mac. All rights reserved.
//

#import "titleCell.h"

@implementation commentTitleCell

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
        //init the code here...
        [self initTitle];
    }
    return self;
}

- (void)initTitle
{
    self.backgroundColor = [UIColor lightGrayColor];
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(self.frame.origin.x+5, self.frame.origin.y+5, 50, 10);
    self.TitleLabel = label;
    
    [self.contentView addSubview:label];
}
@end
