//
//  UINavigationController+IOS8.m
//  common
//
//  Created by Tulipa on 14/9/19.
//  Copyright (c) 2014年  com.7ulipa. All rights reserved.
//

#import "UINavigationController+IOS8.h"

@implementation UINavigationController (IOS8)

- (void)syncDismissViewControllerWithoutAnimation
{
	if (YDAvalibleOS(8))
	{
		__block BOOL wait = YES;
		[self dismissViewControllerAnimated:NO completion:^{
			wait = NO;
		}];
		while (wait)
		{
			[[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
		}
	}
	else
	{
		[self dismissViewControllerAnimated:NO completion:nil];
	}
}

@end
