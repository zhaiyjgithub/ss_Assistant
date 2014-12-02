//
//  NSString+JJ.h
//  易商
//
//  Created by 伍松和 on 14/10/23.
//  Copyright (c) 2014年 Ruifeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JJ)
/**
 *  MD5Hash
 */
- (NSString *)MD5Hash;
/**
 *  stringByTrimingWhitespace
 */
- (NSString *)stringByTrimingWhitespace;
/**
 *  行数
 */
- (NSUInteger)numberOfLines;
/**
 *  计算文章size
 */
- (CGSize)sizeWithFont:(UIFont*)font
              maxSize:(CGSize)maxSize;

- (NSString *)URLEncodedString;
- (NSString *)URLDecodedString;
- (NSString *)fileAppend:(NSString *)append;

@end
