//
//  WPOrderDetailModel.h
//  woPass
//
//  Created by 王蕾 on 15/7/24.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WPOrderDetailModel : NSObject
@property (nonatomic, assign)int buyNum;
@property (nonatomic, copy)NSString *goodsName;
@property (nonatomic, assign)int id;
@property (nonatomic, copy)NSString *img;
@property (nonatomic, copy)NSString *intro;
@property (nonatomic, assign)int orderPayState;
@property (nonatomic, assign)int orderPrice;
@property (nonatomic, assign)int originalPrice;
@property (nonatomic, assign)int rules;
@property (nonatomic, copy)NSString *storeAddr;
@property (nonatomic, copy)NSString *storeImg;
@property (nonatomic, copy)NSString *storeName;
@property (nonatomic, assign)int storePhone;
@property (nonatomic, copy)NSString *storeUrl;
@property (nonatomic, assign)int userId;
@property (nonatomic, copy)NSString *validEndDate;
@property (nonatomic, copy)NSString *validStartDate;
@end
