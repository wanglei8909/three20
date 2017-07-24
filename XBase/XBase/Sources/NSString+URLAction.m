//
//  NSString+URLAction.m
//  common
//
//  Created by Tulipa on 14-7-10.
//  Copyright (c) 2014年  com.7ulipa. All rights reserved.
//

#import "NSString+URLAction.h"
#import <Three20UINavigator/TTURLAction.h>

@implementation NSString (URLAction)

- (id)openWithQuery:(NSDictionary *)inDic animated:(BOOL)inAnimated
{
	TTURLAction* action = [[TTURLAction alloc] initWithURLPath:self];
	[action setAnimated:inAnimated];
	[action setQuery:inDic];
	return [[XNavigator navigator] openURLAction:action];
}

- (id)openWithQuery:(NSDictionary *)inDic
{
	return [self openWithQuery:inDic animated:YES];
}

- (id)open
{
	return [self openWithQuery:nil];
}

@end
