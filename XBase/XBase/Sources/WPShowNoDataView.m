//
//  WPShowNoDataView.m
//  woPass
//
//  Created by 王蕾 on 15/9/21.
//  Copyright © 2015年 unisk. All rights reserved.
//

#import "WPShowNoDataView.h"

@implementation WPShowNoDataView


-(instancetype)init{
    self = [super initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH, SCREEN_HEIGHT-65)];
    if (self) {
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 105, 75)];
        image.center = CGPointMake(SCREEN_WIDTH*0.5, (SCREEN_HEIGHT-65)*0.5-50);
        image.image = [UIImage imageNamed:@"touxiagn-1"];
        image.centerX = SCREEN_WIDTH*0.5;
        image.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:image];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, image.bottom+5, 220, 30)];
        label.backgroundColor = [UIColor clearColor];
        label.centerX = image.centerX;
        label.text = @"对不起，查询失败";
        label.textColor = [UIColor darkGrayColor];
        label.font = [UIFont systemFontOfSize:16];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];

    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
