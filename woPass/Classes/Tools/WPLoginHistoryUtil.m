//
//  WPLoginHistoryUtil.m
//  woPass
//
//  Created by htz on 15/10/27.
//  Copyright © 2015年 unisk. All rights reserved.
//

#import "WPLoginHistoryUtil.h"
#import "Singleton.h"

static NSString * kAbnormalDateKey = @"AbnormalDateKey";

@interface WPLoginHistoryUtil ()

@property (nonatomic, strong)id response;
@property (nonatomic, strong)NSDate *cachedLatestAbnormalDate;
@property (nonatomic, strong)NSDate *currentLatestAbnormalDate;

@end

@implementation WPLoginHistoryUtil

singleton_m(Util)

#pragma mark - Constructors and Life cycle



#pragma mark - Private Method

- (void)storeCurrentAbnormalDate {
    
    [[NSUserDefaults standardUserDefaults] setObject:self.currentLatestAbnormalDate forKey:kAbnormalDateKey];
}

- (NSDate *)currentLatestAbnormalDateWithLogArray:(NSArray *)logArray {
    
    __block NSDate *result = nil;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
    
    __block BOOL finish = NO;
    [logArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        NSArray *infoArray = [obj objectForKey:@"history"];
        [infoArray enumerateObjectsUsingBlock:^(NSDictionary *infoDic, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([[infoDic objectForKey:@"remoteLogin"] integerValue]) {
                
                NSString *dateString = [infoDic objectForKeyedSubscript:@"detailLoginTime"];
                result = [dateFormatter dateFromString:dateString];
                *stop = YES;
                finish = YES;
            }
        }];
        
        if (finish) {
            
            *stop = YES;
        }
    }];
    
    return result;
}


#pragma mark - Event Reponse

#pragma mark - Delegate

#pragma mark - Getter and Setter

- (NSDate *)cachedLatestAbnormalDate {
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:kAbnormalDateKey];
}

#pragma mark - Public

- (void)refreshStatusWithAbnormalDate:(NSString *)abnormalDateString {

    if (abnormalDateString) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        self.currentLatestAbnormalDate =  [dateFormatter dateFromString:abnormalDateString];
    }
    [self storeCurrentAbnormalDate];
}

- (void)refreshStatus {

    [self refreshStatusWithAbnormalDate:nil];
}

- (BOOL)isCurrentLatestAbnormalDateNewerThanCache {
    
    if (!self.currentLatestAbnormalDate)
        return NO;
    
    if (!self.cachedLatestAbnormalDate)
        return YES;
    
    if ([self.currentLatestAbnormalDate compare:self.cachedLatestAbnormalDate] == NSOrderedDescending)
        return YES;
    
    return NO;
}

- (void)fetchLoginHistoryDicListComplete:(FetchLoginDicListComplete)complete {
    if (self.response) {
        
        CallBlock(complete, self.response, nil);
    } else {
        weaklySelf();
        [RequestManeger POST:@"/u/loginHistory" parameters:nil complete:processComplete(^(AFHTTPRequestOperation *operation, id responseObject, NSString *msg) {
            
            if(!msg) {
                
                NSArray *logs = [[responseObject objectForKey:@"data"] objectForKey:@"logs"];
                if (logs) {
                    
                    weakSelf.response = responseObject;
                    weakSelf.currentLatestAbnormalDate = [weakSelf currentLatestAbnormalDateWithLogArray:logs];
                }
            }
            CallBlock(complete, responseObject, msg);
        })];
    }
}

- (void)clearCache {
    
    self.response = nil;
}

@end
