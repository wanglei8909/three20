//
//  WPDTTCityCell.m
//  woPass
//
//  Created by 王蕾 on 15/12/1.
//  Copyright © 2015年 unisk. All rights reserved.
//

#import "WPDTTCityCell.h"
#import "WPReturnTitle.h"
#import "WPDTTLoginAndCityView.h"

@implementation WPDTTCityCell
{
    WPDTTLoginAndCityView *cityView;
}

- (void)configUI:(NSMutableArray *)cityArray{
    if (!cityView) {
        self.backgroundColor = [UIColor clearColor];
        
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
        title.textColor = RGBCOLOR_HEX(0xffffff);
        title.text = @"最近20次登录";
        title.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:title];
        
        cityView = [[WPDTTLoginAndCityView alloc]initWithFrame:CGRectMake(60, 100, SCREEN_WIDTH-120, self.frame.size.height)];
        cityView.dataSource = cityArray;
        [cityView loadContent];
        [self.contentView addSubview:cityView];
        
        [self.contentView addSubview:[WPReturnTitle ReturnTitleView:@"城市分布"]];
        
        UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.contentView.bottom-1, SCREEN_WIDTH, 1)];
        line.image = [UIImage imageNamed:@"PorLine"];
        [self.contentView addSubview:line];
    }
}

@end
