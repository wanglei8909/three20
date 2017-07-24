//
//  WPAlertView.m
//  woPass
//
//  Created by 王蕾 on 15/8/20.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPAlertView.h"

@implementation WPAlertView


- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message buttonTitles:(NSArray *)buttonTitles andCancleClick:(void(^)())cancleClick  andOKClick:(void(^)())OKClick{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (self) {
        self.okBlock = OKClick;
        self.cancelBlock = cancleClick;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
        
        UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 180)];
        back.center = self.center;
        back.backgroundColor = [UIColor whiteColor];
        back.layer.masksToBounds = YES;
        back.layer.cornerRadius = 10;
        [self addSubview:back];
        
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 270, 30)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.text = title;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18];
        [back addSubview:titleLabel];
        
        UILabel *msg = [[UILabel alloc]initWithFrame:CGRectMake(30, 40, 240, back.height-40-50)];
        msg.backgroundColor = [UIColor clearColor];
        msg.text = message;
        msg.textAlignment = NSTextAlignmentCenter;
        msg.font = [UIFont systemFontOfSize:16];
        msg.numberOfLines = 0;
        [back addSubview:msg];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, back.height-45, 300, 1)];
        line.backgroundColor = RGBCOLOR_HEX(kMargineColor);
        [back addSubview:line];
        
        for (int i = 0; i<buttonTitles.count; i++) {
            float iwidth = 300/buttonTitles.count;
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(i*iwidth, back.height-45, iwidth, 45);
            [btn setTitleColor:RGBCOLOR_HEX(KTextOrangeColor) forState:UIControlStateNormal];
            [btn setTitle:buttonTitles[i] forState:UIControlStateNormal];
            btn.tag = 100+i;
            [btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
            if (i < buttonTitles.count-1) {
                UIView *btnLine = [[UIView alloc]initWithFrame:CGRectMake(iwidth, 0, 1, 45)];
                btnLine.backgroundColor = RGBCOLOR_HEX(kMargineColor);
                [btn addSubview:btnLine];
            }
            
            [back addSubview:btn];
        }
    }
    return self;
}
- (void)BtnClick:(UIButton *)sender{
    self.hidden = YES;
    if (sender.tag == 100) {
            self.cancelBlock();
    }else{
            self.okBlock();
    }
    @autoreleasepool {
        [self removeFromSuperview];
    }
}

- (void)show{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
