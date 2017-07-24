//
//  WPTicketRuleView.m
//  woPass
//
//  Created by 王蕾 on 15/7/24.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPTicketRuleView.h"

@implementation WPTicketRuleView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIView *icon = [[UIView alloc]initWithFrame:CGRectMake(10, 8, 5, 15)];
        icon.backgroundColor = [UIColor colorWithRed:59/255.f green:153/255.f blue:217/255.f alpha:1];
        [self addSubview:icon];
        //59 153 217
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(icon.right+5, icon.top, 100, 16)];
        title.font = [UIFont systemFontOfSize:16];
        title.textColor = RGBCOLOR_HEX(kLabelDarkColor);
        title.text = @"使用规则";
        [self addSubview:title];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10, icon.bottom+5, SCREEN_WIDTH-20, 0.5)];
        line.backgroundColor = RGBCOLOR_HEX(kMargineColor);
        [self addSubview:line];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, line.bottom+12, SCREEN_WIDTH-30, 12)];
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = RGBCOLOR_HEX(kLabelDarkColor);
        label.text = @"1.获取优惠券后在商城里面可以找到兑换码；";
        label.backgroundColor = [UIColor clearColor];
        [self addSubview:label];
        
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(15, label.bottom+10, SCREEN_WIDTH-30, 12)];
        label2.font = [UIFont systemFontOfSize:12];
        label2.textColor = RGBCOLOR_HEX(kLabelDarkColor);
        label2.text = @"2.最终解释权归官方所有。";
        label2.backgroundColor = [UIColor clearColor];
        [self addSubview:label2];
        
    }
    return self;
}


@end
