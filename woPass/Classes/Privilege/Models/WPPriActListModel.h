//
//  WPPriActListModel.h
//  woPass
//
//  Created by 王蕾 on 15/7/29.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface WPPriActListModel : NSObject
/*
 activitySort = "<null>";
 endTime = 1438071000;
 id = 29;
 img = "http://api.life.wobendi.cn/res/2015/07/27/c21f3f02-f0b7-4c8a-8f31-20c156e065b9.jpeg";
 joinNum = 0;
 mainTitle = "\U6d4b\U8bd5\U4e3b\U6807\U9898111";
 oldValuation = "\U00a51000.00";
 provideNum = "<null>";
 startTime = 1437984600;
 state = 1;
 subTitle = "\U6d4b\U8bd5\U526f\U6807\U9898111";
 timeText = "\U8ddd\U79bb\U7ed3\U675f:0\U592917\U65f654\U5206";
 url = "";
 valuation = "\U00a5800.00";
 */
@property (nonatomic, copy)NSString *activitySort;
@property (nonatomic, assign)NSInteger endTime;
@property (nonatomic, assign)int id;
@property (nonatomic, copy)NSString *img;
@property (nonatomic, assign)int joinNum;
@property (nonatomic, copy)NSString *mainTitle;
@property (nonatomic, copy)NSString *oldValuation;
@property (nonatomic, copy)NSString *provideNum;
@property (nonatomic, assign)NSInteger startTime;
@property (nonatomic, assign)int state;
@property (nonatomic, copy)NSString *subTitle;
@property (nonatomic, copy)NSString *timeText;
@property (nonatomic, copy)NSString *detailUrl;
@property (nonatomic, copy)NSString *valuation;

@end





