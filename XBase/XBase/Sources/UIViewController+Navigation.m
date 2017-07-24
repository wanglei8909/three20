//
//  UIViewController+Navigation.m
//  common
//
//  Created by Tulipa on 14-7-11.
//  Copyright (c) 2014年  com.7ulipa. All rights reserved.
//

#import "UIViewController+Navigation.h"

@implementation UIViewController (Navigation)

- (BOOL)hideNavigationBar
{
	return NO;
}

- (void)ydDismissViewControllerAnimated:(BOOL)animated;
{
	UIViewController* vc = [self.navigationController popViewControllerAnimated:animated];
	if (! vc)
	{
		[self dismissViewControllerAnimated:animated completion:nil];
	}
}

- (void) dismiss;
{
	[self ydDismissViewControllerAnimated:YES];
}

- (BOOL)autoGenerateBackBarButtonItem
{
	return NO;
}

- (UIViewController *)yd_parentViewController
{
	NSInteger vcCount = self.navigationController.viewControllers.count;
	if (vcCount > 1)
	{
		return [self.navigationController.viewControllers objectAtIndex:vcCount - 1];
	}
	else if (self.presentingViewController)
	{
		return self.presentingViewController;
	}
	return nil;
}

- (BOOL)enableDragBack
{
	return YES;
}

- (XNavigationBarStyle)navigationBarStyle
{
    return XNavigationBarStyleGreen;
}

@end
