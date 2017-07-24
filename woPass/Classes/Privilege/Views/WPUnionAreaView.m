//
//  WPUnionAreaView.m
//  woPass
//
//  Created by 王蕾 on 15/8/12.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPUnionAreaView.h"

@implementation WPUnionAreaView

-(instancetype)init{
    self = [super initWithFrame:CGRectMake(20, 78, 260, 32)];
    if (self) {
        UIImageView *logo = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 32, 25)];
        logo.image = [UIImage imageNamed:@"logo64-"];
        [self addSubview:logo];
        
        _areaString = @"中国联通";
        
        _areaLabel = [[UILabel alloc]initWithFrame:CGRectMake(logo.right+5, 0, 200, 20)];
        _areaLabel.center = CGPointMake(_areaLabel.centerX, logo.centerY);
        _areaLabel.textColor = RGBCOLOR_HEX(kLabelDarkColor);
        _areaLabel.font = [UIFont systemFontOfSize:16];
        _areaLabel.text = _areaString;
        [self addSubview:_areaLabel];
    }
    return self;
}
-(void)setAreaString:(NSString *)areaString{
    _areaString = areaString;
    _areaLabel.text = _areaString;
}

@end
