//
//  SS_CommentFrame.h
//  AVOSDemo
//
//  Created by chuck on 15-1-4.
//  Copyright (c) 2015年 秋权mac. All rights reserved.
//

#import "SS_BaseModel.h"
#import "SS_CommentModel.h"

@interface SS_CommentFrame : SS_BaseModel
@property(nonatomic,strong)SS_CommentModel *commmentModel;
@property(nonatomic,assign,readonly)CGRect commentLabelFrame;
@property(nonatomic,assign,readonly)CGFloat CellHeight;
@end
