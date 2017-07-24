//
//  WPPagerAdsModel.m
//  woPass
//
//  Created by htz on 15/7/23.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPPagerAdsModel.h"

@implementation WPPagerAdsModel

+ (NSDictionary *)replacedKeyFromPropertyName {
    
    return @{
             @"imageURL" : @"imgUrl",
             @"actionURL" : @"adLink"
             };
}

@end
