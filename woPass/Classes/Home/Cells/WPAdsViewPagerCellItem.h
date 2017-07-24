//
//  WPAdsViewPagerCellItem.h
//  woPass
//
//  Created by htz on 15/7/15.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "XTableViewCellItem.h"
#import "XTableViewCell.h"
#import "GCPagingView.h"

typedef void(^Action)(void);

@interface WPAdsViewPagerCellItem : XTableViewCellItem

@property (nonatomic, strong)NSArray *pagerAdsArray;
@property (nonatomic, strong)NSMutableArray *imagesArray;
@property (nonatomic, assign)CGFloat imageHeight;

@property (nonatomic, copy)Action imageReadyAction;

- (instancetype)applyImageReadyAction:(Action)imageReadyAction;



@end

@interface WPAdsViewPagerCell : XTableViewCell

@property (nonatomic, strong)GCPagingView *adsPagerView;
@property (nonatomic, strong)NSArray *imagesArray;


@end