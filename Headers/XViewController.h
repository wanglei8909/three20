//
//  CViewController.h
//  HotelManager
//
//  Created by Tulipa on 14-5-6.
//  Copyright (c) 2014年 Tulipa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XNavigationBar.h"
@interface UIViewController (Hint)

- (void)showLoading:(BOOL)animated;
- (void)hideLoading:(BOOL)animated;
- (void)showHint:(NSString *)hint hide:(CGFloat)delay;

@end

@interface XViewController : UIViewController

@property (nonatomic, strong) XNavigationBar* ydNavigationBar;

@property (nonatomic, readonly) UINavigationItem *xNavigationItem;

- (void)ShowNoData;

- (void)ShowNoNetWithRelodAction:(void(^)()) block;
- (void)ShowNoNetWithRelodAction:(void(^)()) block adapt:(CGFloat)adapt;

- (BOOL)hasYDNavigationBar;

- (CGFloat)ydNavigationBarHeight;

- (void)AddRightTextBtn:(NSString *)name target:(id)target action:(SEL)action;
- (void)AddRightImageBtn:(UIImage *)image target:(id)target action:(SEL)action;
- (void)AddLeftTextBtn:(NSString *)name target:(id)target action:(SEL)action;

@end
