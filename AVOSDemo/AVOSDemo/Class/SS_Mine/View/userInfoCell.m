//
//  userInfoCell.m
//  AVOSDemo
//
//  Created by chuck on 15-1-31.
//  Copyright (c) 2015年 秋权mac. All rights reserved.
//

#import "userInfoCell.h"
#import "WBaccountTool.h"

@implementation userInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupCell];
    }
    return self;
}

- (void)setupCell
{
    
    UIImageView * imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(20, 10, 50, 40);
    _cellImage = imageView;
   // imageView.image = [UIImage imageNamed:@"userInfolocation"];
    [self.contentView addSubview:imageView];
    
    UILabel * titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(imageView.frame.origin.x + imageView.frame.size.width + 20, imageView.center.y - 10, 100, 20);
    titleLabel.font = [UIFont systemFontOfSize:16.0];
    titleLabel.textColor = [UIColor lightGrayColor];
    _cellLabel = titleLabel;
    //titleLabel.text = [WBaccountTool account].location;
    [self.contentView addSubview:titleLabel];
}

@end
