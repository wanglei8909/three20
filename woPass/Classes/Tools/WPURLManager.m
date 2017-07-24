//
//  WPURLManager.m
//  woPass
//
//  Created by htz on 15/7/30.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPURLManager.h"
#import "NSObject+TZExtension.h"
#import "TZWebViewController.h"
#import "DRURLParametersParser.h"
#import "UIDeviceHardware.h"
#import "UIDevice+IdentifierAddition.h"

#define NativeScheme @"woPass"
#define JSScheme     @"js"

@interface WPURLManager ()

@property (nonatomic, copy  ) NSString     *mainTitle;
@property (nonatomic, copy  ) NSString     *urlString;
@property (nonatomic, strong) NSDictionary *cookiesDic;
@property (nonatomic, copy  ) void (^finishedAction)(id info);
@property (nonatomic, copy  ) void (^sendMessageAction)(id message, void (^jsResponse)(id response));

@end

@implementation WPURLManager

singleton_m(Manager)

#pragma mark - getter\setter

- (void)setUrlString:(NSString *)urlString {
    
    if (![urlString hasPrefix:@"http"] && ![urlString hasPrefix:NativeScheme] && ![urlString hasPrefix:@"/"]) {
        
        urlString  = [NSString stringWithFormat:@"http://%@", urlString];
    }
    
    _urlString = urlString;
}

- (void)setMainTitle:(NSString *)mainTitle {
    
    _mainTitle = ([mainTitle isEqualToString:@""] ? nil : mainTitle);
}

+ (BOOL)openURLWithMainTitle:(NSString *)mainTitle urlString:(NSString *)urlString {
    
    [self openURLWithMainTitle:mainTitle urlString:urlString finishedAction:nil];
    return YES;
}

+ (BOOL)openURLWithMainTitle:(NSString *)mainTitle urlString:(NSString *)urlString finishedAction:(void (^)(id))finishedAction {
    
    [self openURLWithMainTitle:mainTitle urlString:urlString cookiesDic:nil finishedAction:finishedAction];
    return YES;
}

+ (BOOL)openURLWithMainTitle:(NSString *)mainTitle urlString:(NSString *)urlString cookiesDic:(NSDictionary *)cookiesDic finishedAction:(void (^)(id))finishedAction {
    
    WPURLManager *manager = [WPURLManager sharedManager];
    manager.mainTitle = mainTitle;
    manager.urlString = urlString;
    manager.cookiesDic = cookiesDic;
    manager.finishedAction = finishedAction;
    
    [manager openURL];
    return YES;
}

#pragma mark - logic

- (void)initialSendMessageFunctionWithBlock:(void (^)(id, void (^)(id)))sendMsgAction {
    
    self.sendMessageAction = sendMsgAction;
}

