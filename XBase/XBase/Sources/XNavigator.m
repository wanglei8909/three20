//
//  CNavigator.m
//  HotelManager
//
//  Created by Tulipa on 14-4-29.
//  Copyright (c) 2014年  com.7ulipa All rights reserved.
//

#import "XNavigator.h"
#import "XNavigationController.h"

@implementation XNavigator


- (Class)navigationControllerClass
{
    return [XNavigationController class];
}


+ (XNavigator*)navigator
{
    if (! [[self class] globalNavigator])
    {
        XNavigator* navigator = [[[self class] alloc] init];
        [[self class] setGlobalNavigator:navigator];
    }
    
    return (XNavigator*)[[self class] globalNavigator];
}

- (void)popToRootViewController
{
	UIViewController* vc = self.topViewController;
	while (self.rootViewController != vc)
	{
		if (vc.presentingViewController)
		{
			[vc dismissViewControllerAnimated:NO completion:nil];
		}
		else
		{
			[vc.navigationController popToRootViewControllerAnimated:NO];
		}
		vc = self.topViewController;
	}
}

- (id)popToViewControllerWithClass:(Class)klass animated:(BOOL)animated
{
	UINavigationController *vc = (id)self.topViewController;
	
	UIViewController *result = nil;
	
	while (YES)
	{
		__block UIViewController *tmpVC = nil;
		[vc.viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
			if ([obj isKindOfClass:klass])
			{
				tmpVC = obj, *stop = YES;
			}
		}];
		
		if (tmpVC)
		{
			result = tmpVC;
			[vc popToViewController:tmpVC animated:animated];
			break;
		}
		else if (vc.presentingViewController)
		{
			UINavigationController *nav = vc;
			vc = (id)nav.presentingViewController;
			
			[vc.viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
				if ([obj isKindOfClass:klass])
				{
					tmpVC = obj, *stop = YES;
				}
			}];
			
			if ([vc.viewControllers lastObject] == tmpVC)
			{
				result = tmpVC;
				[nav dismissViewControllerAnimated:animated completion:nil];
				break;
			}
			else
			{
				[nav dismissViewControllerAnimated:NO completion:nil];
			}
			
			
		}
		else
		{
			[vc popToRootViewControllerAnimated:animated];
			break;
		}
	}
	
	return result;
}

@end
