//
//  YDAudioManager.m
//  common
//
//  Created by Tulipa on 14-7-9.
//  Copyright (c) 2014年  com.7ulipa. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "XAudioManager.h"
#import "XThread.h"

@interface XDAudioOperation () <AVAudioPlayerDelegate>
@property (nonatomic, strong) void(^startBlock)(void);
@end

@implementation XDAudioOperation
{
	BOOL finished;
	BOOL canceled;
	AVAudioPlayer* player;
}

+ (NSThread *)sharedThread
{
	static NSThread* sharedThread = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedThread = [[XThread alloc] init];
		[sharedThread start];
	});
	return sharedThread;
}

- (AVAudioPlayer *)player
{
	if (self.audioPath)
	{
		AVAudioPlayer* rt = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:self.audioPath] error:nil];
		[rt setDelegate:self];
		
		return rt;
	}
	return nil;
}

- (void)main
{
	
	[self performSelector:@selector(_main) onThread:[[self class] sharedThread] withObject:nil waitUntilDone:YES];
	
}


- (void)start
{
	[super start];
}

- (void)_main
{
	@autoreleasepool
	{
		YDLog(@"start-------------------------------------")
		
		if (self.startBlock)
		{
			_startBlock();
		}
		
		player = [self player];
		if (player)
		{
			[player play];
		}
		else
		{
			finished = YES;
			return;
		}
		
		while (! canceled && ! finished)
		{
			YDLog();
			[[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
		}
		
		if (self.completionBlock)
		{
			self.completionBlock();
			self.completionBlock = nil;
		}
		
		YDLog(@"end--------------------------------------");
	}
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)inPlayer successfully:(BOOL)flag
{
	[self.delegate audioPlayerDidFinishPlaying:inPlayer successfully:flag];
	[self performSelector:@selector(finish) onThread:[[self class] sharedThread] withObject:nil waitUntilDone:NO];
}

- (void)finish
{
	finished = YES;
}

- (BOOL)isFinished
{
	return finished || [super isFinished];
}

- (BOOL)isCancelled
{
	return canceled;
}

- (void)_cancel
{
	[player stop];
	canceled = YES;
	finished = YES;
}

- (void)cancel
{
	[super cancel];
	[self performSelector:@selector(_cancel) onThread:[[self class] sharedThread] withObject:nil waitUntilDone:NO];
}

- (void)dealloc
{
	YDLog();
}

@end

@implementation XAudioManager

+ (NSOperationQueue *)sharedQueue
{
	static NSOperationQueue* sharedQueue = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedQueue = [[NSOperationQueue alloc] init];
		[sharedQueue setMaxConcurrentOperationCount:1];
	});
	return sharedQueue;
}

+ (XDAudioOperation *)enqueueAudio:(NSString *)path
{
	return [[self class] enqueueAudio:path complete:nil];
}

+ (XDAudioOperation *)enqueueAudio:(NSString *)path complete:(void (^)(void))complete
{
	return [[self class] enqueueAudio:path complete:complete delegate:nil];
}

+ (XDAudioOperation *)enqueueAudio:(NSString *)path complete:(void(^)(void))complete delegate:(id<AVAudioPlayerDelegate>)delegate
{
	XDAudioOperation* op = [[XDAudioOperation alloc] init];
	op.completionBlock = complete;
	op.audioPath = path;
	op.delegate = delegate;
	[[[self class] sharedQueue] addOperation:op];
	return op;
}

+ (XDAudioOperation *)enqueueAudio:(NSString *)path start:(void(^)(void))startBlock complete:(void(^)(void))complete delegate:(id<AVAudioPlayerDelegate>)delegate
{
	XDAudioOperation* op = [[XDAudioOperation alloc] init];
	op.startBlock = startBlock;
	op.completionBlock = complete;
	op.audioPath = path;
	op.delegate = delegate;
	[[[self class] sharedQueue] addOperation:op];
	return op;
}

+ (XDAudioOperation *)playAudio:(NSString *)path
{
	return [[self class] playAudio:path complete:nil];
}

+ (XDAudioOperation *)playAudio:(NSString *)path complete:(void (^)(void))complete
{
	return [[self class] playAudio:path complete:complete delegate:nil];
}

+ (XDAudioOperation *)playAudio:(NSString *)path start:(void(^)(void))startBlock complete:(void(^)(void))complete
{
	[[self sharedQueue].operations makeObjectsPerformSelector:@selector(cancel)];
	return [[self class] enqueueAudio:path start:startBlock complete:complete];
}

+ (XDAudioOperation *)enqueueAudio:(NSString *)path start:(void(^)(void))startBlock complete:(void(^)(void))complete;\
{
	XDAudioOperation* op = [[XDAudioOperation alloc] init];
	op.startBlock = startBlock;
	op.completionBlock = complete;
	op.audioPath = path;
	[[[self class] sharedQueue] addOperation:op];
	return op;
}

+ (XDAudioOperation *)playAudio:(NSString *)path complete:(void(^)(void))complete delegate:(id<AVAudioPlayerDelegate>)delegate
{
	[[self sharedQueue].operations makeObjectsPerformSelector:@selector(cancel)];
	return [[self class] enqueueAudio:path complete:complete delegate:delegate];
}

+ (void)cancel
{
	[[self sharedQueue].operations makeObjectsPerformSelector:@selector(cancel)];
}

@end
