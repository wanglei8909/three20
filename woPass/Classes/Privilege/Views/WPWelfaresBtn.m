//
//  WPWelfaresBtn.m
//  woPass
//
//  Created by 王蕾 on 15/8/17.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPWelfaresBtn.h"
#import "UIImageView+WebCache.h"

@implementation WPWelfaresBtn


-(void) LoadContentUI:(WPPriWelfaresModel *)model{
    self.tImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 25, 40, 40)];
    [self.tImage sd_setImageWithURL:[NSURL URLWithString:model.img]];
    [self addSubview:self.tImage];
    
    self.tLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.tImage.right+10, self.tImage.top, SCREEN_WIDTH*0.5-self.tImage.right-10, 20)];
    //self.tLabel.textColor = RGBCOLOR_HEX(0xb44aea);
    self.tLabel.textColor = RGBCOLOR_HEX(kLabelDarkColor);
    self.tLabel.font = [UIFont systemFontOfSize:14];
    self.tLabel.text = model.mainTitle;
    [self addSubview:self.tLabel];
    
    self.bLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.tImage.right+10, self.tLabel.bottom , self.tLabel.width, 20)];
    self.bLabel.textColor = RGBCOLOR_HEX(0x999999);
    self.bLabel.text = model.subTitle;
    self.bLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.bLabel];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
