//
//  WPLoginTypeSelectView.m
//  woPass
//
//  Created by 王蕾 on 15/7/17.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPLoginTypeSelectView.h"

@implementation WPLoginTypeSelectView
{
    UIView *lineView;
    UIButton *leftBtn;
    UIButton *rightBtn;
}

-(instancetype)init{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 39.4, SCREEN_WIDTH, 0.6)];
        line.backgroundColor = RGBCOLOR_HEX(kMargineColor);
        [self addSubview:line];
        
        line = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.5, 3, 0.6, 32)];
        line.backgroundColor = RGBCOLOR_HEX(kMargineColor);
        [self addSubview:line];
        float btnWidth = SCREEN_WIDTH/2;
        for (int i = 0; i<2; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(i*btnWidth, 0, btnWidth, 40);
            btn.backgroundColor = [UIColor clearColor];
            [btn setTitleColor:RGBCOLOR_HEX(kLabelDarkColor) forState:UIControlStateNormal];
            [btn setTitleColor:RGBCOLOR_HEX(KTextOrangeColor) forState:UIControlStateSelected];
            [btn setTitle:i==0?@"随机密码":@"帐号密码" forState:UIControlStateNormal];
            btn.tag = 100+i;
            [btn addTarget:self action:@selector(SelectClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.titleLabel.font = [UIFont systemFontOfSize:kFontMiddle];
            [self addSubview:btn];
            if (i==0) {
                leftBtn = btn;
                btn.selected = YES;
                lineView = [[UIView alloc]initWithFrame:CGRectMake(btn.left, btn.bottom-3, btnWidth, 3)];
                lineView.backgroundColor = RGBCOLOR_HEX(KTextOrangeColor);
                [self addSubview:lineView];
            }else{
                rightBtn = btn;
            }
        }
    }
    return self;
}
-(void)SelectClick:(UIButton *)sender{
    NSInteger index = sender.tag-100;
    BOOL left = index == 0;
    [UIView animateWithDuration:0.5 animations:^{
        lineView.left = sender.left;
        leftBtn.selected = left;
        rightBtn.selected = !left;
    }];
    
    if (self.selectBlock) {
        self.selectBlock(index);
    }
}

@end
