//
//  NSObject+ARCRetainCount.m
//  common
//
//  Created by Tulipa on 14-8-8.
//  Copyright (c) 2014年  com.7ulipa. All rights reserved.
//

#import "NSObject+ARCRetainCount.h"

@implementation NSObject (ARCRetainCount)

- (NSUInteger)yd_retainCount
{
	return CFGetRetainCount((__bridge CFTypeRef) self);
}

@end
