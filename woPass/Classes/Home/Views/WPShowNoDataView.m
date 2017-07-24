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
        [self addSubview:image];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundColor:[UIColor whiteColor]];
        btn.frame = CGRectMake(0, image.bottom+10, 90, 30);
        btn.centerX = image.centerX;
//        btn.layer.masksToBounds = YES;
//        btn.layer.cornerRadius = 3;
//        btn.layer.borderWidth = 1;
//        btn.layer.borderColor = [UIColor colorWithWhite:0.95 alpha:1].CGColor;
        [btn setTitle:@"对不起，查询失败" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self addSubview:btn];
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
