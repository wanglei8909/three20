 //
//  NSString+URLAction.h
//  common
//
//  Created by Tulipa on 14-7-10.
//  Copyright (c) 2014年  com.7ulipa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URLAction)

- (id)open;

- (id)openWithQuery:(NSDictionary *)inDic;

- (id)openWithQuery:(NSDictionary *)inDic animated:(BOOL)inAnimated;

@end
