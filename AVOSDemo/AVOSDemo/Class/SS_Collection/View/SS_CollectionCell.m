//
//  SS_CollectionCell.m
//  AVOSDemo
//
//  Created by chuck on 15-1-18.
//  Copyright (c) 2015年 秋权mac. All rights reserved.
//

#import "SS_CollectionCell.h"
#import "UIImage+MJ.h"

@implementation SS_CollectionCell

- (void)setStoreFrame:(SS_CollectionFrame *)storeFrame
{
    _storeFrame = storeFrame;
    //商家名称
    _storeNameLabel.text = storeFrame.inDBModel.storeName;
    
    //简介
    _storeInstructionLabel.frame = storeFrame.instructionFrame;
    _storeInstructionLabel.text = storeFrame.inDBModel.instruction;
    _storeAddesssLabel.frame = storeFrame.addressFrame;
    _storeAddesssLabel.text = @"待定！！！";
    
    _addressDot.frame = CGRectMake(10, _storeAddesssLabel.frame.origin.y +
                                   3, 10, 10);
    _addressDot.image = [UIImage resizedImageWithName:@"new_dot_os7"];
    
}


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
    //使用拉伸的方式加载图片
    /*
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage resizedImageWithName:@"timeline_card_top_background"];
    self.backgroundView = imageView;
    */
   // self.backgroundColor = [UIColor lightGrayColor];
    // [cell setSelectionStyle:UITableViewCellSelectionStyleNone];//使用该事件就不会了。
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];//
    UILabel * nameLabel = [[UILabel alloc] init];
    nameLabel.frame = CGRectMake(10, 10, 200, 15);
    nameLabel.font = [UIFont systemFontOfSize:20.0];
    _storeNameLabel = nameLabel;
    [self.contentView addSubview:nameLabel];
    //self.userInteractionEnabled
    
    //简介
    UILabel * instructionLabel = [[UILabel alloc] init];
    instructionLabel.font = [UIFont systemFontOfSize:13.0];
    instructionLabel.numberOfLines =0;
    _storeInstructionLabel = instructionLabel;
    [self.contentView addSubview:instructionLabel];
    
    //new_dot_os7
    UIImageView *instructionDot = [[UIImageView alloc] init];
    instructionDot.frame = CGRectMake(10, instructionLabel.frame.origin.y, 10, 10);
    instructionDot.image = [UIImage resizedImageWithName:@"new_dot_os7"];
    instructionDot.frame = CGRectMake(10, 43, 10, 10);

    [self.contentView addSubview:instructionDot];
    
    //地址
    UILabel * addressLabel = [[UILabel alloc] init];
    addressLabel.font = [UIFont systemFontOfSize:13.0];
    addressLabel.numberOfLines = 0;
    _storeAddesssLabel = addressLabel;
    [self.contentView addSubview:addressLabel];
    
    UIImageView * addressDot = [[UIImageView alloc] init];
    _addressDot = addressDot;
    [self.contentView addSubview:addressDot];
    
//    UIImageView * phoneImageView = [[UIImageView alloc] init];
//    phoneImageView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 80, 30, 30, 30);
//    phoneImageView.image = [UIImage imageNamed:@"about_phone_icon"];
//    [self.contentView addSubview:phoneImageView];
    UIButton * phoneButton = [[UIButton alloc] init];
    phoneButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 50, 25, 35, 35);
    [phoneButton setImage:[UIImage imageNamed:@"about_phone_icon"] forState:UIControlStateNormal];
    [phoneButton setBackgroundImage:[UIImage imageNamed:@"timeline_card_middlebottom_highlighted_os7"] forState:UIControlStateHighlighted];
    [phoneButton addTarget:self action:@selector(clickPhoneButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:phoneButton];
    
    UIImageView * divider = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line_highlighted_os7_H"]];
    divider.frame = CGRectMake(phoneButton.frame.origin.x - 1, 20, 1, 40);
    [self.contentView addSubview:divider];

}

- (void)clickPhoneButton:(id)sender
{
    if (self.phoneButtonBlock) {
        self.phoneButtonBlock(sender);
    }
}
//外面添加block
- (void)addBlockForPhoneButton:(ButtonBlock)block
{
    self.phoneButtonBlock = block;
}

@end
