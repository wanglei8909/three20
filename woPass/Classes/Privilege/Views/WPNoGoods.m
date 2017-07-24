//
//  WPNoGoods.m
//  woPass
//
//  Created by 王蕾 on 15/8/3.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPNoGoods.h"

@implementation WPNoGoods

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 82.5, 75)];
        image.image = [UIImage imageNamed:@"kong"];
        image.center = CGPointMake(self.centerX, image.centerY);
        [self addSubview:image];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, image.bottom+5, SCREEN_WIDTH, 20)];
        label.textColor = RGBCOLOR_HEX(kLabelWeakColor);
        label.font = [UIFont systemFontOfSize:16];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"抱歉，暂时缺货";
        label.center = CGPointMake(image.centerX, image.bottom+15);
        [self addSubview:label];
    }
    return self;
}


@end
