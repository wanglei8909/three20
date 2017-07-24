//
//  WPUpdateManager.h
//  wo+life
//
//  Created by htz on 15/8/16.
//  Copyright (c) 2015年 7ul.ipa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WPUpdateManager : NSObject

@property (nonatomic, copy)NSString *appId;

+ (instancetype)manager;
- (void)update;
- (void)checkUpdate;


@end
