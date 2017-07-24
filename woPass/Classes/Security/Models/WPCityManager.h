//
//  WPCityManager.h
//  woPass
//
//  Created by htz on 15/8/6.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WPCityManager : NSObject

- (NSArray *)cityNameArrayWithCityCodeArrayString:(NSString *)cityCodeArrayString;
- (NSString *)ChangeCityCodeArrayStringWithCode:(NSString *)cityCode atIndex:(NSInteger)index;
- (NSString *)changeCityCodeArrayStringWithCityNameArray:(NSArray *)cityNameArray;

@end
