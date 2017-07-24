//
//  WPHTTPRequestOperationManager.m
//  woPass
//
//  Created by htz on 15/7/14.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPHTTPRequestOperationManager.h"
#import "UIDeviceHardware.h"
#import "UIDevice+IdentifierAddition.h"
#import "NSObject+TZExtension.h"

NSString* generateCookieForCommonPara();

@interface WPHTTPRequestOperationManager ()

@end

@implementation WPHTTPRequestOperationManager

singleton_m(Manager)

-(instancetype)init {

    if (self = [super init]) {
        
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/plain", nil];
        self.requestSerializer = [WPHTTPRequestSerializer serializer];
        self.securityPolicy.allowInvalidCertificates = YES;
    }
    
    return self;
}

- (void)setLastRequestURLString:(NSString *)lastRequestURLString {
    
    NSArray *components = [lastRequestURLString componentsSeparatedByString:@"/"];

    __block NSMutableString *urlString = [NSMutableString string];
    urlString = [[urlString stringByAppendingString:@"/"] mutableCopy];
    [components enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    
        if (idx < 3) {
            return ;
        }
        
        urlString = [[urlString stringByAppendingPathComponent:obj] mutableCopy];
    }];
    
    _lastRequestURLString = [urlString copy];
}

- (AFHTTPRequestOperation *)POST:(NSString *)URLString parameters:(id)parameters complete:(void (^)(AFHTTPRequestOperation *, id, NSError *))complete {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    return [super POST:URLString parameters:parameters complete:complete];
}

@end


@implementation WPHTTPRequestSerializer
    
- (NSURLRequest *)requestBySerializingRequest:(NSURLRequest *)request withParameters:(id)parameters error:(NSError *__autoreleasing *)error {
    
    if (![request.URL.absoluteString hasSuffix:@"/u/login"] && ![request.URL.absoluteString hasSuffix:@"/c/sendLoginCode"]) {
        
        [WPHTTPRequestOperationManager sharedManager].lastRequestURLString = request.URL.absoluteString;
        [WPHTTPRequestOperationManager sharedManager].lastParam = parameters;
        
    }
    
    if ([parameters isKindOfClass:[NSDictionary class]] || parameters == nil) {
        
        NSMutableDictionary *params = [parameters ?: @{} mutableCopy];
        
        [super setValue:generateCookieForCommonPara() forHTTPHeaderField:@"Cookie"];
        [super setValue:@"application/json" forHTTPHeaderField:@"Accept-Type"];
        
        [super setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, id parameters, NSError *__autoreleasing *error) {
            __autoreleasing NSError* er = nil;
            id result = [NSJSONSerialization dataWithJSONObject:parameters
                                                        options:kNilOptions error:&er];
            NSString *resultStr = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
            resultStr = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                                     
                                                                                     NULL, /* allocator */
                                                                                     
                                                                                     (__bridge CFStringRef)resultStr,
                                                                                     
                                                                                     NULL, /* charactersToLeaveUnescaped */
                                                                                     
                                                                                     (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                     
                                                                                     kCFStringEncodingUTF8);
            if (er != nil) return nil;
            return resultStr;
        }];
        
        return [super requestBySerializingRequest:request withParameters:params error:error];
    }
    
    return [super requestBySerializingRequest:request withParameters:parameters error:error];
}

- (void)setAuthorizationHeaderFieldWithUsername:(NSString *)username password:(NSString *)password {
    
    [self setValue:[NSString stringWithFormat:@"{%@}", username] forHTTPHeaderField:@"Authorization"];
}


@end

AFHTTPCompleteBlock processComplete(WPHTTPCompleteBlock complete) {

    return ^ (AFHTTPRequestOperation *operation, id responseObject, NSError * error){
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (error) {
            
            complete(operation, @{@"code" : @(99998)}, @"网络异常，请重试");
        } else {
            
            NSString *msg = [responseObject objectForKey:@"message"];
            
            if ([msg isEqualToString:@"需要登录"]) {
                
                if (ISLOGINED) {
                    
                    [[RequestManeger getCurrentViewController] showHint:@"登录已超时" hide:1];
                } else {
                    
                    [[RequestManeger getCurrentViewController] showHint:@"请先登录" hide:1];
                }
                
                [gUser QutiLogin:nil];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [UserAuthorManager authorizationLogin:nil andSuccess:^{
                        
                        [[WPHTTPRequestOperationManager sharedManager] POST:[WPHTTPRequestOperationManager sharedManager].lastRequestURLString parameters:[WPHTTPRequestOperationManager sharedManager].lastParam complete:processComplete(^(AFHTTPRequestOperation *operation, id responseObject, NSString *msg) {
                            
                            complete(operation, responseObject, msg);
                        })];
                    } andFaile:^{
                        
                        complete(nil, @{@"code" : @(99999)}, @"未登录");
                    }];
                });
                
            } else if ([msg isEqualToString:@"成功"]) {
                
                complete(operation, responseObject, nil);
            } else {
                
                complete(operation, responseObject, msg);
            }
        }
    };
}

id generateCookieForCommonPara() {
    NSLog(@"---->%@",gUser.locationCityDict);
    
    NSString *appVersion = [NSString stringWithFormat:@"WOPassport.IOS_%@", APPVERSION];
    NSString *model = [UIDeviceHardware platformString];
    NSString *os = [UIDevice currentDevice].systemVersion;
    NSString *imei = [[UIDevice currentDevice] uniqueDeviceIdentifier];
    
    NSString *screen = [NSString stringWithFormat:@"%f*%f",SCREEN_WIDTH,SCREEN_HEIGHT];
    NSString *userid = gUser.userId;
    NSString *connectType = gUser.connnectType;
    NSString *unikey = gUser.unikey;
    NSString *lng = gUser.lng ;
    NSString *lat = gUser.lat;
    NSString *city = [gUser.locationCityDict objectForKey:@"id"];
    
    NSString *cookieValue1 = [[NSString stringWithFormat:@"appVersion=%@&model=%@&os=%@&imei=%@&screen=%@&userId=%@&connectType=%@&unikey=%@&lng=%@&lat=%@&city=%@", appVersion, model, os, imei, screen, userid, connectType, unikey, lng, lat, city] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *baseProperties = @{
                                     NSHTTPCookieName : @"wo_plus_base",
                                     NSHTTPCookieValue : cookieValue1,
                                     NSHTTPCookiePath : @"/",
                                     NSHTTPCookieDomain : @"wo.cn"
                                     };
    NSDictionary *tokenProperties = @{
                                     NSHTTPCookieName : @"wo_plus_token",
                                     NSHTTPCookieValue : [gUser.woToken stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                                     NSHTTPCookiePath : @"/",
                                     NSHTTPCookieDomain : @"wo.cn"
                                     };
    NSHTTPCookie *cookie1 = [[NSHTTPCookie alloc] initWithProperties:baseProperties];
    NSHTTPCookie *cookie2 = [[NSHTTPCookie alloc] initWithProperties:tokenProperties];

    NSArray *cookies = @[cookie1, cookie2];
    
    NSDictionary *headers = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
    return [headers objectForKey:@"Cookie"];
}


