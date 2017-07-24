//
//  WPAdsCellItem.h
//  woPass
//
//  Created by htz on 15/7/14.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "XTableViewCellItem.h"
#import "XTableViewCell.h"
#import "WPAdsView.h"

@interface WPAdsCellItem : XTableViewCellItem

@property (nonatomic, strong)NSArray *adsViewItemsArray;
@property (nonatomic, assign)NSInteger numCol;


@end

@interface WPAdsCell : XTableViewCell

@property (nonatomic, strong)WPAdsView *adsView;



@end
