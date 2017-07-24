//
//  WPActCell.m
//  woPass
//
//  Created by 王蕾 on 15/7/29.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPActCell.h"
#import "UIImageView+WebCache.h"

@implementation WPActCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        float height = 112 * SCREEN_WIDTH/320 + 30;
        
        UIView *bg = [[UIView alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 112 * SCREEN_WIDTH/320 + 30)];
        bg.backgroundColor =[UIColor whiteColor];
        [self.contentView addSubview:bg];
        
        _image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, bg.width, height-30)];
        [bg addSubview:_image];
        
        UIView *timebg = [[UIView alloc]initWithFrame:CGRectMake(0, _image.bottom-20, bg.width, 20)];
        timebg.backgroundColor = [UIColor blackColor];
        timebg.alpha = 0.2;
        [bg addSubview:timebg];
        
        _time = [[UILabel alloc]initWithFrame:CGRectMake(10, timebg.top, timebg.width-20, 20)];
        _time.backgroundColor =[UIColor clearColor];
        _time.textColor = [UIColor whiteColor];
        _time.font = [UIFont systemFontOfSize:14];
        [bg addSubview:_time];
        
        _title = [[UILabel alloc]initWithFrame:CGRectMake(10, _image.bottom, SCREEN_WIDTH-20, 30)];
        _title.backgroundColor =[UIColor clearColor];
        _title.textColor = RGBCOLOR_HEX(kLabelDarkColor);
        _title.font = [UIFont systemFontOfSize:16];
        [bg addSubview:_title];
    }
    return self;
}
-(void)layoutSubviews{
    [_image sd_setImageWithURL:[NSURL URLWithString:self.model.img] placeholderImage:[UIImage imageNamed:@"defaultPlaceholder"]];
    _time.text = self.model.timeText;
    _title.text = self.model.mainTitle;
    
}

@end
