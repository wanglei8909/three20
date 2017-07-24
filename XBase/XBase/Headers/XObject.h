//
//  YDObject.h
//  YDBase
//
//  Created by jxzang on 14-4-28.
//  Copyright (c) 2014年  com.7ulipa All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XObject : NSObject

@property (nonatomic, readonly) NSDictionary* dictionary;

@property (nonatomic, strong) NSMutableArray* keys;

//@property (nonatomic, strong) TTURLAction* action;

- (id)initWithDictionary:(NSDictionary*)inDic;

- (void)updateWithDictionary:(NSDictionary*)inDic;

- (BOOL)autoSetValues;

- (NSMutableDictionary*)dictionaryValue;

+ (NSMutableArray*)dictionaryArrayWithObjectArray:(NSArray*)inArray;

+ (NSMutableArray*)arrayWithDicionaryArray:(NSArray*)inArray;

@end
