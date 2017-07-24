//
//  WPStarView.h
//  woPass
//
//  Created by 王蕾 on 15/8/28.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WPStarView : UIView

@property (nonatomic, assign) CGFloat scorePercent;//得分值，范围为0--1，默认为1
@property (nonatomic, strong) UIView *foregroundStarView;
@property (nonatomic, strong) UIView *backgroundStarView;
@property (nonatomic, strong) UILabel *scoreLabel;

@end