- (BOOL)openURL {
    
    // 打开webView
    
    if ([self.urlString hasPrefix:@"http"] || [self.urlString hasPrefix:@"/"]) {
        
        NSRange range = [self.urlString rangeOfString:@"wocity"];
        if (range.location != NSNotFound) {
            
            self.urlString = [self.urlString stringByReplacingOccurrencesOfString:@"wocity" withString:[gUser.locationCityDict objectForKey:@"name"]];
            self.urlString = [self.urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
        
        range = [self.urlString rangeOfString:@"wolat"];
        if (range.location != NSNotFound) {
            
            self.urlString = [self.urlString stringByReplacingOccurrencesOfString:@"wolat" withString:gUser.lat];
            self.urlString = [self.urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

        }
        
        range = [self.urlString rangeOfString:@"wolng"];
        if (range.location != NSNotFound) {
            
            self.urlString = [self.urlString stringByReplacingOccurrencesOfString:@"wolng" withString:gUser.lng];
            self.urlString = [self.urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
        
        range = [self.urlString rangeOfString:@"diandianCredit"];
        if (range.location == NSNotFound) {
            [@"WP://web_vc" openWithQuery:@{
                                            @"urlString" : self.urlString,
                                            @"mainTitle" : self.mainTitle ? self.mainTitle : @"WO+",
                                            }];
        }else{
            if ([UserAuthorManager gainCurrentStateForUserLoginAndBind] == 0) {
                [UserAuthorManager authorizationLogin:self andSuccess:^{
                    [@"WP://web_vc" openWithQuery:@{
                                                    @"urlString" : self.urlString,
                                                    @"mainTitle" : self.mainTitle ? self.mainTitle : @"WO+",
                                                    @"cookiesDic": [self generateCookieForCommonPara]
                                                    }];
                }andFaile:^{
                    NSLog(@"登录失败");
                }];
            }else{
                [@"WP://web_vc" openWithQuery:@{
                                                @"urlString" : self.urlString,
                                                @"mainTitle" : self.mainTitle ? self.mainTitle : @"WO+",
                                                @"cookiesDic": [self generateCookieForCommonPara]
                                                }];
            }
        }
        
        // 调用native资源
    } else if ([self.urlString hasPrefix:NativeScheme]) {
        //woPass://?function=someFun&id=sdfsdf&name=haha
        NSDictionary *info   = [self getInfo];
        NSString *function   = [info objectForKey:@"function"];
        NSDictionary *params = [info objectForKey:@"params"];
        
            // 二维码
        if ([function isEqualToString:@"QRCode"]) {
            
            // 测试
        } else if ([function isEqualToString:@"Test"]) {
            
            [self invokeClassFromString:@"WPTest" params:&params];
            
            // 领取优惠劵
        } else if ([function isEqualToString:@"welfaresReceive"]) {
            if ([params[@"type"] isEqualToString:@"thirdUrl"]) {
                
            }else{
                [self invokeClassFromString:@"WPGetTicketManager" params:&params];
            }
            // 参加活动
        } else if ([function isEqualToString:@"activityBuy"]) {
            if ([params[@"type"] isEqualToString:@"thirdUrl"]) {
                
            }else{
                [self invokeClassFromString:@"WPGetTicketManager" params:&params];
                //[self invokeClassFromString:@"WPActivityBuyManager" params:&params];
            }
        } else if ([function isEqualToString:@"userCoupon"]) {
            
        } else if ([function isEqualToString:@"fangsaorao"]) {
            [self invokeClassFromString:@"WPFangSaoRaoManager" params:&params];

        }
            // 打开native页面
        //woPass?function=openNative&pageName=WP://WPFangSaoRaoViewController
        else if ([function isEqualToString:@"openNative"]) {
            
           NSString *urlName = [params objectForKey:@"pageName"];
            if ([urlName isEqualToString:@"WP://WPSUserPhoneInfoViewController"] || [urlName isEqualToString:@"WP://GPRSUsage_vc"] || [urlName isEqualToString:@"WP://mineApplication_vc"] || [urlName isEqualToString:@"WP://WPFangSaoRaoViewController"]) {
                if ([UserAuthorManager gainCurrentStateForUserLoginAndBind] == 0) {
                    [UserAuthorManager authorizationLogin:self andSuccess:^{
                       //[urlName open];
                    }andFaile:^{
                        NSLog(@"登录失败");
                    }];
                }else{
                    [urlName open];
                }
            }
            else [urlName open];
        }
    }
    
    return YES;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    
    return nil;
}

- (void)invokeClassFromString:(NSString *) className params:(void *const) params{
    
    id instance = [[NSClassFromString(className) alloc] init];
    SEL baseSelector = NSSelectorFromString(@"getParamsFromJavaScript:");
    
    NSMethodSignature *methodSig = [NSClassFromString(className) instanceMethodSignatureForSelector:baseSelector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
    [invocation setTarget:instance];
    [invocation setSelector:baseSelector];
    [invocation setArgument:params atIndex:2];
    [invocation invoke];
}

- (NSDictionary *)getInfo {
    
    DRURLParametersParser *parser = [[DRURLParametersParser alloc] initWithURLString:self.urlString];
    NSMutableDictionary *tempDic = [[parser dictionaryForURL] mutableCopy];
    NSMutableDictionary *info = [NSMutableDictionary dictionary];
    [info setObject:[tempDic objectForKey:@"function"] forKey:@"function"];
    [tempDic removeObjectForKey:@"function"];
    [info setObject:tempDic forKey:@"params"];
    
    return [info copy];
}

+ (BOOL)JavaScriptMessageDidHandleWithResponse:(id)response {
    WPURLManager *manager = [WPURLManager sharedManager];
    if (manager.finishedAction) {
        
        if ([response isKindOfClass:[NSString class]]) {
            
            manager.finishedAction(response);
        } else if ([response isKindOfClass:[NSDictionary class]]) {

            NSMutableString *responseString = [NSMutableString stringWithFormat:@"%@://woPass?function=response", JSScheme];
            [response enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
               [responseString appendFormat:@"&%@=%@&", key, obj];
            }];
            
            [responseString deleteCharactersInRange:NSMakeRange(responseString.length - 1, 1)];
            manager.finishedAction(responseString);
        } 
    }
    
    return YES;
}

+ (BOOL)sendMessage:(id)message withJavaScriptResponse:(void (^)(id responseData)) responseCallBack {
    
    WPURLManager *manager = [WPURLManager sharedManager];
    
    if ([message isKindOfClass:[NSString class]]) {
        
        manager.sendMessageAction(message, responseCallBack);
    } else if ([message isKindOfClass:[NSDictionary class]]) {
        
        NSMutableString *messageString = [NSMutableString stringWithFormat:@"%@://woPass?", JSScheme];
        [message enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [messageString appendFormat:@"%@=%@&", key, obj];
        }];
        [messageString deleteCharactersInRange:NSMakeRange(messageString.length - 1, 1)];
        manager.finishedAction(messageString);
    }
    
    return YES;
}

//    NSURL *url;
//    DRURLParametersParser *parser;
//    @try {
//        
//        url = [NSURL URLWithString:message];
//        if ([url.scheme isEqualToString:@"native"]) {
//            
//            parser = [[DRURLParametersParser alloc] initWithURL:url];
//            
//            if ([[parser valueForParameter:@"function"] isEqualToString:@"sendSMS"]) {
//                
//                // 发送短信
//            } else if([[parser valueForParameter:@"function"] isEqualToString:@"makePhoneCall"]){
//                // 打电话
//                
//            }else if([[parser valueForParameter:@"function"] isEqualToString:@"QRCode"]){
//                //扫码
//                weaklySelf();
//                WPQRCodeController *qrCtrl = [[WPQRCodeController alloc]init];
//                qrCtrl.SYQRCodeSuncessBlock = ^(WPQRCodeController *aqrvc,NSString *qrString){
//                    [weakSelf showHint:qrString hide:2];
//                    [aqrvc dismissViewControllerAnimated:NO completion:nil];
//                };
//                qrCtrl.SYQRCodeFailBlock = ^(WPQRCodeController *aqrvc){
//                    [aqrvc dismissViewControllerAnimated:NO completion:nil];
//                };
//                qrCtrl.SYQRCodeCancleBlock = ^(WPQRCodeController *aqrvc){
//                    [aqrvc dismissViewControllerAnimated:YES completion:nil];
//                };
//                [self presentViewController:qrCtrl animated:YES completion:nil];
//                
//            }
//        }
//    }
//    @catch (NSException *exception) {
//        
//        return @"error";
//    }
//    @finally {
//        
//        url = nil;
//        parser = nil;
//    }
- (id)generateCookieForCommonPara{
    
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
   //NSString *cookieValue1 = [[NSString stringWithFormat:@"userId%@", userid] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
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
    
    NSArray *cookies = @[cookie1,cookie2];
    
    NSDictionary *headers = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
    
    return [headers objectForKey:@"Cookie"] ;
}

@end







