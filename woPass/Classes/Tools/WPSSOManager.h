//
//  WPSSOManager.h
//  woPass
//
//  Created by htz on 15/10/10.
//  Copyright © 2015年 unisk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

typedef void(^FetchThirdPartyAppInfoAction)(id info, NSString *msg);
typedef void(^AuthCompleteAction)(id info, NSString *msg);
typedef NS_ENUM(NSUInteger, WPSSOStatus) {
    WPSSOStatusSucess,
    WPSSOStatusFailure
};

@interface WPSSOManager : NSObject

singleton_h(Manager)

- (void)dismissSsoPage;
- (void)openSsoPageWithUrl:(NSURL *)url;
- (void)fetchThirdPartyAppInfoWithComplete:(FetchThirdPartyAppInfoAction)action;
- (void)obtainAuthForUser:(NSString *)userId
                   scopes:(NSString *)scopes
             WithComplete:(AuthCompleteAction)action;
- (void)backToThirdPartyAppWithStatus:(WPSSOStatus)status location:(NSString *)location;

@end
