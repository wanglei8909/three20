//
//  WPReturnTitle.m
//  woPass
//
//  Created by 王蕾 on 15/12/1.
//  Copyright © 2015年 unisk. All rights reserved.
//

#import "WPReturnTitle.h"

@implementation WPReturnTitle

+ (UIView *)ReturnTitleView:(NSString *)title{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(15, 0, 60, 100)];
    view.backgroundColor = [UIColor clearColor];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 35, 78)];
    imageView.image = [UIImage imageNamed:@"PorTab"];
    [view addSubview:imageView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 15, 78)];
    label.numberOfLines = 4;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = title;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:15];
    [view addSubview:label];
    
    return view;
}


@end
