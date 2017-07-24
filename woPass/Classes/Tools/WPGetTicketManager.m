//
//  WPGetTicketManager.m
//  woPass
//
//  Created by 王蕾 on 15/8/5.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPGetTicketManager.h"
#import "NSObject+TZExtension.h"
#import "WPPrivileGetTicketSucceedCtrl.h"

@implementation WPGetTicketManager

-(void)getParamsFromJavaScript:(NSDictionary *) ticketId{
    
    
    UIViewController *ctrl = [self getCurrentViewController];
    [[self getCurrentViewController] showLoading:YES];
    
    NSString *url = @"/u/receiveCoupon";
    NSMutableDictionary *parametersDict = [[NSMutableDictionary alloc]init];
    [parametersDict setObject:[NSString stringWithFormat:@"%@",ticketId[@"id"]] forKey:@"couponId"];
    
    [RequestManeger POST:url parameters:parametersDict complete:processComplete(^(AFHTTPRequestOperation *      operation, id responseObject, NSString *msg) {
        [[self getCurrentViewController] hideLoading:YES];
        int code = [responseObject[@"code"] intValue];
        if (code == 0) {
            WPPrivileGetTicketSucceedCtrl *wpctrl = [[WPPrivileGetTicketSucceedCtrl alloc]init];
            wpctrl.tName = ticketId[@"title"];
            [ctrl.navigationController pushViewController:wpctrl animated:YES];
        }else{
            [[self getCurrentViewController] showHint:msg hide:2];
        }
    })];
    [BaiduMob logEvent:@"id_coupons" eventLabel:@"get"];
    
}


@end
