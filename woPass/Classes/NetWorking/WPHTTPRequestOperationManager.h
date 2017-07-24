//
//  WPHTTPRequestOperationManager.h
//  woPass
//
//  Created by htz on 15/7/14.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "AFNetworking.h"
#import "AFHTTPRequestOperationManager+SingleBlock.h"
#import "Singleton.h"

typedef void(^AFHTTPCompleteBlock)(AFHTTPRequestOperation *operation, id responseObject, NSError * error);
typedef void(^WPHTTPCompleteBlock)(AFHTTPRequestOperation *operation, id responseObject, NSString * msg);
AFHTTPCompleteBlock processComplete(WPHTTPCompleteBlock complete);

@interface WPHTTPRequestOperationManager : AFHTTPRequestOperationManager

singleton_h(Manager)

@property (nonatomic, strong)id lastParam;
@property (nonatomic, copy)NSString *lastRequestURLString;

@end

@interface WPHTTPRequestSerializer : AFHTTPRequestSerializer

@end

