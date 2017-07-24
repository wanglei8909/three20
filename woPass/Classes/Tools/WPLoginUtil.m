//
//  WPLoginUtil.m
//  woPass
//
//  Created by htz on 15/10/27.
//  Copyright © 2015年 unisk. All rights reserved.
//

#import "WPLoginUtil.h"

@implementation WPLoginUtil

+ (void)loginWithPhoneNumber:(NSString *)phoneNumber code:(NSString *)code type:(WPLoginType)loginType finishAction:(LoginFinishAction)finishAction {
    
    NSString *url = @"/u/login";
    NSMutableDictionary *parametersDict = [[NSMutableDictionary alloc]init];
    [parametersDict setObject:phoneNumber forKey:@"mobile"];
    [parametersDict setObject:code forKey:@"password"];
    [parametersDict setObject:[NSString stringWithFormat:@"%ld", loginType] forKey:@"loginType"];
    
    // 登录
    [RequestManeger POST:url parameters:parametersDict complete:processComplete(^(AFHTTPRequestOperation *      operation, id responseObject, NSString *msg) {
        /*
         {
         code = 0;
         data =     {
         qrRegularExpression = "^http://www.wobendi.com/";
         refreshToken = "";
         userId = 1516607202800;
         woToken = fface206542dc78fa4b0ad3d481e1810;
         };
         message = "\U6210\U529f";
         }
         */
        if (!msg) {
            
            NSDictionary *userDict = responseObject[@"data"];
            [gUser SetLogin:userDict];
            NSLog(@"%@",gUser.woToken);
        }
        [UserAuthorManager checkCurrentState];
        CallBlock(finishAction, msg);
    })];
}

@end
