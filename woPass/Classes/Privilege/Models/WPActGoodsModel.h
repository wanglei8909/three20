//
//  WPActGoodsModel.h
//  woPass
//
//  Created by 王蕾 on 15/8/6.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"


@interface WPActGoodsModel : NSObject

@property (nonatomic, assign)int id;
@property (nonatomic, assign)int maxNum;
@property (nonatomic, copy)NSString *intro;
@property (nonatomic, assign)float price;

@property (nonatomic, copy)NSString *title;


@end
