//
//  WPNearbyInfo.h
//  woPass
//
//  Created by 王蕾 on 15/9/16.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface WPNearbyInfo : NSObject

///POI名称
@property (nonatomic, strong) NSString* name;
///POIuid
@property (nonatomic, strong) NSString* uid;
///POI地址
@property (nonatomic, strong) NSString* address;
///POI所在城市
//@property (nonatomic, strong) NSString* city;
///POI电话号码
@property (nonatomic, strong) NSString* phone;
///POI邮编
//@property (nonatomic, strong) NSString* postcode;
///POI类型，0:普通点 1:公交站 2:公交线路 3:地铁站 4:地铁线路
//@property (nonatomic) int epoitype;
///POI坐标
@property (nonatomic) CLLocationCoordinate2D pt;

///POI价格
@property (nonatomic) double price;
///POI综合评分
@property (nonatomic) double overallRating;
///POI详情页url
@property (nonatomic, strong) NSString* detailUrl;

/////POI名称
//@property (nonatomic, strong) NSString* name;
/////POI地址
//@property (nonatomic, strong) NSString* address;
/////POI电话号码
//@property (nonatomic, strong) NSString* phone;
/////POIuid
//@property (nonatomic, strong) NSString* uid;
/////POI标签
//@property (nonatomic, strong) NSString* tag;

///POI所属分类，如“hotel”，“cater”，“life”
//@property (nonatomic, strong) NSString* type;
///POI地理坐标
//@property (nonatomic) CLLocationCoordinate2D pt;

/////POI口味评分
//@property (nonatomic) double tasteRating;
/////POI服务评分
//@property (nonatomic) double serviceRating;
/////POI环境评分
//@property (nonatomic) double environmentRating;
/////POI设施评分
//@property (nonatomic) double facilityRating;
/////POI卫生评分
//@property (nonatomic) double hygieneRating;
/////POI技术评分
//@property (nonatomic) double technologyRating;
/////POI图片数目
//@property (nonatomic) int imageNum;
/////POI团购数目
//@property (nonatomic) int grouponNum;
/////POI评论数目
//@property (nonatomic) int commentNum;
/////POI收藏数目
//@property (nonatomic) int favoriteNum;
/////POI签到数目
//@property (nonatomic) int checkInNum;
/////POI营业时间
//@property (nonatomic, strong) NSString* shopHours;

@end
