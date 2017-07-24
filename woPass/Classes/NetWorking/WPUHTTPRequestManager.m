//
//  WPUHTTPRequestManager.m
//  WoPassOauth
//
//  Created by htz on 15/8/24.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPUHTTPRequestManager.h"

#define kTimeoutInterval 30


@implementation WPUHTTPRequestManager

+ (instancetype)manager {
    
    return [[self alloc] init];
}

- (instancetype)init {
    
    if (self = [super init]) {
        
    }
    return self;
}

- (void)GET:(NSString *)relativeUrl parameters:(id)params complete:(WPUHTTPRequestComplete)complete {
    
    NSString *baseUrl = [[NSUserDefaults standardUserDefaults] objectForKey:SSOBASEURLKEY];
    baseUrl = baseUrl ? baseUrl : SSOBASEURLONLINE;
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", baseUrl, relativeUrl];
    NSURLRequest *urlRequest = [WPUHTTPRequestSerialization requestSerializationForGetWithUrlStirng:urlString params:params];
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSDictionary *dic;
        
        if (connectionError) {
            
            dic = nil;
            complete(response, dic, connectionError.localizedDescription);
        } else {
            
            dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:NULL];
            if (dic) {
                
                if ([[dic objectForKey:@"code"] integerValue]) {
                    
                    complete(response, dic, [dic objectForKey:@"msg"]);
                } else {
                    
                    complete(response, dic, nil);
                }
            } else {
                
                complete(response, nil, [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
            }
        }
    }];
}

@end


@implementation WPUHTTPRequestSerialization

+ (NSURLRequest *)requestSerializationForGetWithUrlStirng:(NSString *)urlString params:(NSDictionary *)params {
    
    NSMutableString *urlParamString = [urlString mutableCopy];
    [urlParamString appendString:@"?"];
    
    [params enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *value, BOOL *stop) {
        
        [urlParamString appendString:[NSString stringWithFormat:@"%@=%@&", key, value]];
    }];
    
    [urlParamString deleteCharactersInRange:NSMakeRange(urlParamString.length - 1, 1)];
    
    NSURL *url = [NSURL URLWithString:[urlParamString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:kTimeoutInterval];
    return urlRequest;
}

@end
