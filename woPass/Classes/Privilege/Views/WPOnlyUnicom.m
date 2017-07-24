//
//  WPOnlyUnicom.m
//  woPass
//
//  Created by 王蕾 on 15/8/3.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPOnlyUnicom.h"

@implementation WPOnlyUnicom

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 13, 13)];
        image.image = [UIImage imageNamed:@"iconfont-warn"];
        [self addSubview:image];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(image.right+5, 0, frame.size.width-20, frame.size.height)];
        label.textColor = RGBCOLOR_HEX(0x720019);
        label.font = [UIFont systemFontOfSize:12];
        label.text = @"只支持联通手机号充值，请确定号码。";
        [self addSubview:label];
    }
    return self;
}

@end
