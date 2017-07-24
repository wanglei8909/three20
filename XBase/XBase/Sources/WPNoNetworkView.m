//
//  WPNoNetworkView.m
//  woPass
//
//  Created by 王蕾 on 15/9/9.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPNoNetworkView.h"

@implementation WPNoNetworkView

- (instancetype)initWithAdapte:(CGFloat)adapt {
    
    self = [super initWithFrame:CGRectMake(0, adapt, SCREEN_WIDTH, SCREEN_HEIGHT-65)];
    if (self) {
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 105, 75)];
        image.center = CGPointMake(SCREEN_WIDTH*0.5, (SCREEN_HEIGHT-65)*0.5-50);
        image.image = [UIImage imageNamed:@"iconfont-meiwifi"];
        image.centerX = SCREEN_WIDTH*0.5;
        [self addSubview:image];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundColor:[UIColor whiteColor]];
        btn.frame = CGRectMake(0, image.bottom+10, 90, 30);
        btn.centerX = image.centerX;
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 3;
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = [UIColor colorWithWhite:0.95 alpha:1].CGColor;
        [btn setTitle:@"重新加载" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(BtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    return self;
}

-(instancetype)init{
    
    return [self initWithAdapte:65];
}
- (void)BtnClick{
    self.hidden = YES;
    if (self.block) {
        self.block();
    }
}
- (void)dealloc
{
    self.block = nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
