//
//  WPModifyUserInfoViewModel.h
//  woPass
//
//  Created by 王蕾 on 15/7/22.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WPModifyUserInfoViewModel : NSObject


+ (void)ChangeUserInfoWithType:(NSString *)key AndValue:(NSString *)value AndSecceed:(void(^)())succeed;

+ (void)ChangeUserHeaderImage:(UIImage *)image AndSecceed:(void (^)(NSString *imageUrl))succeed;


@end
