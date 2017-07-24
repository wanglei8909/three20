//
//  NSObject+TZExtension.m
//  test
//
//  Created by htz on 15/7/1.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "NSObject+TZExtension.h"

@implementation NSObject (TZExtension)

- (UIViewController *)getCurrentViewController {
    
    UIViewController *result = nil;
    
    __block UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    
    if (window.windowLevel != UIWindowLevelNormal) {
        
        NSArray *windows = [[UIApplication sharedApplication] windows];
        
        [windows enumerateObjectsUsingBlock:^(UIWindow *tempWindow, NSUInteger idx, BOOL *stop) {
            
            if (tempWindow.windowLevel == UIWindowLevelNormal) {
                
                window = tempWindow;
                *stop = YES;
            }
        }];
    }
    
    UIView *frontView = [[window subviews] firstObject];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    if (result.childViewControllers.count) {
        
        if ([result isKindOfClass:[UITabBarController class]]) {
            
            result = [((UITabBarController *)result) selectedViewController];
        }
        
        for (; result.childViewControllers.count; ) {
            
            if (result.presentedViewController) {
                
                result = [result.presentedViewController.childViewControllers lastObject];
            } else {
                
                result = [result.childViewControllers lastObject];
            }
        }
    }
    
    return result;
}

@end
