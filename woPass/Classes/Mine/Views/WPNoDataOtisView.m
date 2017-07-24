//
//  WPNoDataOtisView.m
//  woPass
//
//  Created by 王蕾 on 15/7/24.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPNoDataOtisView.h"

@implementation WPNoDataOtisView


- (instancetype)initForCoupon{
    self = [super initWithFrame:CGRectMake(0, 112, SCREEN_WIDTH, SCREEN_HEIGHT-300)];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 213, 115)];
        imageView.center = CGPointMake(SCREEN_WIDTH*0.5, 115*0.5);
        imageView.image = [UIImage imageNamed:@"coupons1"];
        [self addSubview:imageView];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
        label.textAlignment = NSTextAlignmentCenter;
        label.center = imageView.center;
        label.top = imageView.bottom +10;
        label.text = @"小沃还没准备好代金券";
        label.textColor = RGBCOLOR_HEX(kLabelWeakColor);
        label.font = [UIFont systemFontOfSize:kFontLarge];
        [self addSubview: label];
    }
    return self;
}

- (instancetype)init
{
    self = [super initWithFrame:CGRectMake(0, 112, SCREEN_WIDTH, SCREEN_HEIGHT-300)];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 213, 115)];
        imageView.center = CGPointMake(SCREEN_WIDTH*0.5, 115*0.5);
        imageView.image = [UIImage imageNamed:@"coupons1"];
        [self addSubview:imageView];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
        label.textAlignment = NSTextAlignmentCenter;
        label.center = imageView.center;
        label.top = imageView.bottom +10;
        label.text = @"没有此类优惠券";
        label.textColor = RGBCOLOR_HEX(kLabelWeakColor);
        label.font = [UIFont systemFontOfSize:kFontLarge];
        [self addSubview: label];
    }
    return self;
}
-(instancetype)initForOrder{
    self = [super initWithFrame:CGRectMake(0, 115, SCREEN_WIDTH, SCREEN_HEIGHT-300)];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 230*0.5, 170*0.5)];
        imageView.center = CGPointMake(SCREEN_WIDTH*0.5, 115*0.5);
        imageView.image = [UIImage imageNamed:@"dingdan"];
        [self addSubview:imageView];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
        label.textAlignment = NSTextAlignmentCenter;
        label.center = imageView.center;
        label.top = imageView.bottom +15;
        label.text = @"没有此类订单";
        label.textColor = RGBCOLOR_HEX(kLabelWeakColor);
        label.font = [UIFont systemFontOfSize:kFontLarge];
        [self addSubview: label];
    }
    return self;
}

@end
