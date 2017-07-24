//
//  WPLLPackageView.m
//  woPass
//
//  Created by 王蕾 on 15/8/3.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPLLPackageView.h"

@implementation WPLLPackageView
{
    UIView *contentView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //logo64-   64 49
        
        UIImageView *logo = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 32, 25)];
        logo.image = [UIImage imageNamed:@"logo64-"];
        [self addSubview:logo];
        
        _areaLabel = [[UILabel alloc]initWithFrame:CGRectMake(logo.right+5, 0, 200, 20)];
        _areaLabel.center = CGPointMake(_areaLabel.centerX, logo.centerY);
        _areaLabel.textColor = RGBCOLOR_HEX(kLabelDarkColor);
        _areaLabel.font = [UIFont systemFontOfSize:16];
        _areaLabel.text = @"中国联通";
        [self addSubview:_areaLabel];
        
        contentView = [[UIView alloc]initWithFrame:CGRectMake(logo.left, logo.bottom+5, self.width, 0)];
        contentView.backgroundColor =[UIColor clearColor ];
        [self addSubview:contentView];
    }
    return self;
}


-(void)LoadContent{
    [contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    float width = 90;
    float height = 30;
    float gap = (SCREEN_WIDTH - 30 - 3*width)/2;
    float iLeft = 0;
    float iTop = 0;
    
    for (int i = 0; i<self.dataArray.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame =  CGRectMake(iLeft, iTop, width, height);
        [btn setBackgroundImage:[UIImage imageNamed:@"juxing"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"iconfont-toprightcorner01"] forState:UIControlStateSelected];
        [btn setTitle:self.dataArray[i][@"productName"] forState:UIControlStateNormal];
        [btn setTitleColor:RGBCOLOR_HEX(kLabelDarkColor) forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor whiteColor];
        btn.tag = 1000+i;
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:btn];
        
        iLeft += width+gap;
        if (iLeft > SCREEN_WIDTH-50) {
            iLeft = 0;
            iTop += (height+10);
        }
        if (i==self.dataArray.count-1) {
            contentView.height = btn.bottom;
            self.height = contentView.bottom;
        }
        if (i==0) {
            btn.selected = YES;
        }
    }
    
}
-(void)BtnClick:(UIButton *)sender{
    for (UIButton *btn in contentView.subviews) {
        if (btn) {
            btn.selected = btn == sender;
        }
    }
    if (self.selectBlock) {
        self.selectBlock(sender.tag-1000);
    }
}






@end







