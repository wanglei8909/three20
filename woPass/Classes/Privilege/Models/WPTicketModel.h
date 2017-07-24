//
//  WPTicketModel.h
//  woPass
//
//  Created by 王蕾 on 15/7/29.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface WPTicketModel : NSObject
/*
 activityName = wsxing;
 couponBalance = 10;
 detailUrl = "http://dev.txz.wohulian.cn/page/couponDetail?id=1&userId=1516607202800";
 endDate = "2015-09-16";
 hasGot = 1;
 id = 1;
 img = "http://api.life.wobendi.cn/res/2015/07/15/f0b39697-2084-4ba2-b635-3794c953a3f4.png";
 restNum = 2;
 startDate = "2015-07-14";
 storeImg = "http://api.life.wobendi.cn/res/2015/04/14/a35d22ba-9242-4d2d-9ed9-051385e94657.jpeg";
 storeName = "\U5929\U732b";
 totalNum = 3;
 */

@property (nonatomic, copy)NSString *activityName;
@property (nonatomic, assign)int couponBalance;
@property (nonatomic, copy)NSString *endDate;
@property (nonatomic, assign)int hasGot;
@property (nonatomic, copy)NSString *detailUrl;
@property (nonatomic, assign)int id;
@property (nonatomic, copy)NSString *img;
@property (nonatomic, assign)int restNum;
@property (nonatomic, copy)NSString *startDate;
@property (nonatomic, copy)NSString *storeImg;
@property (nonatomic, copy)NSString *storeName;
@property (nonatomic, assign)int totalNum;


@end
