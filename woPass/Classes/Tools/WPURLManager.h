//
//  WPURLManager.h
//  woPass
//
//  Created by htz on 15/7/30.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@interface WPURLManager : NSObject

singleton_h(Manager)
+ (BOOL)openURLWithMainTitle:(NSString *)mainTitle urlString:(NSString *)urlString;
+ (BOOL)openURLWithMainTitle:(NSString *)mainTitle urlString:(NSString *)urlString finishedAction:(void (^)(id info))finishedAction;
+ (BOOL)openURLWithMainTitle:(NSString *)mainTitle urlString:(NSString *)urlString cookiesDic:(NSDictionary *)cookiesDic finishedAction:(void (^)(id info))finishedAction;

- (void)initialSendMessageFunctionWithBlock:(void (^)(id msg, void(^jsResponse)(id response))) sendMsgAction;


+ (BOOL)JavaScriptMessageDidHandleWithResponse:(id)response;
+ (BOOL)sendMessage:(id)message withJavaScriptResponse:(void (^)(id responseData)) responseCallBack;

@end
