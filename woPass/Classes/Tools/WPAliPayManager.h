//
//  WPAliPayManager.h
//  woPass
//
//  Created by 王蕾 on 15/8/4.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WPAliPayManager : NSObject


+ (void)PayWithOrderNo:(NSString *)tradeNO withProductName:(NSString *)productName withProductDescription:(NSString *)productDescription withAmount:(NSString *)amount withCallBackUrl:(NSString *)callBackUrl andSucceedBlock:(void(^)()) succeedBlock andFaildBlock:(void(^)(NSString *faildCode)) faildBlock;


@end
