//
//  WPLoginUtil.h
//  woPass
//
//  Created by htz on 15/10/27.
//  Copyright © 2015年 unisk. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, WPLoginType) {
    WPLoginTypePassWord = 1,
    WPLoginTypeSmsCode,
    WPLoginTypeQrCode,
    WPLoginTypeOneKeyLogViaNet,
    WPLoginTypeUssd
};

typedef void(^LoginFinishAction)(id info);

@interface WPLoginUtil : NSObject

+ (void)loginWithPhoneNumber:(NSString *)phoneNumber
                        code:(NSString *)code
                        type:(WPLoginType)loginType
                finishAction:(LoginFinishAction)finishAction;

@end
