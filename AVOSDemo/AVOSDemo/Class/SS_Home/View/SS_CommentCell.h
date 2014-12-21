//
//  SS_CommentCell.h
//  AVOSDemo
//
//  Created by chuck on 14-12-21.
//  Copyright (c) 2014年 秋权mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SS_DetailOfStoreModel.h"

@interface SS_CommentCell : UITableViewCell
@property(nonatomic,strong)SS_DetailOfStoreModel *commentModel;
@property(nonatomic,strong)UILabel *commentLabel;
//@property(nonatomic,strong)UILabel *commnetPoster;
@property(nonatomic,assign)CGFloat commentCellHeight;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
