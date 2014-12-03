//
//  SS_NavigationCell.h
//  AVOSDemo
//
//  Created by chuck on 14-12-2.
//  Copyright (c) 2014年 秋权mac. All rights reserved.
//

#import "SS_BaseCell.h"

typedef void(^setIconBlock) (id sender);
@interface SS_NavigationCell : SS_BaseCell

@property(nonatomic,copy)setIconBlock iconBlock;

- (IBAction)setDapaidang:(UIButton *)sender;
- (void)addBlock:(setIconBlock)block;
+ (instancetype)instanceWithXib;
@end
