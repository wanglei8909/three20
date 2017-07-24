//
//  WPNetworkManager.h
//  woPass
//
//  Created by htz on 15/8/19.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WPHTTPRequestOperationManager.h"
#import "Singleton.h"

@interface WPNetworkManager : NSObject

@property (nonatomic, copy)NSString *baseUrl;

singleton_h(Manager)

+ (instancetype)manager;
- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(id)parameters
                        complete:(void (^)(AFHTTPRequestOperation *operation, id responseObject, NSError *error))complete;

- (AFHTTPRequestOperation *)GET:(NSString *)URLString
                     parameters:(id)parameters
                       complete:(void (^)(AFHTTPRequestOperation *operation, id responseObject, NSError *error))complete;


@end
