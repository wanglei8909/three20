//
//  WPMapSelectedSheet.m
//  woPass
//
//  Created by 王蕾 on 15/8/28.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPMapSelectedSheet.h"
#import <MapKit/MapKit.h>

@implementation WPMapSelectedSheet
{
    BMKPoiInfo *mInfo;
    NSMutableArray *titleArray;
}
- (void)dealloc{
    mInfo = nil;
}

-(instancetype)initWithData:(WPNearbyInfo *)info{
    mInfo = info;
    titleArray = [[NSMutableArray alloc]initWithCapacity:10];
    [titleArray addObject:@"苹果地图"];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
        [titleArray addObject:@"百度地图"];
    }
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
        [titleArray addObject:@"高德地图"];
    }
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]]) {
        [titleArray addObject:@"谷歌地图"];
    }
    
    NSString *title1 = @"苹果地图";
    NSString *title2 = nil;
    NSString *title3 = nil;
    NSString *title4 = nil;
    for (int i = 0; i<titleArray.count; i++) {
        if (i==1) {
            title2 = titleArray[i];
        }else if (i==2){
            title3 = titleArray[i];
        }else if (i==3){
            title4 = titleArray[i];
        }
    }
    
    self = [super initWithTitle:@"选择地图" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:title1,title2,title3,title4, nil];
    
    return self;
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == titleArray.count) {
        
        return;
    }
    
    NSString *mapName = titleArray[buttonIndex];
    if ([mapName isEqualToString:@"苹果地图"]) {
        MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:mInfo.pt addressDictionary:nil]];
        [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                       launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,
                                       MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
    }
    else if ([mapName isEqualToString:@"百度地图"]){
        NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=目的地&mode=driving&coord_type=gcj02",mInfo.pt.latitude, mInfo.pt.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
    }
    else if ([mapName isEqualToString:@"高德地图"]){
        NSString *urlString = [[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=%@&lat=%f&lon=%f&dev=0&style=2",@"沃通行证",@"wopass",mInfo.pt.latitude, mInfo.pt.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
    }
    else if ([mapName isEqualToString:@"谷歌地图"]){
        NSString *urlString = [[NSString stringWithFormat:@"comgooglemaps://?x-source=%@&x-success=%@&saddr=&daddr=%f,%f&directionsmode=driving",@"沃通行证",@"wopass",mInfo.pt.latitude, mInfo.pt.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
