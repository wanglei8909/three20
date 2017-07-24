//
//  WPStepper.m
//  woPass
//
//  Created by 王蕾 on 15/8/4.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPStepper.h"

@implementation WPStepper

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, 85, 25)];
    if (self) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 3;
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = RGBCOLOR_HEX(kLabelWeakColor).CGColor;
        
        _value = 1;
        _step = 1;
        _minValue = 1;
        _maxValue = INT_MAX;
        
        for (int i = 0; i<2; i++) {
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(25+i*35, 0, 0.5, 25)];
            line.backgroundColor = RGBCOLOR_HEX(kLabelWeakColor);
            [self addSubview:line];
        }
        
        _label = [[UILabel alloc]initWithFrame:CGRectMake(25, 0, 35, 25)];
        _label.font = [UIFont systemFontOfSize:14];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = RGBCOLOR_HEX(kLabelWeakColor);
        _label.backgroundColor = [UIColor clearColor];
        _label.text = [NSString stringWithFormat:@"%d",_value];
        [self addSubview:_label];
        
        for (int i = 0; i<2; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(i*60, 0, 25, 25);
            [btn setTitle:i==0?@"-":@"+" forState:UIControlStateNormal];
            [btn setTitleColor:RGBCOLOR_HEX(kLabelWeakColor) forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:18];
            btn.tag = 100+i;
            [btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
        }
    }
    return self;
}

-(void)BtnClick:(UIButton *)sender{
    if (sender.tag == 100) {
        if (_value>_minValue) {
            _value = _value-_step;
            if (_value<_minValue) {
                _value = _value + _step;
            }
        }
    }else{
        if (_value<_maxValue) {
            _value = _value+_step;
            if (_value>_maxValue) {
                _value = _value-_step;
            }
        }
    }
    _label.text = [NSString stringWithFormat:@"%d",_value];
    
    weaklySelf();
    if (self.changeBlock) {
        self.changeBlock(weakSelf);
    }
}


@end




