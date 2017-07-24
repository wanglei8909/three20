//
//  WPLockManager.m
//  woPass
//
//  Created by htz on 15/10/29.
//  Copyright © 2015年 unisk. All rights reserved.
//

#import "WPLockManager.h"

@interface WPLockManager ()

@property (nonatomic, strong)NSMutableDictionary *locks;
@property (nonatomic, strong)NSMutableDictionary *conditons;

@end

@implementation WPLockManager

singleton_m(Manager)

#pragma mark - Constructors and Life cycle

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.conditons = [NSMutableDictionary dictionary];
        self.locks = [NSMutableDictionary dictionary];
    }
    return self;
}



#pragma mark - Private Method

- (id)exist:(NSString *)name inDictionary:(NSDictionary *)dic {
    
    return [dic objectForKey:name];
}


#pragma mark - Public

- (BOOL)removeConditionWithName:(NSString *)name {
    
    [self. conditons removeObjectForKey:name];
    return YES;
}

- (NSCondition *)conditionWithName:(NSString *)name {
    
    NSCondition *conditon = [self exist:name inDictionary:self.conditons];
    
    if (!conditon) {
        
        conditon = [[NSCondition alloc] init];
        [self.conditons setObject:conditon forKey:name];
    }
    return conditon;
}

@end
