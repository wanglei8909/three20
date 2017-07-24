//
//  WPLoginHistoryUtil.h
//  woPass
//
//  Created by htz on 15/10/27.
//  Copyright © 2015年 unisk. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^FetchLoginDicListComplete)(id response, NSString *msg);

@interface WPLoginHistoryUtil : NSObject

singleton_h(Util)

- (BOOL)isCurrentLatestAbnormalDateNewerThanCache;
- (void)refreshStatusWithAbnormalDate:(NSString *)abnormalDateString;
- (void)refreshStatus;
- (void)fetchLoginHistoryDicListComplete:(FetchLoginDicListComplete)complte;
- (void)clearCache;

@end
