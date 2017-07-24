//
//  WPSelePayTypeView.m
//  woPass
//
//  Created by 王蕾 on 15/8/3.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPSelePayTypeView.h"

@implementation WPSelePayTypeView

{
    UIView *mBackView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        
        mBackView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 120)];
        mBackView.backgroundColor = [UIColor whiteColor];
        [self addSubview:mBackView];
        
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        title.text = @"选择付款方式";
        title.font = [UIFont systemFontOfSize:16];
        title.textColor = RGBCOLOR_HEX(kLabelDarkColor);
        title.textAlignment = NSTextAlignmentCenter;
        [mBackView addSubview:title];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 40, SCREEN_WIDTH, 40);
        btn.backgroundColor =[UIColor clearColor];
        btn.tag = 1;
        [btn addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
        [mBackView addSubview:btn];
        
        for (int i = 0; i<2; i++) {
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, i*40, SCREEN_WIDTH, 1)];
            line.backgroundColor = RGBCOLOR_HEX(kMargineColor);
            [btn addSubview:line];
        }
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
        label.text = @"支付宝支付";
        label.left = SCREEN_WIDTH*0.5-40;
        label.textColor = RGBCOLOR_HEX(kLabelDarkColor);
        label.font = [UIFont systemFontOfSize:16];
        [btn addSubview:label];
        
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 20, 20)];
        image.image = [UIImage imageNamed:@"zhifubaologo_"];
        image.right = label.left-10;
        [btn addSubview:image];
        
        
        UIButton *cancle = [UIButton buttonWithType:UIButtonTypeCustom];
        cancle.frame = CGRectMake(0, 80, SCREEN_WIDTH, 40);
        [cancle setTitleColor:RGBCOLOR_HEX(kLabelDarkColor) forState:UIControlStateNormal];
        [cancle setTitle:@"取消" forState:UIControlStateNormal];
        [cancle addTarget:self action:@selector(HiddenView) forControlEvents:UIControlEventTouchUpInside];
        [mBackView addSubview:cancle];
        
    }
    return self;
}
- (void)Click:(UIButton *)sender{
    [self HiddenView];
    if (self.mBlock) {
        self.mBlock(sender.tag);
    }
}
-(void)didMoveToSuperview{
    //[super didMoveToSuperview];
    [UIView animateWithDuration:0.3 animations:^{
        mBackView.frame = CGRectMake(0, SCREEN_HEIGHT-120, SCREEN_WIDTH, 120);
    }];
}

- (void)HiddenView{
    [UIView animateWithDuration:0.1 animations:^{
        mBackView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, 155);
    } completion:^(BOOL finish) {
        [self removeFromSuperview];
    }];
}

@end
