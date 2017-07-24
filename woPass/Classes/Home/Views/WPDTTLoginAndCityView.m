//
//  WPDTTLoginAndCityView.m
//  woPass
//
//  Created by 王蕾 on 15/12/1.
//  Copyright © 2015年 unisk. All rights reserved.
//

#import "WPDTTLoginAndCityView.h"
#import "WPNameLineView.h"



@implementation WPDTTLoginAndCityView
{
    
}

- (void)loadContent{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    int i = 0;
    NSArray *colorArray = @[RGBCOLOR_HEX(0x09b588),RGBCOLOR_HEX(0xfed650),RGBCOLOR_HEX(0x0ab0dc),RGBCOLOR_HEX(0xfb6513),RGBCOLOR_HEX(0x6567db)];
    for (NSDictionary *dict in _dataSource) {
        float left = i%2 == 0? 0:40;
        WPNameLineView *line = [[WPNameLineView alloc]initWithName:[dict objectForKey:@"name"] andValue:[[dict objectForKey:@"num"] intValue] andFrame:CGRectMake(left, i*40, 320, 80) andColor:colorArray[i]];
        [self addSubview:line];
        i++;
    }
}


@end
