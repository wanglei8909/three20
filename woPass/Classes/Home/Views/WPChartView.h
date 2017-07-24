//
//  WPChartView.h
//  woPass
//
//  Created by 王蕾 on 15/12/2.
//  Copyright © 2015年 unisk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WPChartView.h"

@class WPChartView;
@protocol WPChartDataSource <NSObject>

@required
//横坐标标题数组
- (NSArray *)SCChart_xLableArray:(WPChartView *)chart;

//数值多重数组
- (NSArray *)SCChart_yValueArray:(WPChartView *)chart;

@optional
//颜色数组
- (NSArray *)SCChart_ColorArray:(WPChartView *)chart;

@end


@interface WPChartView : UIView

-(id)initwithSCChartDataFrame:(CGRect)rect withSource:(id<WPChartDataSource>)dataSource;
- (void)showInView:(UIView *)view;
-(void)strokeChart;


@end
