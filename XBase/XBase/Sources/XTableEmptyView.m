//
//  CTableEmptyView.m
//  HotelManager
//
//  Created by Tulipa on 14-6-5.
//  Copyright (c) 2014年 Tulipa. All rights reserved.
//

#import "XTableEmptyView.h"

@interface XTableEmptyView ()
{
    UILabel* msgLabel;
}
@end

@implementation XTableEmptyView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor:RGBCOLOR(239, 239, 239)];
        msgLabel = [[UILabel alloc] init];
        [msgLabel setBackgroundColor:[UIColor clearColor]];
        [msgLabel setTextColor:[UIColor blackColor]];
        [msgLabel setFont:[UIFont systemFontOfSize:16]];
        [msgLabel setNumberOfLines:0];
        [msgLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:msgLabel];
    }
    return self;
}

- (void)setMsg:(NSString *)msg
{
    _msg = msg;
    [msgLabel setText:_msg];
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [msgLabel setSize:[msgLabel sizeThatFits:self.size]];
    [msgLabel setCenter:self.center];
}

@end
