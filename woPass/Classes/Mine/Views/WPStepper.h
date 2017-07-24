//
//  WPStepper.h
//  woPass
//
//  Created by 王蕾 on 15/8/4.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WPStepper;
typedef void(^ValueChange)(WPStepper *steper);

@interface WPStepper : UIView

@property (nonatomic, assign)int maxValue;
@property (nonatomic, assign)int minValue;
@property (nonatomic, assign)int value;
@property (nonatomic, assign)int step;
@property (nonatomic, copy) ValueChange changeBlock;

@property (nonatomic, strong)UILabel *label;


@end
