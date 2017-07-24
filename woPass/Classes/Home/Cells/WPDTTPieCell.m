//
//  WPDTTPieCell.m
//  woPass
//
//  Created by 王蕾 on 15/12/1.
//  Copyright © 2015年 unisk. All rights reserved.
//

#import "WPDTTPieCell.h"
#import "WPReturnTitle.h"
#import "SCPieChart.h"

@implementation WPDTTPieCell
{
    SCPieChart *chartView;
}


- (void)configUI:(NSArray *)dataArray{
    NSArray *colors = @[RGBCOLOR_HEX(0x09b588),RGBCOLOR_HEX(0xfed650),RGBCOLOR_HEX(0x0ab0dc),RGBCOLOR_HEX(0xfb6513),RGBCOLOR_HEX(0x6567db)];
    if (chartView) {
        [chartView removeFromSuperview];
        chartView = nil;
        
    }
    
    NSMutableArray *items = [[NSMutableArray alloc]init];
    
    for (int i = 0; i<(dataArray.count>5?5:dataArray.count); i++) {
        NSDictionary *dict = dataArray[i];
        [items addObject:[SCPieChartDataItem dataItemWithValue:[[dict objectForKey:@"num"]intValue] color:colors[i] description:[dict objectForKey:@"name"]]];
    }
    
    chartView = [[SCPieChart alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, (self.frame.size.height-200)/2, 200.0, 200.0) items:items];
    chartView.descriptionTextColor = [UIColor whiteColor];
    chartView.descriptionTextFont  = [UIFont fontWithName:@"Avenir-Medium" size:12.0];
    [chartView strokeChart];
    [self addSubview:chartView];
    
    self.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:[WPReturnTitle ReturnTitleView:@"平台设备"]];
    
    UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.contentView.bottom-1, SCREEN_WIDTH, 1)];
    line.image = [UIImage imageNamed:@"PorLine"];
    [self.contentView addSubview:line];
}


@end
