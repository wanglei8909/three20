//
//  WPTimerManager.m
//  woPass
//
//  Created by htz on 15/12/1.
//  Copyright © 2015年 unisk. All rights reserved.
//

#import "WPTimerManager.h"

@interface WPTimerManager ()

@property (nonatomic, strong)NSMutableDictionary *timerDic;

@end

@implementation WPTimerManager

singleton_m(Manager)

#pragma mark - Constructors and Life cycle







#pragma mark - Private Method

- (void)timeup:(NSString *)timerID {
    
    NSTimer *timer = [self.timerDic objectForKey:timerID];
    [timer invalidate];
    CallBlock(self.timeupAction, timerID);
}



#pragma mark - Event Reponse







#pragma mark - Delegate









#pragma mark - Getter and Setter

- (NSMutableDictionary *)timerDic {
    if (!_timerDic) {
        _timerDic = [[NSMutableDictionary alloc] init];
    }
    return _timerDic;
}




#pragma mark - Public

- (void)registerTimerForID:(NSString *)timerID timeInterval:(NSTimeInterval)timeInterval {
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(timeup:) userInfo:timerID repeats:NO];
    [self.timerDic setObject:timer forKey:timerID];
}

- (void)removeTimerForID:(NSString *)timerID {
    
    NSTimer *timer = [self.timerDic objectForKey:timerID];
    [timer invalidate];
    [self.timerDic removeObjectForKey:timerID];
}

- (instancetype)applyTimeupAction:(WPTimerTimeupAction)timeupAction {
    self.timeupAction = timeupAction;
    return self;
}

- (BOOL)isTimeOutForID:(NSString *)timerID {
    
    if (!self.timerDic[timerID]) {
        
        return YES;
    }
    NSTimer *timer = [self.timerDic objectForKey:timerID];
    return !timer.valid;
}

@end
