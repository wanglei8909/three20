//
//  WPTimerManager.h
//  woPass
//
//  Created by htz on 15/12/1.
//  Copyright © 2015年 unisk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

typedef void(^WPTimerTimeupAction)(NSString *timerID);

@interface WPTimerManager : NSObject

singleton_h(Manager)

@property (nonatomic, copy)WPTimerTimeupAction timeupAction;

- (void)registerTimerForID:(NSString *)timerID timeInterval:(NSTimeInterval) timeInterval;
- (void)removeTimerForID:(NSString *)timerID;
- (BOOL)isTimeOutForID:(NSString *)timerID;

- (instancetype)applyTimeupAction:(WPTimerTimeupAction)timeupAction;

@end
