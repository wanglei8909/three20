//
//  UUBarChart.m
//  UUChartDemo
//
//  Created by 2014-763 on 15/3/12.
//  Copyright (c) 2015年 meilishuo. All rights reserved.
//

#import "SCBarChart.h"
#import "SCChartLabel.h"
#import "SCBar.h"
#import "SCTool.h"

@interface SCBarChart ()
{
    UIScrollView *myScrollView;
}
@end

@implementation SCBarChart

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.clipsToBounds = NO;
        myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(UUYLabelwidth, 0, frame.size.width-UUYLabelwidth, frame.size.height)];
        
    }
    return self;
}

-(void)setYValues:(NSArray *)yValues
{
    _yValues = yValues;
    [self setYLabels:yValues];
}

-(void)setYLabels:(NSArray *)yLabels
{
    CGFloat max = 0;
    CGFloat min = 1000000000;
    NSInteger rowCount = 0; // 自动计算每个图表适合的行数
    for (NSArray * ary in yLabels) {
        for (NSString *valueString in ary) {
            CGFloat value = [valueString floatValue];
            if (value > max) {
                max = value;
            }
            if (value < min) {
                min = value;
            }
        }
    }
    if (self.showRange) {
        _yValueMin = min;
    }else{
        _yValueMin = 0;
    }
    _yValueMax = 20;
    
    if (_chooseRange.max!=_chooseRange.min) { // 自定义数值范围
        _yValueMax = _chooseRange.max;
        _yValueMin = _chooseRange.min;
    } else { // 自动计算数值范围和合适的行数
        rowCount = [SCTool rowCountWithValueMax:_yValueMax] == 0 ? 5 : [SCTool rowCountWithValueMax:_yValueMax];
        _yValueMax = [SCTool rangeMaxWithValueMax:_yValueMax] == 0 ? 100 : [SCTool rangeMaxWithValueMax:_yValueMax];
        _yValueMin = 0;
    }

    float level = (_yValueMax-_yValueMin) /rowCount; // 每个区间的差值
    CGFloat chartCavanHeight = self.frame.size.height - UULabelHeight*3;
    CGFloat levelHeight = chartCavanHeight /rowCount; // 每个区间的高度
    
    for (int i=0; i<rowCount+1; i++) {
        SCChartLabel * label = [[SCChartLabel alloc] initWithFrame:CGRectMake(0.0,chartCavanHeight-i*levelHeight+5, UUYLabelwidth, UULabelHeight)];
		label.text = [NSString stringWithFormat:@"%g",level * i+_yValueMin];
        if (i==0) {
            label.text = [NSString stringWithFormat:@"(次数)%g",level * i+_yValueMin];
            label.left = label.left-25;
            label.width = 50;
            
            UILabel *hLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width, chartCavanHeight-i*levelHeight+5, 30, UULabelHeight)];
            [hLabel setLineBreakMode:NSLineBreakByWordWrapping];
            [hLabel setMinimumScaleFactor:5.0f];
            [hLabel setNumberOfLines:1];
            [hLabel setFont:[UIFont boldSystemFontOfSize:12.0f]];
            [hLabel setTextColor: RGBCOLOR_HEX(0xffffff)];
            hLabel.backgroundColor = [UIColor clearColor];
            hLabel.text = @"(h)";
            [self addSubview:hLabel];
        }
		[self addSubview:label];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(30, label.bottom-5, self.frame.size.width-35, 1)];
        line.backgroundColor = RGBCOLOR_HEX(kMargineColor);
        line.alpha = 0.5;
        [self addSubview:line];
    }
	
}

-(void)setXLabels:(NSArray *)xLabels
{
    _xLabels = xLabels;
    NSInteger num;
    if (xLabels.count>=8) {
        num = 8;
    }else if (xLabels.count<=4){
        num = 4;
    }else{
        num = xLabels.count;
    }
    _xLabelWidth = myScrollView.frame.size.width/num;
    
    for (int i=0; i<xLabels.count; i++) {
        SCChartLabel * label = [[SCChartLabel alloc] initWithFrame:CGRectMake((i *  _xLabelWidth ), self.frame.size.height - UULabelHeight, _xLabelWidth, UULabelHeight)];
        label.text = xLabels[i];
        [myScrollView addSubview:label];
    }
    
    float max = (([xLabels count]-1)*_xLabelWidth + chartMargin)+_xLabelWidth;
    if (myScrollView.frame.size.width < max-10) {
        myScrollView.contentSize = CGSizeMake(max, self.frame.size.height);
    }
}
-(void)setColors:(NSArray *)colors
{
	_colors = colors;
}
- (void)setChooseRange:(CGRange)chooseRange
{
    _chooseRange = chooseRange;
}
-(void)strokeChart
{
    
    //_colors = @[RGBCOLOR_HEX(0x09b588),RGBCOLOR_HEX(0xfed650),RGBCOLOR_HEX(0x0ab0dc),RGBCOLOR_HEX(0xfb6513)];
    CGFloat chartCavanHeight = self.frame.size.height - UULabelHeight*3;
	
    for (int i=0; i<_yValues.count; i++) {
        if (i==2)
            return;
        NSArray *childAry = _yValues[i];
        for (int j=0; j<childAry.count; j++) {
            NSString *valueString = childAry[j];
            float value = [valueString floatValue];
            float grade = ((float)value-_yValueMin) / ((float)_yValueMax-_yValueMin);
            
            SCBar * bar = [[SCBar alloc] initWithFrame:CGRectMake((j+(_yValues.count==1?0.14:0.05))*_xLabelWidth+5 +i*_xLabelWidth * 0.47, UULabelHeight, _xLabelWidth * (_yValues.count==1?0.6:0.45), chartCavanHeight)];
            bar.barColor = [_colors objectAtIndex:j];
            bar.grade = grade;
            bar.alpha = 0.8;
            [myScrollView addSubview:bar];
            
        }
    }
    [self addSubview:myScrollView];
}

@end
