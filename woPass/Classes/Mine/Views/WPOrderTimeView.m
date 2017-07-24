//
//  WPOrderTimeView.m
//  woPass
//
//  Created by 王蕾 on 15/7/24.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPOrderTimeView.h"

@implementation WPOrderTimeView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *icon = [[UIView alloc]initWithFrame:CGRectMake(10, 8, 5, 15)];
        icon.backgroundColor = RGBCOLOR_HEX(KTextOrangeColor);
        [self addSubview:icon];
        
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(icon.right+5, icon.top, 100, 16)];
        title.font = [UIFont systemFontOfSize:16];
        title.textColor = RGBCOLOR_HEX(kLabelDarkColor);
        title.text = @"使用时间";
        [self addSubview:title];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10, icon.bottom+5, SCREEN_WIDTH-20, 0.3)];
        line.backgroundColor = RGBCOLOR_HEX(kMargineColor);
        [self addSubview:line];
        
        self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, line.bottom+9, SCREEN_WIDTH-30, 20)];
        self.timeLabel.font = [UIFont systemFontOfSize:13];
        self.timeLabel.textColor = RGBCOLOR_HEX(kLabelDarkColor);
        [self addSubview:self.timeLabel];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)layoutSubviews{
    self.timeLabel.text = self.timeStr;
}

@end
