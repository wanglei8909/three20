//
//  WPUpdateManager.m
//  wo+life
//
//  Created by htz on 15/8/16.
//  Copyright (c) 2015年 7ul.ipa. All rights reserved.
//

#import "WPUpdateManager.h"
#import "NSObject+TZExtension.h"

@interface WPUpdateManager () <UIAlertViewDelegate>

@end

@implementation WPUpdateManager

+ (instancetype)manager {
    
    return [[self alloc] init];
}

- (instancetype)init {
    
    if (self = [super init]) {
        
        
    }
    return self;
}

- (NSString *)appId {
    
    return @"991603240";
}

- (void)checkUpdate  {
    
    [RequestManeger POST:@"/c/checkVersion" parameters:nil complete:processComplete(^(AFHTTPRequestOperation *operation, id responseObject, NSString *msg) {
        
        // 需要更新
        if ([[responseObject objectForKey:@"code"] integerValue] == 912) {
            
            // 必须更新
            if ([[[responseObject objectForKey:@"data"] objectForKey:@"mustUpdate"] integerValue] == 1) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"有新版本" delegate:self cancelButtonTitle:nil otherButtonTitles:@"更新", nil];
                [alert show];
                
            // 可选更新
            } else {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"有新版本" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"更新", nil];
                [alert show];
            }
        }
    })];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    // 非强制更新
    if ([[alertView buttonTitleAtIndex:0] isEqualToString:@"取消"]) {
        
        if (buttonIndex == 1) {
            
            [self update];
        }
    // 强制更新
    } else {
        
        [self update];
    }
}

- (void)update {
    
    UIViewController *current_vc = [self getCurrentViewController];
    [current_vc showLoading:YES];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://itunes.apple.com/cn/lookup" parameters:@{
                                                                   @"id" : self.appId
                                                                   } complete:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
                                                                       [current_vc hideLoading:YES];
                                                                       NSString *urlString = [[[responseObject objectForKey:@"results"] firstObject] objectForKey:@"trackViewUrl"];
                                                                       dispatch_async(dispatch_queue_create("haha", DISPATCH_QUEUE_SERIAL), ^{
                                                                           
                                                                           if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlString]]) {
                                                                               
                                                                               [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
                                                                           }
                                                                       });
                                                                   }];
}

@end
