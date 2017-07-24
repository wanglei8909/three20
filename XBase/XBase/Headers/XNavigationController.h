//
//  YDNavigationController.h
//  common
//
//  Created by Tulipa on 14-7-11.
//  Copyright (c) 2014年  com.7ulipa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKNavigationController.h"

@interface XNavigationController : KKNavigationController

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated complete:(void(^)())complete;
@end
