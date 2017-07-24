//
//  WPNetworkManager.m
//  woPass
//
//  Created by htz on 15/8/19.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPNetworkManager.h"

@interface WPNetworkManager ()

@property (nonatomic, strong)WPHTTPRequestOperationManager *HTTPManager;

@end



@implementation WPNetworkManager

singleton_m(Manager)


+ (instancetype)manager {
    
    return [self sharedManager];
}

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.HTTPManager = [WPHTTPRequestOperationManager sharedManager];
        self.baseUrl = [[NSUserDefaults standardUserDefaults] objectForKey:BASEURLKEY] ? [[NSUserDefaults standardUserDefaults] objectForKey:BASEURLKEY] : BASEURLONLINE;
    }
    
    return self;
}

- (AFHTTPRequestOperation *)POST:(NSString *)URLString parameters:(id)parameters complete:(void (^)(AFHTTPRequestOperation *, id, NSError *))complete {
    
    self.HTTPManager.requestSerializer = [WPHTTPRequestSerializer serializer];
    return [self.HTTPManager POST:[self urlStringWithRelativePath:URLString] parameters:parameters complete:complete];
}

- (NSString *)urlStringWithRelativePath:(NSString *)path {
    
    NSString *newPath = [NSString stringWithFormat:@"/txzApp%@", path];
    NSString *baseUrl = self.baseUrl;
    if ([newPath hasPrefix:@"/txzApp/u"]) {
        
        baseUrl  = [baseUrl stringByReplacingOccurrencesOfString:@"http" withString:@"https"];
    }
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", baseUrl, newPath];
    
    return urlString;
}

- (AFHTTPRequestOperation *)GET:(NSString *)URLString parameters:(id)parameters complete:(void (^)(AFHTTPRequestOperation *, id, NSError *))complete {
    
    self.HTTPManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    return [self.HTTPManager GET:[self urlStringWithRelativePath:URLString] parameters:parameters complete:complete];
}

@end
