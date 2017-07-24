//
//  WPSSOManager.m
//  woPass
//
//  Created by htz on 15/10/10.
//  Copyright © 2015年 unisk. All rights reserved.
//

#import "WPSSOManager.h"
#import "WPUHTTPRequestManager.h"
#import "DRURLParametersParser.h"
#import "WPUDES.h"
#import "Singleton.h"
#import "NSObject+TZExtension.h"

@interface WPSSOManager ()

@property (nonatomic, strong) UIWebView           *webView;
@property (nonatomic, strong) NSMutableDictionary *params;// 请求参数
@property (nonatomic, copy  ) NSString            *scheme;

@end

@implementation WPSSOManager

#pragma mark - private

singleton_m(Manager)

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        
    }
    return _webView;
}

- (NSMutableDictionary *)params {
    if (!_params) {
        _params = [[NSMutableDictionary alloc] init];
        
    }
    return _params;
}

- (void)openUrlString:(NSString *)urlString {
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlRequest];
}

#pragma mark - API

- (void)dismissSsoPage {
    
    UIViewController *current_vc = [self getCurrentViewController];
    
    UIViewController *parent_vc = [current_vc yd_parentViewController];
    UIViewController *navigation_vc = parent_vc.navigationController;

    if ([parent_vc isKindOfClass:NSClassFromString(@"WPWrapperLoginViewController")]
        || [current_vc isKindOfClass:NSClassFromString(@"WPSSOViewController")]) {
        
        if (!navigation_vc) {
            
            [current_vc ydDismissViewControllerAnimated:NO];
        } else if (![[navigation_vc.childViewControllers firstObject] isKindOfClass:NSClassFromString(@"WPRootViewController")]) {
            
            [navigation_vc dismissViewControllerAnimated:NO completion:nil];
        }
    }
}

- (void)openSsoPageWithUrl:(NSURL *)url {
    
    NSString *urlString = url.absoluteString;
    NSRange range = [urlString rangeOfString:SSO_MARK];
    if (range.location != NSNotFound) {
        
        [@"WP://WPSSOViewController" openWithQuery:@{
                                                     @"url" : url
                                                     }
                                          animated:NO];
        DRURLParametersParser *urlPaser = [[DRURLParametersParser alloc] initWithURL:url];
        self.params = [[urlPaser dictionaryForURL] mutableCopy];
    }
}

- (void)fetchThirdPartyAppInfoWithComplete:(FetchThirdPartyAppInfoAction)action {
    
    weaklySelf();
    [[WPUHTTPRequestManager manager] GET:@"/oauth2/client_info" parameters:self.params complete:^(id operation, id response, NSString *msg) {
       
        if (!msg) {
            
            if ([[response objectForKey:@"code"] integerValue] == 0) {
                
                weakSelf.scheme = [response objectForKey:@"nativeUrl"];
                CallBlock(action, @{
                                    @"appIcon"      : [response objectForKey:@"appIcon"],
                                    @"appName"      : [response objectForKey:@"appName"],
                                    @"nativeUrl"    : [response objectForKey:@"nativeUrl"],
                                    @"scopes"       : [response objectForKey:@"scopes"],
                                    }, nil);
            } else {
                
                CallBlock(action, nil, [response objectForKey:@"msg"]);
            }
        } else {
            
            CallBlock(action, nil, msg);
        }
    }];
}

- (void)obtainAuthForUser:(NSString *)userId scopes:(NSString *)scopes WithComplete:(AuthCompleteAction)action {

    NSString *encryptId = [[WPUDES encryptDESString:userId key:@"cuwoplus" useEBCmode:NO] stringByReplacingOccurrencesOfString:@"+" withString:@"#"];
    [self.params setObject:encryptId forKey:@"mark"];
    [self.params setObject:scopes forKey:@"scopes"];
    
    [[WPUHTTPRequestManager manager] GET:@"/oauth2/authorize_wopass" parameters:self.params complete:^(id operation, id response, NSString *msg) {
       
        if (!msg) {
            
            if ([[response objectForKey:@"code"] integerValue] == 0) {
                
                CallBlock(action, [response objectForKey:@"location"], nil);
            } else {
                
                CallBlock(action, nil, msg);
            }
        } else {
            
            CallBlock(action, nil, msg);
        }
    }];
}

- (void)backToThirdPartyAppWithStatus:(WPSSOStatus)status location:(NSString *)location {
    
    NSString *urlString = nil;
    if (status == WPSSOStatusSucess) {
        
        urlString = [NSString stringWithFormat:@"%@://www.unisk.cn/auth?location=%@", self.scheme, location];
        [self openUrlString:urlString];
    } else if (status == WPSSOStatusFailure) {
        
        urlString = [NSString stringWithFormat:@"%@://www.unisk.cn/auth?location=%@", self.scheme, @"error"];
        [self openUrlString:urlString];
    }
}


#pragma mark - Getter and Setter

- (void)setScheme:(NSString *)scheme {
    
    NSRange range = [scheme rangeOfString:@"://"];
    NSString *result = scheme;
    if (range.location != NSNotFound) {
        
        result = [scheme substringWithRange:NSMakeRange(0, range.location)];
    }
    
    _scheme = result;
}




@end
