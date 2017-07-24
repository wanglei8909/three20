//
//  WPUtilityCellItem.h
//  woPass
//
//  Created by htz on 15/7/15.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "XTableViewCellItem.h"
#import "XTableViewCell.h"
#import "WPUtilityView.h"

@interface WPUtilityCellItem : XTableViewCellItem

@property (nonatomic, strong)NSArray *utilityViewItemsArray;
@property (nonatomic, assign)NSInteger numCol;


@end

@interface WPUtilityCell : XTableViewCell

@property (nonatomic, strong)WPUtilityView *utilityView;

@end
