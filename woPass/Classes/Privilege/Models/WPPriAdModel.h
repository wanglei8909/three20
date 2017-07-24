//
//  WPPriAdModel.h
//  woPass
//
//  Created by 王蕾 on 15/7/29.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface WPPriAdModel : NSObject
/*
 adLink = "\U58eb\U5927\U592b";
 img = "http://api.life.wobendi.cn/res/2015/04/13/eaa6cc11-2208-4bd6-bd5c-c9296b231dad.png";
 intro = "\U6253\U7684";
 sortId = "<null>";
 title = "\U5e7f\U544a";
 */
@property (nonatomic, copy)NSString *adLink;
@property (nonatomic, copy)NSString *img;
@property (nonatomic, copy)NSString *intro;
@property (nonatomic, copy)NSString *sortId;
@property (nonatomic, copy)NSString *title;

@end
