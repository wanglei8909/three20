//
//  UILabel+Helper.h
//  BabyDress
//
//  Created by 臧金晓 on 15/1/1.
//  Copyright (c) 2015年 7ul.ipa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Helper)

+ (instancetype)labelWithFontSize:(CGFloat)size color:(UIColor *)color backgroundColor:(UIColor *)bgColor;
+ (instancetype)labelWithFontSize:(CGFloat)size color:(UIColor *)color;
+ (instancetype)labelWithFontSize:(CGFloat)size;

@end
