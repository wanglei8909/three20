//
//  YDAudioManager.h
//  common
//
//  Created by Tulipa on 14-7-9.
//  Copyright (c) 2014年  com.7ulipa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface XDAudioOperation : NSOperation

//@property (nonatomic, strong) void(^complete)(void);
@property (nonatomic, assign) id<AVAudioPlayerDelegate>delegate;

@property (nonatomic, strong) NSString* audioPath;

@end

@interface XAudioManager : NSObject

+ (XDAudioOperation *)enqueueAudio:(NSString *)path;

+ (XDAudioOperation *)enqueueAudio:(NSString *)path complete:(void(^)(void))complete;

+ (XDAudioOperation *)enqueueAudio:(NSString *)path complete:(void(^)(void))complete delegate:(id<AVAudioPlayerDelegate>)delegate;

+ (XDAudioOperation *)playAudio:(NSString *)path complete:(void(^)(void))complete;

+ (XDAudioOperation *)playAudio:(NSString *)path start:(void(^)(void))startBlock complete:(void(^)(void))complete;

+ (XDAudioOperation *)enqueueAudio:(NSString *)path start:(void(^)(void))startBlock complete:(void(^)(void))complete;

+ (XDAudioOperation *)playAudio:(NSString *)path complete:(void(^)(void))complete delegate:(id<AVAudioPlayerDelegate>)delegate;

+ (XDAudioOperation *)enqueueAudio:(NSString *)path start:(void(^)(void))startBlock complete:(void(^)(void))complete delegate:(id<AVAudioPlayerDelegate>)delegate;

+ (XDAudioOperation *)playAudio:(NSString *)path;

+ (void)cancel;

@end
