//
//  WPNearListCell.h
//  woPass
//
//  Created by 王蕾 on 15/8/24.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI/BMKPoiSearch.h>
#import <BaiduMapAPI/BMKPoiSearchOption.h>
#import "WPStarView.h"
#import "NIAttributedLabel.h"
#import "WPNearbyInfo.h"

@interface WPNearListCell : UITableViewCell<BMKPoiSearchDelegate>

@property (nonatomic, assign)int indexPath;
@property (nonatomic, strong)WPNearbyInfo *info;
@property (nonatomic, strong) BMKPoiSearch *poisearch;
@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)NIAttributedLabel *perPriceLabel;
@property (nonatomic, strong)UILabel *addressLabel;
@property (nonatomic, strong)UILabel *distanceLabel;
@property (nonatomic, strong)WPStarView *starView;
@property (nonatomic, copy)NSString *detailUrl;

@end
