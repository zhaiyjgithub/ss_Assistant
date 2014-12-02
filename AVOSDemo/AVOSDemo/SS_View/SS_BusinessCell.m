//
//  SS_BusinessCell.m
//  AVOSDemo
//
//  Created by 秋权mac on 14-11-25.
//  Copyright (c) 2014年 秋权mac. All rights reserved.
//

#import "SS_BusinessCell.h"

@implementation SS_BusinessCell

+(instancetype)instanceWithXib{

   return  [[[NSBundle mainBundle]loadNibNamed:@"SS_BusinessCell" owner:nil options:nil]lastObject];
}

-(void)setBusinessModel:(SS_BusinessModel *)businessModel{

    _businessModel=businessModel;
    
    //1UI
    
    self.titleLab.text=businessModel.b_name;
    self.detailLab.text=businessModel.b_des;
    [self.logoView setImageWithURL:[NSURL URLWithString:businessModel.b_logo] placeholderImage:[UIImage imageNamed:@"contacts_phone@2x 2"]];
}

@end
