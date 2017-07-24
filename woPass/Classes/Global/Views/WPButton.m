//
//  WPButton.m
//  woPass
//
//  Created by htz on 15/7/19.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPButton.h"

@implementation WPButton

- (instancetype)initWithTitle:(NSString *)title {
    
    if (self = [super init]) {
        
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageWithColor:RGBCOLOR_HEX(KTextOrangeColor)] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageWithColor:RGBCOLOR_HEX(kDisableBgColor)] forState:UIControlStateDisabled];
        self.layer.cornerRadius = 5;
        self.layer.borderColor = RGBCOLOR_HEX(kMargineColor).CGColor;
        self.layer.borderWidth = 1;
        self.layer.masksToBounds = YES;
        self.titleLabel.font = XFont(kFontLarge);
    }
    return self;
}



@end
