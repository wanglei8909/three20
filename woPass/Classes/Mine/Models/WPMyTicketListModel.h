//
//  WPMyTicketListModel.h
//  woPass
//
//  Created by 王蕾 on 15/7/22.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface WPMyTicketListModel : NSObject

@property (nonatomic, copy)NSString *activityName;
@property (nonatomic, assign)int couponBalance;
@property (nonatomic, copy)NSString *couponNo;
@property (nonatomic, assign)int couponStatus;
@property (nonatomic, copy) NSString *detailUrl;
@property (nonatomic, assign)int expire;
@property (nonatomic, assign)int id;
@property (nonatomic, copy)NSString *img;
@property (nonatomic, copy)NSString *storeName;
@property (nonatomic, copy)NSString *validEndDate;
@property (nonatomic, copy)NSString *validStartDate;

@end
