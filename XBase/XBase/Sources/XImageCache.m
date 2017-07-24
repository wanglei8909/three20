//
//  YDImageCache.m
//  pandaMentor
//
//  Created by 臧金晓 on 14/11/26.
//  Copyright (c) 2014年  reserved.
//

#import "XImageCache.h"

@implementation XImageCache

+ (dispatch_queue_t)sharedIOQueue
{
	static dispatch_queue_t sharedIOQueue = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedIOQueue = dispatch_queue_create("com.youdao.bigbang.imageCacheIO", NULL);
	});
	return sharedIOQueue;
}

- (instancetype)init
{
	if (self = [super init])
	{
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeAllObjects) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
	}
	return self;
}

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (UIImage *)cachedImageForRequest:(NSURLRequest *)request
{
	UIImage *image = [self objectForKey:request.URL.absoluteString];
	if (! image)
	{
		image = [UIImage imageWithContentsOfFile:[[self class] pathForRequest:request]];
		if (image)
		{
			[self setObject:image forKey:request.URL.absoluteString];
		}
	}
	return image;
}

- (void)cacheImage:(UIImage *)image forRequest:(NSURLRequest *)request
{
	[self setObject:image forKey:request.URL.absoluteString];
	dispatch_async([[self class] sharedIOQueue], ^{
		NSString *path = [[self class] pathForRequest:request];
		if (! [[NSFileManager defaultManager] fileExistsAtPath:path])
		{
			NSString *dictPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"image_caches"];
			if (! [[NSFileManager defaultManager] fileExistsAtPath:dictPath])
			{
				[[NSFileManager defaultManager] createDirectoryAtPath:dictPath withIntermediateDirectories:NO attributes:nil error:nil];
			}
			
			[UIImagePNGRepresentation(image) writeToFile:path atomically:YES];
			
			YDLog(@"Cache Image to:%@", path);
		}
	});
}

+ (NSString *)pathForRequest:(NSURLRequest *)request
{
	return [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"image_caches/%@", [[request.URL.absoluteString stringByReplacingOccurrencesOfString:@"/" withString:@"_"] stringByReplacingOccurrencesOfString:@":" withString:@"_"]]];
}

@end
