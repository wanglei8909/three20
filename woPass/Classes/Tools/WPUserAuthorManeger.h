//
//  WPUserAuthorManeger.h
//  woPass
//
//  Created by 王蕾 on 15/7/16.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WPUser.h"

typedef NS_ENUM(NSInteger, CurrentUserState) {
    CurrentUserState_None     = 0,  //未登录
    CurrentUserState_Main,          //用户登录
};

typedef void(^RegistFinish)();
typedef void(^RegistFailed)();

@interface WPUserAuthorManeger : NSObject

@property (nonatomic, assign) CurrentUserState  loginStatus;
@property (nonatomic, copy)   RegistFinish  finishBlock;
@property (nonatomic, copy)   RegistFailed  failedBlock;
@property (nonatomic, weak) XViewController *VC;

+ (instancetype)registerPageManager;

- (CurrentUserState)gainCurrentStateForUserLoginAndBind;

-(void)checkCurrentState;

- (void)authorizationLogin:(id)enterVC andSuccess:(RegistFinish)scccessBlock andFaile:(RegistFailed)faileBlock;

- (void)authorizationLogin:(id)enterVC andSuccess:(RegistFinish)scccessBlock andFaile:(RegistFailed)faileBlock alwaysShowLogin:(BOOL)alwaysShowLogin;

- (void)authorizationLogin:(id)enterVC andSuccess:(RegistFinish)scccessBlock andFaile:(RegistFailed)faileBlock alwaysShowLogin:(BOOL)alwaysShowLogin animation:(BOOL)enAnimation enableBack:(BOOL)enableBack;


@end
