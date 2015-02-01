//
//  ImageViewTransform.h
//  AVOSDemo
//
//  Created by chuck on 15-2-1.
//  Copyright (c) 2015年 秋权mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageViewTransform : NSObject
+ (void)imageViewRotateAnimation:(UIImageView *)currentImg;
+ (void)imageViewRotateAnimation:(UIImageView *)currentImg from:(id)fromValue
                              to:(id)toValue duration:(CFTimeInterval)duration;
@end
