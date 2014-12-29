//
//  commentTitleCell.h
//  AVOSDemo
//
//  Created by chuck on 14-12-22.
//  Copyright (c) 2014年 秋权mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface commentTitleCell : UITableViewCell
@property(nonatomic,strong)UILabel *TitleLabel;
//可能要添加图片，仿照美团

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
