//
//  WPTest.m
//  woPass
//
//  Created by htz on 15/7/31.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPTest.h"
#import "WPURLManager.h"

@interface WPTest ()

@property (nonatomic, copy)NSString *name;


@end

@implementation WPTest


- (void)getParamsFromJavaScript:(id) params {

    self.name = params[@"name"];
    NSLog(@"我接收到来自js调用native的消息，消息参数为:%@", params);

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [WPURLManager JavaScriptMessageDidHandleWithResponse:@{
                                                               @"success" : @"1"
                                                               }];
        NSLog(@"来自js的消息已处理完毕");
    });
    
    [WPURLManager sendMessage:@"我给js发了一个消息：fuck" withJavaScriptResponse:^(id responseData) {
       
        NSLog(@"我收到了来自js的回应消息：%@", responseData);
    }];
}

- (void)dealloc {

    NSLog(@"asdfasdfasdfasdfasdfasedf");
}

@end
