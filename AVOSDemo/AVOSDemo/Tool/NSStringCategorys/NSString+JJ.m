//
//  NSString+JJ.m
//  易商
//
//  Created by 伍松和 on 14/10/23.
//  Copyright (c) 2014年 Ruifeng. All rights reserved.
//

#import "NSString+JJ.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (JJ)
/**
 *  MD5Hash
 */
- (NSString *)MD5Hash{
    
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}
/**
 *  stringByTrimingWhitespace
 */
- (NSString *)stringByTrimingWhitespace{

    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

}
/**
 *  行数
 */
- (NSUInteger)numberOfLines{

    return [[self componentsSeparatedByString:@"\n"] count] + 1;

}
/**
 *  计算文章size
 */
- (CGSize)sizeWithFont:(UIFont*)font
               maxSize:(CGSize)maxSize{

    NSDictionary * attrs=@{NSFontAttributeName: font};
    
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
/**
 *  URL解码

 */
- (NSString *)URLEncodedString
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                             (CFStringRef)self,
                                                                                             NULL,
                                                                                             CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                                             kCFStringEncodingUTF8));
    
    return result;
}

- (NSString*)URLDecodedString
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                                             (CFStringRef)self,
                                                                                                             CFSTR(""),
                                                                                                             kCFStringEncodingUTF8));
    
    return result;	
}

- (NSString *)fileAppend:(NSString *)append{

    // 1.1.获得文件拓展名
    NSString *ext = [self pathExtension];
    
    // 1.2.删除最后面的扩展名
    NSString *imgName = [self stringByDeletingPathExtension];
    
    // 1.3.拼接-568h@2x
    imgName = [imgName stringByAppendingString:append];
    
    // 1.4.拼接扩展名
    return [imgName stringByAppendingPathExtension:ext];
}
@end
