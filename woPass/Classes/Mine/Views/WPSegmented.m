//
//  WPSegmented.m
//  woPass
//
//  Created by 王蕾 on 15/7/21.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPSegmented.h"

@implementation WPSegmented
{
    SelectedSegmented OnClick;
    UIView *lineView;
    UIView *back;
}
- (instancetype) initWithItems:(NSArray *)items  andBlock:(SelectedSegmented)selected{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 58)];
    if (self) {
        OnClick = [selected copy];
        
        back = [[UIView alloc]initWithFrame:CGRectMake(10, 10, self.width-20, self.height-20)];
        back.backgroundColor =[UIColor whiteColor];
        back.layer.masksToBounds = YES;
        back.layer.cornerRadius = 3;
        back.layer.borderWidth = 0.5;
        back.layer.borderColor = RGBCOLOR_HEX(kMargineColor).CGColor;
        [self addSubview:back];
        
        float iWidth = back.width/items.count;
        
        for (int i = 0; i<items.count-1; i++) {
            UIView *mlineView = [[UIView alloc]initWithFrame:CGRectMake(iWidth + i*iWidth, 5, 0.5, back.height-10)];
            mlineView.backgroundColor = RGBCOLOR_HEX(kMargineColor);
            [back addSubview:mlineView];
        }
        
        for (int i = 0; i<items.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(iWidth*i, 0, iWidth, back.height) ;
            btn.backgroundColor = [UIColor clearColor];
            [btn setTitleColor:RGBCOLOR_HEX(kLabelDarkColor) forState:UIControlStateNormal];
            [btn setTitleColor:RGBCOLOR_HEX(KTextOrangeColor) forState:UIControlStateSelected];
            btn.tag = 100+i;
            [btn addTarget:self action:@selector(SelectClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:items[i] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:kFontMiddle];
            [back addSubview:btn];
            if (i==0) {
                btn.selected = YES;
                lineView = [[UIView alloc]initWithFrame:CGRectMake(btn.left+10, btn.bottom-2, iWidth-20, 2)];
                lineView.backgroundColor = RGBCOLOR_HEX(KTextOrangeColor);
                [back addSubview:lineView];
            }
        }
    }
    return self;
}
- (void)SelectClick:(UIButton *)sender{
    if (sender.selected) {
        return;
    }
    NSInteger index = sender.tag -100;
    
    for (UIButton *view in back.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            view.selected = view.tag == sender.tag;
        }
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        lineView.left = sender.left+10;
    }];
    
    if (OnClick) {
        OnClick (index);
    }
}


@end
