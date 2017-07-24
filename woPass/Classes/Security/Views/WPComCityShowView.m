//
//  WPComCityShowView.m
//  woPass
//
//  Created by 王蕾 on 15/9/7.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPComCityShowView.h"
#import "WPCityManager.h"

@implementation WPComCityShowView

#define btnWidth ((SCREEN_WIDTH-4*15)/3)
#define btnHeight 35

-(instancetype)init{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
    if (self) {
        
        _cityArray = [[NSMutableArray alloc]initWithCapacity:10];
        
        NSArray *array = [[[WPCityManager alloc] init] cityNameArrayWithCityCodeArrayString:gUser.commonLoginPlace];
        for (int i = 0; i<array.count; i++) {
            NSString *string = array[i];
            if (string.length>0) {
                NSDictionary *dict = [[NSDictionary alloc]initWithObjects:@[string] forKeys:@[@"name"]];
                [_cityArray addObject:dict];
            }
        }
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        line.backgroundColor = RGBCOLOR_HEX(kMargineColor);
        [self addSubview:line];
        
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 200, 35)];
        title.backgroundColor = [UIColor clearColor];
        title.font = [UIFont systemFontOfSize:15];
        title.textColor = RGBCOLOR_HEX(kLabelWeakColor);
        title.text = @"常用城市";
        [self addSubview:title];
        
        float iLeft = 0;
        float iTop = 35;
        for (int i = 0; i<3; i++) {
            if (iLeft + 20 > SCREEN_WIDTH) {
                iTop += 35+10;
                iLeft = 0;
            }
            UILabel *label = [[UILabel alloc]init];
            label.frame = CGRectMake(15+iLeft, iTop, btnWidth, btnHeight);
            label.textColor = RGBCOLOR_HEX(kLabelDarkColor);
            label.backgroundColor =[UIColor whiteColor];
            label.layer.masksToBounds = YES;
            label.layer.cornerRadius = 3;
            label.layer.borderWidth = 0.7;
            label.textAlignment = NSTextAlignmentCenter;
            label.layer.borderColor = RGBCOLOR_HEX(kMargineColor).CGColor;
            label.tag = 100+i;
            [self addSubview:label];
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(15+iLeft-10+btnWidth, iTop-10, 20, 20);
            btn.backgroundColor = [UIColor clearColor];
            btn.tag = i+1000;
            [btn setBackgroundImage:[UIImage imageNamed:@"iconfont-close--3"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(deleteCity:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            iLeft += 15+btnWidth;
        }
        [self reloadLabel];
    }
    return self;
}

- (void)deleteCity:(UIButton *)sender{
    NSInteger index = sender.tag - 1000;
    if (_cityArray.count>index) {
        [_cityArray removeObjectAtIndex:index];
        [self reloadLabel];
    }
}
- (void)AddCity:(NSDictionary *)dict{
    for (int i = 0; i<_cityArray.count; i++) {
        NSDictionary *cDict = _cityArray[i];
        if ([cDict[@"name"] isEqualToString:dict[@"name"]]) {
            UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"已设置此城市，无需重复添加" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [av show];
            return;
        }
    }
    if (_cityArray.count<3) {
        [_cityArray addObject:dict];
        [self reloadLabel];
    }else{
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"最多只能设置3个常用地点" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
    }
}
- (void)reloadLabel{
    for (int i = 0; i<3; i++) {
        UILabel *label = (UILabel *)[self viewWithTag:100+i];
        label.text = @"";
    }
    for (int i = 0; i<_cityArray.count; i++) {
        UILabel *label = (UILabel *)[self viewWithTag:100+i];
        label.text = _cityArray[i][@"name"];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
