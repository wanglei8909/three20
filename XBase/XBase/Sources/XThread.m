//
//  YDThread.m
//  common
//
//  Created by Tulipa on 14-7-9.
//  Copyright (c) 2014年  com.7ulipa. All rights reserved.
//

#import "XThread.h"

@implementation XThread

- (void)main
{
	@autoreleasepool
	{
		NSRunLoop* loop = [NSRunLoop currentRunLoop];
		[loop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
		[loop run];
	}
}

@end
