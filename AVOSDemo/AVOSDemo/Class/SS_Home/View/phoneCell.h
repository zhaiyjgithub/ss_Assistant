//
//  phoneCell.h
//  AVOSDemo
//
//  Created by chuck on 14-12-15.
//  Copyright (c) 2014年 秋权mac. All rights reserved.
//

#import "SS_BaseCell.h"

@interface phoneCell : SS_BaseCell
@property (weak, nonatomic) IBOutlet UILabel *schoolName;
@property (weak, nonatomic) IBOutlet UILabel *schoolPhone;


+(instancetype)instanceWithXib;
@end
