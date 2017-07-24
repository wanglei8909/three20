//
//  WPUser.h
//  woPass
//
//  Created by htz on 15/7/7.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

#define gUser [WPUser sharedWPUser]

typedef void(^QuitFinish)();

@interface WPUser : NSObject

- (void)QutiLogin:(QuitFinish)quitBlock;

- (void)SetLogin:(NSDictionary *)userDict;


- (NSArray *)getAllProperties;

@property (nonatomic, copy  ) NSString *hostUrl;
@property (nonatomic, copy  ) NSString *avatarImg;
@property (nonatomic, strong  ) NSData *avatarImgData;
@property (nonatomic, copy  ) NSString *birthday;
@property (nonatomic, copy  ) NSString *gender;
@property (nonatomic, copy  ) NSString *mobile;
@property (nonatomic, copy  ) NSString *maskedMobile;
@property (nonatomic, copy  ) NSString *nickname;
@property (nonatomic, copy  ) NSString *regionCode;
@property (nonatomic, copy  ) NSString *signature;
@property (nonatomic, copy  ) NSString *email;
@property (nonatomic, copy  ) NSString *emailIsavalible;
@property (nonatomic, copy  ) NSString *passStrength;
@property (nonatomic, copy  ) NSString *isSet;
@property (nonatomic, copy  ) NSString *realNameIsauth;
@property (nonatomic, copy  ) NSString *realName;
@property (nonatomic, copy  ) NSString *idcardType;
@property (nonatomic, copy  ) NSString *idcardNo;
@property (nonatomic, copy  ) NSString *securityLevel;
@property (nonatomic, copy  ) NSString *lastLoginRegion;

@property (nonatomic, copy) NSString     *userId;
@property (nonatomic, copy) NSString     *connnectType;
@property (nonatomic, copy) NSString     *unikey;
@property (nonatomic, copy) NSString     *lng;
@property (nonatomic, copy) NSString     *lat;
@property (nonatomic, copy) NSString     *city;
@property (nonatomic, copy) NSString     *woToken;
@property (nonatomic, copy) NSString     *thirdLogin;
@property (nonatomic, copy) NSString     *freeWifiIsAvaliable;
@property (nonatomic, copy) NSString     *freeWifiCode;
@property (nonatomic, copy) NSString     *isLoginProtect;
@property (nonatomic, copy) NSString     *commonLoginPlace;
@property (nonatomic, copy) NSString     *isLogining;
@property (nonatomic, copy) NSDictionary *locationCityDict;
@property (nonatomic, copy) NSString     *showShowAbnormal;


singleton_h(WPUser)

@end
