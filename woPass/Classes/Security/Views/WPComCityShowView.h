//
//  WPComCityShowView.h
//  woPass
//
//  Created by 王蕾 on 15/9/7.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WPComCityShowView : UIView

@property (nonatomic, strong)NSMutableArray *cityArray;


- (void)AddCity:(NSDictionary *)dict;

@end
