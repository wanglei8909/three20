//
//  WPLockManager.h
//  woPass
//
//  Created by htz on 15/10/29.
//  Copyright © 2015年 unisk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@interface WPLockManager : NSObject

singleton_h(Manager)

- (NSCondition *)conditionWithName:(NSString *)name;
- (BOOL)removeConditionWithName:(NSString *)name;

@end
