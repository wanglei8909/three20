//
//  UIViewController+Navigation.h
//  common
//
//  Created by Tulipa on 14-7-11.
//  Copyright (c) 2014年  com.7ulipa. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, XNavigationBarStyle)
{
    XNavigationBarStyleGreen = 1 << 0,
    XNavigationBarStyleClear = 1 << 1
};

@interface UIViewController (Navigation)

- (BOOL)hideNavigationBar;

- (void)ydDismissViewControllerAnimated:(BOOL)animated;

- (BOOL)autoGenerateBackBarButtonItem;

- (void)dismiss;

- (id)yd_parentViewController;

- (BOOL)enableDragBack;

- (XNavigationBarStyle)navigationBarStyle;

@end
