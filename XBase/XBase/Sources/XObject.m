//
//  YDObject.m
//  YDBase
//
//  Created by jxzang on 14-4-28.
//  Copyright (c) 2014年  com.7ulipa All rights reserved.
//

#import "XObject.h"
#import <objc/runtime.h>

@interface XObject()
{
    __strong NSDictionary* _dictionary;
}

@end

@implementation XObject

- (id)initWithDictionary:(NSDictionary *)inDic
{
    if (self = [self init])
    {
        [self updateWithDictionary:inDic];
    }
    
    return self;
}

- (NSDictionary *)dictionary
{
    return _dictionary;
}

+ (NSMutableArray *)arrayWithDicionaryArray:(NSArray *)inArray
{
	if (! [inArray isKindOfClass:[NSArray class]])
	{
		return nil;
	}
    NSMutableArray* results = [NSMutableArray arrayWithCapacity:inArray.count];
    
    if ([inArray isKindOfClass:[NSArray class]])
    {
        for (int i = 0; i < inArray.count; i ++)
        {
            [results addObject:[[[self class] alloc] initWithDictionary:inArray[i]]];
        }
    }
    
    return results;
}

- (void)updateWithDictionary:(NSDictionary *)inDic
{
    if (! [inDic isKindOfClass:[NSDictionary class]])
    {
        return;
    }
    
    if ([self autoSetValues])
    {
        if ([inDic isKindOfClass:[NSDictionary class]])
        {
            [self setValuesForKeysWithDictionary:inDic];
        }
    }
    else
    {
        NSArray* keys = [self keys];
        if (keys.count)
        {
            for (int i = 0; i < keys.count; i++)
            {
                NSString* k = keys[i];
                [self setValue:[inDic objectForKey:k] forKey:k];
            }
        }
    }
    
    _dictionary = inDic;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    // kill NSUndefinedKeyException
    
}



- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([value isKindOfClass:[NSDictionary class]])
    {
        objc_property_t property = class_getProperty([self class], key.UTF8String);
        if (property != NULL)
        {
            NSString *attributes = [NSString stringWithFormat:@"%s", property_getAttributes(property)];
            
            NSArray *subs = [attributes componentsSeparatedByString:@","]
            ;
            
            __block NSString *result = nil;
            
            [subs enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
                NSScanner *scanner = [NSScanner scannerWithString:obj];
                
                if ([scanner scanString:@"T@" intoString:nil])
                {
                    *stop = YES;
                    [scanner scanUpToString:@"""" intoString:&result];
                }
            }];
            
            if (result)
            {
                Class klass = NSClassFromString(result);
                if ([klass isSubclassOfClass:[XObject class]])
                {
                    value = [[klass alloc] initWithDictionary:value];
                }
            }
        }
    }
    
    [super setValue:value forKey:key];
    
}

- (id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}

- (BOOL)autoSetValues
{
    return NO;
}

- (NSMutableDictionary *)dictionaryValue
{
    NSArray* keys = [self keys];
    if (keys.count)
    {
        NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithCapacity:keys.count];
        for (NSString* key in keys)
        {
            id value = [self valueForKey:key];
            if (value)
            {
                [dic setObject:value forKey:key];
            }
        }
        return dic;
    }
    else
    {
        return nil;
    }
}

+ (NSMutableArray*)dictionaryArrayWithObjectArray:(NSArray*)inArray
{
    NSMutableArray* results = [NSMutableArray arrayWithCapacity:inArray.count];
    for (XObject* obj in inArray)
    {
        NSDictionary* dic = [obj dictionaryValue];
        if (dic)
        {
            [results addObject:dic];
        }
    }
    
    return results;
}


@end
