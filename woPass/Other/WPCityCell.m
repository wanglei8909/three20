//
//  WPCityCell.m
//  woPass
//
//  Created by 王蕾 on 15/7/27.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPCityCell.h"

#define btnWidth ((SCREEN_WIDTH-4*15)/3)
#define btnHeight 35

@implementation WPCityCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor =[UIColor clearColor];
    }
    return self;
}
-(void)layoutSubviews{
    [self LoadContent:self.cityArray];
}
-(float)LoadContent:(NSArray *)array{
    float iLeft = 0;
    float iTop = 0;
    for (int i = 0; i<self.cityArray.count; i++) {
        if (iLeft + 20 > SCREEN_WIDTH) {
            iTop += 35+10;
            iLeft = 0;
        }
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(15+iLeft, iTop, btnWidth, btnHeight);
        [btn setTitle:array[i][@"name"] forState:UIControlStateNormal];
        [btn setTitleColor:RGBCOLOR_HEX(kLabelDarkColor) forState:UIControlStateNormal];
        btn.backgroundColor =[UIColor whiteColor];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 3;
        btn.layer.borderWidth = 0.7;
        btn.layer.borderColor = RGBCOLOR_HEX(kMargineColor).CGColor;
        btn.tag = 100+i;
        [btn addTarget:self action:@selector(OnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        iLeft += 15+btnWidth;
    }
    float height = iTop+35;
    
    return height;
}
-(void)OnClick:(UIButton *)sender{
    if (self.click) {
        self.click(self.cityArray[sender.tag-100]);
    }
}


@end
