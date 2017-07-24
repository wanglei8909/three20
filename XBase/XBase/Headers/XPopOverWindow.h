//
//  YDPopOverWindow.h
//  common
//
//  Created by Tulipa on 14-7-23.
//  Copyright (c) 2014年  com.7ulipa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XPopOverWindow : UIWindow
{
	UIView *_view;
}

@property (nonatomic, readonly) UIView *view;

@property (nonatomic, weak) UIViewController *relativeViewController;

- (instancetype)initWithView:(UIView *)view;

@end
