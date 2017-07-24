//
//  WPUser.m
//  woPass
//
//  Created by htz on 15/7/7.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPUser.h"
#import "Singleton.h"
#import "Reachability.h"
#import <objc/runtime.h>
#import "MJExtension.h"
#import "APService.h"
#import "WPLoginHistoryUtil.h"

@interface WPUser () {
    
    dispatch_queue_t _serialQueue;
}
@end

@implementation WPUser
singleton_m(WPUser)

@synthesize unikey = _unikey;

- (instancetype)init {
    
    if (self = [super init]) {
        
        weaklySelf();
        [[self getAllProperties] enumerateObjectsUsingBlock:^(id key, NSUInteger idx, BOOL *stop) {
            id value = [[NSUserDefaults standardUserDefaults] objectForKey:key];
            [weakSelf setValue:value forKeyPath:key];
            [weakSelf addObserver:weakSelf forKeyPath:key options:NSKeyValueObservingOptionNew context:NULL];
            
        }];
        
        _serialQueue = dispatch_queue_create("userSerialQueue", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

#pragma mark - getter

- (NSString *)isSet {
    return _isSet ? _isSet : @"";
}

- (NSString *)showShowAbnormal {
    
    return _showShowAbnormal ? _showShowAbnormal : @"0";
}

-(NSString *)avatarImg{
    
    __block NSString *result;
    dispatch_sync(_serialQueue, ^{
        
        result = _avatarImg?_avatarImg:@"";
    });
    return result;
}
-(NSString *)birthday{
    return _birthday?_birthday:@"";
}
-(NSString *)gender{
    if (!_gender) {
        return @"";
    }
    return [_gender intValue]==0?@"男":@"女";
}
- (NSString *)mobile {
    
    __block NSString *result;
    
    dispatch_sync(_serialQueue, ^{
       
        result = _mobile?_mobile:@"";
    });
    return result;
}
- (NSString *)maskedMobile {
    
    NSString *result = gUser.mobile;
    if (result.length == 11) {
        
        result = [result stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    }
    return result;
}
-(NSString *)nickname{
    return _nickname?_nickname:@"";
}
-(NSString *)regionCode{
    return _regionCode?_regionCode:@"";
}
-(NSString *)signature{
    return _signature?_signature:@"";
}
- (NSString *)userId {
    return _userId ? _userId : @"";
}
- (NSString *)lng {
    return _lng ? _lng : @"116.3";
}
- (NSString *)lat {
    return _lat ? _lat : @"39.9";
}
- (NSString *)city {
    return _city ? _city : @"";
}
- (NSDictionary *)locationCityDict{
    return _locationCityDict ? _locationCityDict : @{@"name":@"北京",@"id":@"110100"};
}
- (NSString *)woToken {
    return _woToken ? _woToken : @"";
}
- (NSString *)connnectType {
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
     NetworkStatus status = [reachability currentReachabilityStatus];
    switch (status) {
        case ReachableViaWiFi:
            return @"2";
            break;
        case ReachableViaWWAN:
            return @"1";
            break;
        case NotReachable:
            return @"-1";
            break;
    }
}
- (NSString *)unikey {
    
    if (!_unikey) {
        
        CFUUIDRef puuid = CFUUIDCreate( nil );
        CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
        __block NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
        CFRelease(puuid);
        CFRelease(uuidString);
        
        NSArray *subStringArray = [result componentsSeparatedByString:@"-"];
        result = @"";
        
        [subStringArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            result = [result stringByAppendingString:obj];
        }];
        
        _unikey = [result lowercaseString];
        self.unikey = _unikey;
    }
    
    return _unikey;
}
- (NSString *)email {
    return _email ? _email : @"";
}
- (NSString *)emailIsavalible {
    return _emailIsavalible ? _emailIsavalible : @"";
}
- (NSString *)passStrength {
    return _passStrength ? _passStrength : @"";
}
- (NSString *)realNameIsauth {
    return _realNameIsauth ? _realNameIsauth : @"";
}
- (NSString *)isLoginProtect {
    
    return _isLoginProtect ? _isLoginProtect : @"";
}
- (NSString *)commonLoginPlace {
    return _commonLoginPlace ? _commonLoginPlace : @"0";
}
- (NSString *)freeWifiCode {
    return _freeWifiCode ? _freeWifiCode : @"";
}
- (NSString *)realName {
    return _realName ? _realName : @"";
}
- (NSString *)idcardType {
    return _idcardType ? _idcardType : @"";
}
-(NSString *)idcardNo {
    return _idcardNo ? _idcardNo : @"";
}
-(NSString *)securityLevel {
    
    return _securityLevel ? _securityLevel : @"";
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    

    id newValue = [change objectForKey:@"new"];
    if ([newValue isKindOfClass:[NSString class]]) {
        if (newValue && ![newValue isEqualToString:@""]) {
            
            [[NSUserDefaults standardUserDefaults] setObject:newValue forKey:keyPath];
        } else {
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:keyPath];
        }
    }else if ([newValue isKindOfClass:[NSDictionary class]]){
        if (newValue && [newValue count]>0) {
            [[NSUserDefaults standardUserDefaults] setObject:newValue forKey:keyPath];
        } else {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:keyPath];
        }
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    //坚挺登录 或是退出登陆 jPush绑定
    if ([keyPath isEqualToString:@"userId"]) {
        if ([UserAuthorManager gainCurrentStateForUserLoginAndBind] == 0) {
            [APService setAlias:@"" callbackSelector:nil object:nil];
        }else{
            [APService setAlias:gUser.userId callbackSelector:nil object:nil];
        }
    }
}

- (void)SetLogin:(NSDictionary *)userDict{
    NSArray *properties = [self getAllProperties];
    for (NSString *key in properties) {
        for (NSString *dKey in userDict) {
            if ([key isEqualToString:dKey]) {
                NSString *value = [NSString stringWithFormat:@"%@",userDict[dKey]];
                [self setValue:value forKey:key];
                break;
            }
        }
    }
    
    [BaiduMob logEvent:@"id_login_success" eventLabel:@"id_login_success"];
    
    NSLog(@"%@", gUser.userId);
}

- (void)QutiLogin:(QuitFinish)quitBlock{
    NSArray *properties = [self getAllProperties];
    [[WPLoginHistoryUtil sharedUtil] clearCache];
    for (NSString *key in properties) {
        if ([key isEqualToString:@"freeWifiIsAvaliable"] || [key isEqualToString:@"isLoginProtect"] || [key isEqualToString:@"commonSwitchIsOn"]|| [key isEqualToString:@"commonLoginPlace"] || [key isEqualToString:@"locationCityDict"] || [key isEqualToString:@"lng"] || [key isEqualToString:@"lat"]) {
            continue;
        }
        [self setValue:nil forKey:key];
    }
    /*
    freeWifiIsAvaliable
    isLoginProtect
    commonSwitchIsOn
    commonLoginPlace*/
    
    //还需清楚cookies
    
    if (quitBlock) {
        quitBlock();
    }
}

- (NSArray *)getAllProperties
{
    u_int count;
    objc_property_t *properties  =class_copyPropertyList([self class], &count);
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++)
    {
        const char* propertyName =property_getName(properties[i]);
        [propertiesArray addObject: [NSString stringWithUTF8String: propertyName]];
    }
    free(properties);
    return propertiesArray;
}

@end
