//
//  SS_StoreCell.m
//  AVOSDemo
//
//  Created by chuck on 14-12-2.
//  Copyright (c) 2014年 秋权mac. All rights reserved.
//

#import "SS_StoreCell.h"
#import "HttpTool.h"
#import "UIImageView+WebCache.h"

@implementation SS_StoreCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDetailOfStoreFrame:(SS_DetailOfStoreFrame *)detailOfStoreFrame
{
    _detailOfStoreFrame = detailOfStoreFrame;
    self.nameLabel.text = detailOfStoreFrame.detailStoreModel.storeName;
    self.phoneLabel.text = detailOfStoreFrame.detailStoreModel.phoneHost;
    self.instructionLabel.text = detailOfStoreFrame.detailStoreModel.instruction;

    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadImageWithURL:[NSURL URLWithString:detailOfStoreFrame.detailStoreModel.imageURL] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {

    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
     if(image && finished){
         self.storeImage.image = image;
     }
    }];
}


+ (instancetype)instanceWithXib
{
    return [[[NSBundle mainBundle] loadNibNamed:@"SS_StoreCell" owner:nil options:nil] lastObject];
}

@end
