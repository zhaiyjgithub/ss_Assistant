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

- (void)setDetailOfStoreModel:(SS_DetailOfStoreModel *)detailOfStoreModel
{
    _detailOfStoreModel = detailOfStoreModel;
    self.nameLabel.text = detailOfStoreModel.storeName;
    self.phoneLabel.text = detailOfStoreModel.phoneHost;
    
    //根据属性获取图片的rul，然后发起连接！
    //当前使用默认的测试路径 imageContentFils。
    /*
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *Cachepath = [array objectAtIndex:0];
    NSString *path = [NSString stringWithFormat:@"%@/%@",Cachepath,detailOfStoreModel.imageName];
   // NSLog(@"CacheImagePath:%@",path);
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL isExist = [fileManager fileExistsAtPath:path];
    if (isExist) {
        self.storeImage.image = [UIImage imageWithContentsOfFile:path];
    }else{
        [HttpTool downLoadImageWithURL:detailOfStoreModel.imageURL Content_Type:@"image/png"];
        //下载后重新加载
        BOOL isExist = [fileManager fileExistsAtPath:path];
        if (isExist) {
            self.storeImage.image = [UIImage imageWithContentsOfFile:path];
        }else
            NSLog(@"reload failed");
    }
     */
    //不再使用上面的自定义的网络请求方式，使用SDWebImage框架实现图片请求以及缓存
    //添加SDWebImage 处理图片的缓存问题
    
     SDWebImageManager *manager = [SDWebImageManager sharedManager];
     [manager downloadImageWithURL:[NSURL URLWithString:detailOfStoreModel.imageURL] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
     //
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
