//
//  SS_BaseButton.h
//  AVOSDemo
//
//  Created by chuck on 14-12-3.
//  Copyright (c) 2014年 秋权mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BaseButtonType) {
    BaseButtonTypeCenter,
    BaseButtonTypeDefault,
};

@interface SS_BaseButton : UIButton

@property(nonatomic,assign)BaseButtonType BaseButtonType;
- (instancetype)initWithType:(BaseButtonType)type;
@end
