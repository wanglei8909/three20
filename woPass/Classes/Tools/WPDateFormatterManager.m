//
//  WPDateFormatterManager.m
//  woPass
//
//  Created by 王蕾 on 15/11/23.
//  Copyright © 2015年 unisk. All rights reserved.
//

#import "WPDateFormatterManager.h"

@implementation WPDateFormatterManager


+(WPDateFormatterManager *)sharedManager{
    static dispatch_once_t predicate;
    static WPDateFormatterManager * sharedManager;
    dispatch_once(&predicate, ^{
        sharedManager=[[WPDateFormatterManager alloc] init];
        sharedManager.dateFormat = @"yyyy-MM-dd";
    });
    return sharedManager;
}

@end

