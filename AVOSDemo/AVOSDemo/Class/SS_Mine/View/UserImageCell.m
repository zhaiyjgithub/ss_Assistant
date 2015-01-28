//
//  UserImageCell.m
//  AVOSDemo
//
//  Created by chuck on 15-1-28.
//  Copyright (c) 2015年 秋权mac. All rights reserved.
//

#import "UserImageCell.h"
#import "WBaccountTool.h"
#import "UIImageView+WebCache.h"

@implementation UserImageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupCell];
    }
    return self;
}
//用户数据，其中包含了头像的URL
#define WB_ACCOUNT_FILE_PATH   [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.arch"]

- (void)setupCell
{
    UIImageView * headImageView = [[UIImageView alloc] init];
    headImageView.frame = CGRectMake(10, 10, 70, 70);
    NSLog(@"profile_url:%@",[WBaccountTool account].profile_image_url);
    NSURL * url = [NSURL URLWithString:[WBaccountTool account].profile_image_url];
//    NSData * imageData = [NSData dataWithContentsOfURL:url];
    UIImage * image = [self readImageDataFromFile];
    if (image) {
        //从归档中直接读取数据
        headImageView.image = image;
    }else{
        //如果本地没有存储直接发起网路请求
        SDWebImageManager * manager = [SDWebImageManager sharedManager];
        [manager downloadImageWithURL:url options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            headImageView.image = image;
            [self writeImageDataToFile:headImageView.image];
        }];
    }
    
    [self.contentView addSubview:headImageView];
}

- (void)writeImageDataToFile:(UIImage *)image
{
    NSData * imageData = [NSKeyedArchiver archivedDataWithRootObject:image];
    [[NSUserDefaults standardUserDefaults] setObject:imageData forKey:@"headImage"];
}
- (UIImage *)readImageDataFromFile
{
    NSData * imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"headImage"];
    UIImage * image = [NSKeyedUnarchiver unarchiveObjectWithData:imageData];
    
    return image;
}
@end
