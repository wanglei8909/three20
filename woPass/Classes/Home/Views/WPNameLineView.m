//
//  WPNameLineView.m
//  woPass
//
//  Created by 王蕾 on 15/12/1.
//  Copyright © 2015年 unisk. All rights reserved.
//

#import "WPNameLineView.h"

@implementation WPNameLineView
{
    NSString *sName;
    float sValue;
    UIColor *sColor;
}

#define StandardWidth (SCREEN_WIDTH-215)/20

- (instancetype)initWithName:(NSString *)name andValue:(float) cValue andFrame:(CGRect)frame andColor:(UIColor *)color{
    sName = name;
    sValue = cValue;
    sColor = color;
    return [self initWithFrame:frame];
}

- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *bg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
        bg.backgroundColor = sColor;
        bg.alpha = 0.8;
        bg.layer.masksToBounds = YES;
        bg.layer.cornerRadius = 15;
        [self addSubview:bg];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.text = sName;
        [bg addSubview:label];
        if (sName.length == 4) {
            label.numberOfLines = 0;
            label.width = 40;
        }
        if (sName.length > 4) {
            label.numberOfLines = 0;
            label.font = [UIFont systemFontOfSize:12];
        }
        label.center = bg.center;
        
        UIView *circle = [[UIView alloc]initWithFrame:CGRectMake(60+10, 0, 10, 10)];
        circle.layer.masksToBounds = YES;
        circle.centerY = label.centerY;
        circle.layer.cornerRadius = 5;
        circle.backgroundColor = sColor;
        [self addSubview:circle];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(60+10+8, 0, sValue*StandardWidth, 5)];
        line.backgroundColor = sColor;
        line.centerY = label.centerY;
        line.layer.masksToBounds = YES;
        line.layer.cornerRadius = 2.5;
        [self addSubview:line];
        
        UILabel *numLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, 60)];
        numLabel.left = 60+10+8+sValue*StandardWidth+5;
        numLabel.textColor = sColor;
        numLabel.text = [NSString stringWithFormat:@"%d次",(int)sValue];
        numLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:numLabel];
        
    }
    return self;
}

@end
