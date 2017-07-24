//
//  WPMyOrderListModel.h
//  woPass
//
//  Created by 王蕾 on 15/7/22.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface WPMyOrderListModel : NSObject

@property (nonatomic, assign)int buyNum;
@property (nonatomic, copy)NSString *goodsName;
@property (nonatomic, assign)int id;
@property (nonatomic, copy)NSString *img;
@property (nonatomic, assign)int orderPayState;
@property (nonatomic, assign)float orderPrice;
@property (nonatomic, assign)float originalPrice;

@end
