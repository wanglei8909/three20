//
//  WPLBSCellItem.h
//  woPass
//
//  Created by htz on 15/7/15.
//  Copyright (c) 2015年 unisk. All rights reserved.
//


#import "XTableViewCellItem.h"
#import "XTableViewCell.h"
#import "WPLBSView.h"
@class NIAttributedLabel;

@interface WPLBSCellItem : XTableViewCellItem

@property (nonatomic, copy)NSString *title;
@property (nonatomic, strong)NSArray *tripViewItemArray;
@property (nonatomic, strong)NSArray *lifeViewItemArray;
@property (nonatomic, strong)NSArray *foodViewItemArray;

@end

@interface WPLBSCell : XTableViewCell

@property (nonatomic, strong)NIAttributedLabel *titleLabel;
@property (nonatomic, strong)WPLBSView *TripView;
@property (nonatomic, strong)WPLBSView *lifeView;
@property (nonatomic, strong)WPLBSView *food;

@end