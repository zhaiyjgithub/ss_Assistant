//
//  SS_DetailStoreCell.m
//  AVOSDemo
//
//  Created by chuck on 15-1-12.
//  Copyright (c) 2015年 秋权mac. All rights reserved.
//

#import "SS_DetailStoreCell.h"
#import "UIImageView+WebCache.h"

@implementation SS_DetailStoreCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupCell];
    }
    return self;
}

- (void)setDetailStoreFrame:(SS_DetailOfStoreFrame *)detailStoreFrame
{
    _detailStoreFrame = detailStoreFrame;
//设置商家图片
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadImageWithURL:[NSURL URLWithString:_detailStoreFrame.detailStoreModel.imageURL] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
    if(image && finished){
        self.storeImage.image = image;
    }
    }];
 //设置商家的名称，详情，地址
    self.storeName.text = _detailStoreFrame.detailStoreModel.storeName;
    //暂时是用评论的frame,后面添加地址成员
    _storeInstruction.frame = detailStoreFrame.instructionFrame;
    _storeInstruction.text = detailStoreFrame.detailStoreModel.instruction;
    _storeAddress.frame = detailStoreFrame.instructionFrame;
    //暂时使用简介的内容
    _storeAddress.text = @"132321";//detailStoreFrame.detailStoreModel.instruction;

    //按钮
    self.collectBtn = [self addBtnWithTitle:@"收藏" image:@"timeline_icon_unlike_os7" bImage:@"timeline_card_leftbottom_highlighted_os7" index:0];
    self.commentBtn = [self addBtnWithTitle:@"评论" image:@"timeline_icon_comment_os7" bImage:@"timeline_card_middlebottom_highlighted_os7" index:1];
    [self.commentBtn addTarget:self action:@selector(clickComment:) forControlEvents:UIControlEventTouchUpInside];
    
    self.shareBtn = [self addBtnWithTitle:@"分享" image:@"timeline_icon_retweet_os7" bImage:@"timeline_card_rightbottom_highlighted_os7" index:2];
    
    //添加分割线
    UIImageView *divider1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line_highlighted_os7"]];
    divider1.frame = CGRectMake(10, self.collectBtn.frame.origin.y-1, self.frame.size.width-10, 1);
    [self.contentView addSubview:divider1];
}

- (void)setupCell
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 195)];
    _storeImage = imageView;
    [self.contentView addSubview:imageView];
    
    
    //名称
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(10, 200, self.frame.size.width, 25)];
    name.font = [UIFont systemFontOfSize:20.0];
    _storeName = name;
    [self.contentView addSubview:name];
    
    //电话
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 70, 200, 60, 70)];
    [btn setImage:[UIImage imageNamed:@"about_phone_icon"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"timeline_card_middlebottom_highlighted_os7"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(clickPhone:) forControlEvents:UIControlEventTouchUpInside];
    _phoneBtn = btn;
    [self.contentView addSubview:btn];
    //划线
    UIImageView *divider2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line_highlighted_os7_H"]];
    divider2.frame = CGRectMake(self.phoneBtn.frame.origin.x - 2, 210, 1, 50);
    [self.contentView addSubview:divider2];

    //详情
    UILabel *instruction = [[UILabel alloc] init];
    instruction.font = [UIFont systemFontOfSize:13.0];
    [instruction setTextColor:[UIColor grayColor]];
    self.storeInstruction = instruction;
    [self.contentView addSubview:instruction];
    //地址
    UILabel *adderss = [[UILabel alloc] init];
    adderss.font = [UIFont systemFontOfSize:13.0];
    self.storeAddress = adderss;
    [self.contentView addSubview:adderss];
}

- (UIButton *)addBtnWithTitle:(NSString *)title image:(NSString *)image bImage:(NSString *)bImage  index:(int)index
{
    UIButton * btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [btn setBackgroundImage:[UIImage imageNamed:bImage] forState:UIControlStateHighlighted];
    //调整按钮控件中图片与文字之间的间距
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    
    int i = index%3;
    int with = self.frame.size.width/3;
    
    btn.frame = CGRectMake(i*with, _detailStoreFrame.imageAndLabelHeight+5, with, 50);
    [self.contentView addSubview:btn];
    
    return btn;
}

- (void)clickComment:(id)sender
{
    NSLog(@"comment btn");
    if (self.commentBlock){
        self.commentBlock(sender);
    }
}

- (void)addBlock:(ButtonBlock)commentBlock phoneBlock:(ButtonBlock)phoneBlock
{
    self.commentBlock = commentBlock;
    self.phoneBlock = phoneBlock;
}

- (void)clickPhone:(id)sender
{
    if (self.phoneBlock) {
        self.phoneBlock(sender);
    }
}

@end
