//
//  WPSsoViewAdapterProtocol.h
//  woPass
//
//  Created by htz on 15/10/13.
//  Copyright © 2015年 unisk. All rights reserved.
//  

#import <Foundation/Foundation.h>

@protocol WPSsoViewAdapterProtocol <NSObject>

@property (nonatomic, copy)NSString *leftAppImageSrc;
@property (nonatomic, copy)NSString *centerImageSrc;
@property (nonatomic, copy)NSString *rightAppImageSrc;
@property (nonatomic, copy)NSString *leftAppName;
@property (nonatomic, copy)NSString *rightAppName;
@property (nonatomic, copy)NSString *avartaImageSrc;
@property (nonatomic, copy)NSString *phoneNum;


@end
