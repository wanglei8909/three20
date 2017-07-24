//
//  WPShopsInfoView.m
//  woPass
//
//  Created by 王蕾 on 15/7/24.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPShopsInfoView.h"
#import "UIImageView+WebCache.h"

@implementation WPShopsInfoView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIView *icon = [[UIView alloc]initWithFrame:CGRectMake(10, 8, 5, 15)];
        icon.backgroundColor = [UIColor colorWithRed:98/255.f green:121/255.f blue:222/255.f alpha:1];
        [self addSubview:icon];
        //59 153 217
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(icon.right+5, icon.top, 100, 16)];
        title.font = [UIFont systemFontOfSize:16];
        title.textColor = RGBCOLOR_HEX(kLabelDarkColor);
        title.text = @"商家信息";
        [self addSubview:title];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10, icon.bottom+5, SCREEN_WIDTH-20, 0.5)];
        line.backgroundColor = RGBCOLOR_HEX(kMargineColor);
        [self addSubview:line];
        
        _icon = [[UIImageView alloc]initWithFrame:CGRectMake(15, line.bottom+12, 37.5, 37.5)];
        [self addSubview:_icon];
        
        _name = [[UILabel alloc]initWithFrame:CGRectMake(_icon.right+5, _icon.top, SCREEN_WIDTH-120, 16)];
        _name.font = [UIFont systemFontOfSize:16];
        _name.textColor = RGBCOLOR_HEX(kLabelDarkColor);
        _name.text = @"获取优惠券后在商城里面可以找到兑换码；";
        _name.backgroundColor = [UIColor clearColor];
        [self addSubview:_name];
        
        _address = [[UILabel alloc]initWithFrame:CGRectMake(_icon.right+5, _name.bottom+5, SCREEN_WIDTH-120, 12)];
        _address.font = [UIFont systemFontOfSize:12];
        _address.textColor = RGBCOLOR_HEX(kLabelWeakColor);
        _address.text = @"最终解释权归官方所有。";
        _address.backgroundColor = [UIColor clearColor];
        [self addSubview:_address];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(SCREEN_WIDTH-60, line.bottom, 60, 65);
        btn.backgroundColor = [UIColor clearColor];
        [btn setImage:[UIImage imageNamed:@"iconfont-tel"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(MakeCall) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    return self;
}
-(void)layoutSubviews{
    [_icon sd_setImageWithURL:[NSURL URLWithString:self.iconUrl] placeholderImage:[UIImage imageNamed:@"iconfont-dianpu"]];
    _name.text = self.nameStr;
    _address.text = self.addressStr;
}
- (void)MakeCall{
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%ld",self.phoneNum]];
    UIWebView *phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
    [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
    [self addSubview:phoneCallWebView];
}

@end
