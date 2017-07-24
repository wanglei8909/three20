//
//  WPTicketDetailModel.h
//  woPass
//
//  Created by 王蕾 on 15/7/24.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
@interface WPTicketDetailModel : NSObject


@property (nonatomic, copy)NSString *activityName;
@property (nonatomic, assign)int couponBalance;
@property (nonatomic, assign)int couponNo;
@property (nonatomic, assign)int couponStatus;
@property (nonatomic, assign)int expire;
@property (nonatomic, assign)int id;
@property (nonatomic, copy)NSString *img;
@property (nonatomic, copy)NSString *intro;
@property (nonatomic, copy)NSString *rules;
@property (nonatomic, copy)NSString *storeAddr;
@property (nonatomic, copy)NSString *storeImg;
@property (nonatomic, copy)NSString *storeName;
@property (nonatomic, assign)int storePhone;
@property (nonatomic, copy)NSString *storeUrl;
@property (nonatomic, assign)int userId;
@property (nonatomic, copy)NSString *validEndDate;
@property (nonatomic, copy)NSString *validStartDate;

@end
