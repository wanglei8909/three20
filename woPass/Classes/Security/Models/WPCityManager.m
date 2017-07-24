//
//  WPCityManager.m
//  woPass
//
//  Created by htz on 15/8/6.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPCityManager.h"

@interface WPCityManager ()

@property (nonatomic, strong)NSMutableArray *cities;


@end

@implementation WPCityManager

- (NSMutableArray *)cities {
    if (!_cities) {
        _cities = [[NSMutableArray alloc] init];
        
    }
    return _cities;
}

- (instancetype)init {
    
    if (self = [super init]) {
        
        NSData *cityData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"region(1)" ofType:@"txt"]];
        NSArray *cityArray = [NSJSONSerialization JSONObjectWithData:cityData options:NSJSONReadingMutableLeaves error:NULL];
        
        weaklySelf();
        [cityArray enumerateObjectsUsingBlock:^(NSDictionary *cityDic, NSUInteger idx, BOOL *stop) {
            
            [[cityDic objectForKey:@"cities"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                
                [weakSelf.cities addObject:obj];
            }];
        }];
        
    }
    return self;
}

- (NSArray *)cityNameArrayWithCityCodeArrayString:(NSString *)cityCodeArrayString {
    
    if ([cityCodeArrayString isEqualToString:@""]) {
        
        return @[@"", @"", @""];
    }
    
    NSArray *cityCodeArray = [cityCodeArrayString componentsSeparatedByString:@","];
    NSMutableArray *cityNameArray = [NSMutableArray array];
    weaklySelf();
    [cityCodeArray enumerateObjectsUsingBlock:^(NSString *code, NSUInteger idx, BOOL *stop) {
        
        [cityNameArray addObject:[weakSelf cityNameWithCodeString:code]];
    }];
    
    for (; cityNameArray.count < 3; ) {
        
        [cityNameArray addObject:@""];
    }
    return [cityNameArray copy];
}

- (NSString *)cityNameWithCodeString:(NSString *)codeString {
    
    __block NSString *result = @"";
    [self.cities enumerateObjectsUsingBlock:^(NSDictionary *cityDic, NSUInteger idx, BOOL *stop) {
        
        if ([[cityDic[@"id"] stringValue] isEqualToString:codeString]) {
            
            result = cityDic[@"name"];
            *stop = YES;
        }
    }];
    return result;
}

- (NSString *)codeStringWithCityName:(NSString *)cityName {
    
    __block NSString *code = @"";
    [self.cities enumerateObjectsUsingBlock:^(NSDictionary *cityDic, NSUInteger idx, BOOL *stop) {
       
        if ([cityDic[@"name"] isEqualToString:cityName]) {
            
            code = [cityDic[@"id"] stringValue];
            *stop = YES;
        }
    }];
    return code;
}

- (NSString *)ChangeCityCodeArrayStringWithCode:(NSString *)cityCode atIndex:(NSInteger)index {
    
    NSMutableString *cityCodeArrayString = [gUser.commonLoginPlace mutableCopy] ? [gUser.commonLoginPlace mutableCopy] : @"";
    NSMutableArray *cityCodeArray = [[cityCodeArrayString componentsSeparatedByString:@","] mutableCopy];
    for (; cityCodeArray.count < 3; ) {
        
        [cityCodeArray addObject:@""];
    }
    
    cityCodeArray[index] = cityCode;
    NSMutableString *result = [NSMutableString string];
    [cityCodeArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        [result appendString:[NSString stringWithFormat:@"%@,", obj]];
    }];
    [result deleteCharactersInRange:NSMakeRange(result.length - 1, 1)];
    gUser.commonLoginPlace = result;
    return result;
}

- (NSString *)changeCityCodeArrayStringWithCityNameArray:(NSArray *)cityNameArray {

    
    NSMutableString *result = [NSMutableString string];
    weaklySelf();
    [cityNameArray enumerateObjectsUsingBlock:^(NSString *cityName, NSUInteger idx, BOOL *stop) {
       
        [result appendString:[NSString stringWithFormat:@"%@,", [weakSelf codeStringWithCityName:cityName]]];
    }];
    [result deleteCharactersInRange:NSMakeRange(result.length - 1, 1)];
    gUser.commonLoginPlace = result;
    return result;
}

@end
