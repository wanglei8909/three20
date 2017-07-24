//
//  WPUHTTPRequestManager.h
//  WoPassOauth
//
//  Created by htz on 15/8/24.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^WPUHTTPRequestComplete)(id operation, id response, NSString *msg);

@interface WPUHTTPRequestManager : NSObject

+ (instancetype)manager;

- (void)GET:(NSString *)relativeUrl parameters:(id)params complete:(WPUHTTPRequestComplete)complete;

@end

@interface WPUHTTPRequestSerialization : NSObject

+ (NSURLRequest *)requestSerializationForGetWithUrlStirng:(NSString *)urlString params:(id)params;

@end
