//
//  WPSsoViewAdapter.m
//  woPass
//
//  Created by htz on 15/10/13.
//  Copyright © 2015年 unisk. All rights reserved.
//

#import "WPSsoViewAdapter.h"
#import "WPLockManager.h"

@interface WPSsoViewAdapter ()

@property (nonatomic, copy)Action action;

@end

@implementation WPSsoViewAdapter

- (instancetype)init {
    
    if (self = [super init]) {
        
        [[WPLockManager sharedManager] conditionWithName:@"sso"];
        [self.KVOControllerNonRetaining observe:gUser keyPaths:@[@"avatarImg", @"mobile"] options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
            
            if (![gUser.avatarImg isEqualToString:@""]
                && ![gUser.mobile isEqualToString:@""]) {
                
                [[[WPLockManager sharedManager] conditionWithName:@"sso"] broadcast];
            }
            
        }];
    }
    return self;
}

- (NSString *)leftAppImageSrc {
    
    return @"appIcon-sso";
}

- (NSString *)centerImageSrc {
    
    return @"jiaohuan-SSO";
}

- (NSString *)leftAppName {
    
    return @"沃通行证";
}

- (NSString *)avartaImageSrc {
    
    return gUser.avatarImg;
}

- (NSString *)phoneNum {
    
    return gUser.mobile;
}

- (void)setWithDic:(NSDictionary *)dic {
    
    self.rightAppName = dic[@"appName"];
    self.rightAppImageSrc = dic[@"appIcon"];
    
    weaklySelf();
    dispatch_queue_t serialQueue = dispatch_queue_create("callblockQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_async(serialQueue, ^{
       
        if ([gUser.avatarImg isEqualToString:@""]
            || [gUser.mobile isEqualToString:@""]) {
            
            [[[WPLockManager sharedManager] conditionWithName:@"sso"] wait];
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            [self.KVOControllerNonRetaining observe:gUser keyPaths:@[@"avatarImg", @"mobile"] options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
                
                CallBlock(weakSelf.action);
            }];
            CallBlock(weakSelf.action);
        });
    });
}

- (instancetype)applyValueChangedAction:(Action)action {
    
    _action = action;
    return self;
}

@end
