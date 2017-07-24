//
//  WPLoginDetailProtocol.h
//  woPass
//
//  Created by htz on 15/10/29.
//  Copyright © 2015年 unisk. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WPLoginDetailProtocol <NSObject>

@property (nonatomic, copy)NSString *loginDT;
@property (nonatomic, copy)NSString *deviceType;
@property (nonatomic, copy)NSString *loginCity;
@property (nonatomic, copy)NSString *loginIP;
@property (nonatomic, copy)NSString *loginDate;
@property (nonatomic, copy)NSString *loginTime;
@property (nonatomic, copy)NSString *loginAppName;
@property (nonatomic, copy)NSString *remoteLogin;
@property (nonatomic, copy)NSString *detailLoginTime;

@end
