//
//  UILabel+Helper.m
//  BabyDress
//
//  Created by 臧金晓 on 15/1/1.
//  Copyright (c) 2015年 7ul.ipa. All rights reserved.
//

#import "UILabel+Helper.h"

@implementation UILabel (Helper)

+ (instancetype)labelWithFontSize:(CGFloat)size color:(UIColor *)color backgroundColor:(UIColor *)bgColor
{
    UILabel *label = [[[self class] alloc] initWithFrame:CGRectZero];
    [label setFont:XFont(size)];
    [label setBackgroundColor:bgColor];
    [label setTextColor:color];
    return label;
}

+ (instancetype)labelWithFontSize:(CGFloat)size color:(UIColor *)color
{
    return [[self class] labelWithFontSize:size color:color backgroundColor:[UIColor clearColor]];
}

+ (instancetype)labelWithFontSize:(CGFloat)size
{
    return [[self class] labelWithFontSize:size color:[UIColor blackColor]];
}

@end
