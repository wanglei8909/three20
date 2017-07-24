//
//  XBase.h
//  XBase
//
//  Created by 臧金晓 on 14/12/23.
//  Copyright (c) 2014年 7ul.ipa. All rights reserved.
//

#ifndef XBase_XBase_h
#define XBase_XBase_h

#import "UIView+Sizes.h"
#import "UIImage+Stretch.h"
#import "XViewController.h"
#import "UIViewController+Navigation.h"
#import <Three20UINavigator/UIViewController+TTNavigator.h>
#import <Three20UINavigator/Three20UINavigator.h>
#import <Three20UINavigator/TTURLAction.h>
//#import "UIViewController+TTNavigator.h"
//#import "Three20UINavigator.h
//#import "TTURLAction.h"
#import "XNavigator.h"
#import "NSString+URLAction.h"
#import "XFont.h"
#import "UILabel+Helper.h"

#define px (1.0 / [UIScreen mainScreen].scale)

#define weaklySelf() __weak __typeof(self) weakSelf = self
#define blocklySelf() __block __typeof(self) blockSelf = self
#define deviceOSVersion [[[UIDevice currentDevice] systemVersion] floatValue]


#define weakly(...) try {} @finally {} metamacro_foreach_cxt(ext_weakly,, __weak, __VA_ARGS__)

#define ext_weakly(INDEX, CONTEXT, VAR) CONTEXT __typeof__(VAR) metamacro_concat(VAR, Weak) = (VAR);

#define APPVERSION ([[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"])

#ifdef DEBUG
#define YDLog(fmt, ...) NSLog((@"%s [MainThread=%i] [Line %d] " fmt), __PRETTY_FUNCTION__, [NSThread isMainThread], __LINE__, ##__VA_ARGS__);
#define YDLog1(fmt, ...)
#else
#define YDLog(...)
#define YDLog1(fmt, ...)
#endif

#define WLogFunction()	YDLog(@"")

#define YDAvalibleOS(os_version) ([[[UIDevice currentDevice] systemVersion] floatValue] >= os_version)


#define DECLARE_SHARED_INSTANCE(className)  \
+ (className *)sharedInstance;


#define IMPLEMENT_SHARED_INSTANCE(className)  \
+ (className *)sharedInstance { \
static className *sharedInstance = nil; \
@synchronized(self) { \
if (!sharedInstance) { \
sharedInstance = [[[self class] alloc] init]; \
} \
} \
return sharedInstance; \
}

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f \
alpha:(a)]

#define RGBCOLOR_HEX(h) RGBCOLOR((((h)>>16)&0xFF), (((h)>>8)&0xFF), ((h)&0xFF))
#define RGBACOLOR_HEX(h,a) RGBACOLOR((((h)>>16)&0xFF), (((h)>>8)&0xFF), ((h)&0xFF), (a))
#define RGBPureColor(h) RGBCOLOR(h, h, h)

#define HSVCOLOR(h,s,v) [UIColor colorWithHue:(h) saturation:(s) value:(v) alpha:1]
#define HSVACOLOR(h,s,v,a) [UIColor colorWithHue:(h) saturation:(s) value:(v) alpha:(a)]

#define RGBA(r,g,b,a) (r)/255.0f, (g)/255.0f, (b)/255.0f, (a)

#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)568) < DBL_EPSILON)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)

#endif
