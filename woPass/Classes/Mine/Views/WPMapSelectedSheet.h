//
//  WPMapSelectedSheet.h
//  woPass
//
//  Created by 王蕾 on 15/8/28.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI/BMKPoiSearch.h>
#import <BaiduMapAPI/BMKPoiSearchOption.h>
#import "WPNearbyInfo.h"

@interface WPMapSelectedSheet : UIActionSheet<UIActionSheetDelegate>


-(instancetype)initWithData:(WPNearbyInfo *)info;

@end
