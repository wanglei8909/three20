//
//  WPUserAuthorManeger.m
//  woPass
//
//  Created by 王蕾 on 15/7/16.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPUserAuthorManeger.h"
#import "WPLoginRegisterViewController.h"
#import "NSObject+TZExtension.h"

@interface WPUserAuthorManeger ()

@property (nonatomic, assign)BOOL alwaysShowLogin;
@property (nonatomic, assign)BOOL enAnimation;
@property (nonatomic, assign)BOOL enableBack;


@end

@implementation WPUserAuthorManeger

+(instancetype)registerPageManager
{
    static dispatch_once_t onceToken;
    static WPUserAuthorManeger *manager;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] initRegisterManager];
        manager.enAnimation = YES;
        manager.enableBack = YES;
        manager.alwaysShowLogin = NO;
    });
    return manager;
}

- (instancetype)init
{
    return nil;
}

- (instancetype)initRegisterManager
{
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

- (void)applyFinishBlock
{
    if (self.finishBlock) {
        self.finishBlock();
        self.finishBlock = nil;
    }
}
- (void)applyFailedBlock
{
    if (self.failedBlock) {
        self.failedBlock();
        self.failedBlock = nil;
    }
}

//申请用户授权
- (void)authorizationLogin:(id)enterVC andSuccess:(RegistFinish)scccessBlock andFaile:(RegistFailed)faileBlock{

    [self authorizationLogin:enterVC andSuccess:scccessBlock andFaile:faileBlock alwaysShowLogin:NO];
}

- (void)authorizationLogin:(id)enterVC andSuccess:(RegistFinish)scccessBlock andFaile:(RegistFailed)faileBlock alwaysShowLogin:(BOOL)alwaysShowLogin {
    
    [self authorizationLogin:enterVC andSuccess:scccessBlock andFaile:faileBlock alwaysShowLogin:alwaysShowLogin animation:YES enableBack:YES];
}

- (void)authorizationLogin:(id)enterVC andSuccess:(RegistFinish)scccessBlock andFaile:(RegistFailed)faileBlock alwaysShowLogin:(BOOL)alwaysShowLogin animation:(BOOL)enAnimation enableBack:(BOOL)enableBack {
    
    self.VC = (XViewController *)enterVC;
    self.finishBlock = scccessBlock;
    self.failedBlock = faileBlock;
    self.alwaysShowLogin = alwaysShowLogin;
    self.enAnimation = enAnimation;
    self.enableBack = enableBack;
    [self gainCurrentStateForUserLoginAndBind];
    [self installNormalLevel];
}

- (void)installNormalLevel
{
    switch (self.loginStatus) {
        case CurrentUserState_Main:
        {
            if (self.alwaysShowLogin) {
                
                [self intoUserInfoLoginVC];
            } else {
                
                [self applyFinishBlock];
            }
        }
            break;
        case CurrentUserState_None:
        {
            [self intoUserInfoLoginVC];
        }
            break;
        default:
            break;
    }
}
-(void)checkCurrentState
{
#warning 兼容，下版重构
    if ([self gainCurrentStateForUserLoginAndBind]!=CurrentUserState_None) {
        [[self getCurrentViewController].navigationController popViewControllerAnimated:YES];
        [self applyFinishBlock];
        
        [self doAdditionAction];
        
    } else {
        [self applyFailedBlock];
    }
}

- (void)doAdditionAction {
    
    // 登录成功后立即获取wifiCode、用户信息
    [RequestManeger POST:@"/u/wifiAuthorizeCode" parameters:nil complete:processComplete(^(AFHTTPRequestOperation *operation, id responseObject, NSString *msg) {
        
        if (!msg) {
            
            gUser.freeWifiCode = [[responseObject objectForKey:@"data"] objectForKey:@"validateCode"];
        }
    })];
    
    
    
    [RequestManeger POST:@"/u/userBaseInfo" parameters:nil complete:processComplete(^(AFHTTPRequestOperation *      operation, id responseObject, NSString *msg) {
        NSString *code = responseObject[@"code"];
        if ([code intValue]==0) {
            
            NSDictionary *dataDict = responseObject[@"data"];
            [gUser SetLogin:dataDict];
        }
    })];
}

- (void)intoUserInfoLoginVC
{
    
    weaklySelf();
    [@"WP://login_vc" openWithQuery:@{
                                      @"enableBack" : @(self.enableBack),
                                      @"loginFinish" : ^(id info) {
        [weakSelf checkCurrentState];
    }
                                     } animated:self.enAnimation];
}

- (CurrentUserState)gainCurrentStateForUserLoginAndBind
{
    WPUser *userModel = gUser;
    
    if (userModel.userId.length>0) {
        self.loginStatus = CurrentUserState_Main;
    }
    else{
        self.loginStatus = CurrentUserState_None;
    }
    
    return self.loginStatus;
}


@end





