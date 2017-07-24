//
//  WPLLProductModel.h
//  woPass
//
//  Created by 王蕾 on 15/8/12.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface WPLLProductModel : NSObject

@property (nonatomic, copy)NSString *current_price;
@property (nonatomic, copy)NSString *des;
@property (nonatomic, copy)NSString *original_price;
@property (nonatomic, assign)int productId;
@property (nonatomic, copy)NSString *productName;
@property (nonatomic, assign) BOOL selected;

@end
