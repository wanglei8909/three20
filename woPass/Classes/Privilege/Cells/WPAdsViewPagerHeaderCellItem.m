//
//  WPAdsViewPagerHeaderCellItem.m
//  woPass
//
//  Created by htz on 15/7/26.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPAdsViewPagerHeaderCellItem.h"

@implementation WPAdsViewPagerHeaderCellItem

- (CGFloat)heightForTableView:(UITableView *)inTableView {
    
    return (SCREEN_WIDTH / 320) * 165;
}

- (Class)cellClass {
    
    return [WPAdsViewPagerHeaderCell class];
}

- (BOOL)autoSetValues {
    
    return YES;
}

@end

@implementation WPAdsViewPagerHeaderCell


@end
