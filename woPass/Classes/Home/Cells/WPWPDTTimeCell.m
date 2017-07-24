//
//  WPWPDTTimeCell.m
//  woPass
//
//  Created by 王蕾 on 15/12/1.
//  Copyright © 2015年 unisk. All rights reserved.
//

#import "WPWPDTTimeCell.h"
#import "WPReturnTitle.h"

#import "SCChart.h"

@implementation WPWPDTTimeCell
{
    SCChart *chartView;
    NSArray *timeSource;
}

- (void)configUI:(NSArray *)timeArray{
    timeSource = [[NSArray alloc]init];
    timeSource = timeArray;
    self.backgroundColor = [UIColor clearColor];
    
    if (chartView) {
        [chartView removeFromSuperview];
        chartView = nil;
    }
    chartView = [[SCChart alloc] initwithSCChartDataFrame:CGRectMake(55, 50, SCREEN_WIDTH-100, 180)
                                               withSource:self
                                                withStyle:SCChartBarStyle];
    [chartView showInView:self.contentView];
    
    [self.contentView addSubview:[WPReturnTitle ReturnTitleView:@"常用时间"]];
    
    UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.contentView.bottom-1, SCREEN_WIDTH, 1)];
    line.image = [UIImage imageNamed:@"PorLine"];
    [self.contentView addSubview:line];
}

#pragma mark - @required
//横坐标标题数组
- (NSArray *)SCChart_xLableArray:(SCChart *)chart {
    return @[@"0-6",@"6-12",@"12-18",@"18-24"];
}

//数值多重数组
- (NSArray *)SCChart_yValueArray:(SCChart *)chart {
    return @[timeSource];
}

#pragma mark - @optional
//颜色数组
- (NSArray *)SCChart_ColorArray:(SCChart *)chart {
    return @[RGBCOLOR_HEX(0x09b588),RGBCOLOR_HEX(0xfed650),RGBCOLOR_HEX(0x0ab0dc),RGBCOLOR_HEX(0xfb6513)];
}

@end
