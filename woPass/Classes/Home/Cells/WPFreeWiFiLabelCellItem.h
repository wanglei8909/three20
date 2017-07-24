//
//  WPFreeWiFiLabelCellItem.h
//  woPass
//
//  Created by htz on 15/8/2.
//  Copyright (c) 2015年 unisk. All rights reserved.
//


#import "XTableViewCellItem.h"
#import "XTableViewCell.h"
@class NIAttributedLabel;

@interface WPFreeWiFiLabelCellItem : XTableViewCellItem

@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *wikiTitle;


@end

@interface WPFreeWiFiLabelCell : XTableViewCell

@property (nonatomic, strong)NIAttributedLabel *titleLabel;
@property (nonatomic, strong)NIAttributedLabel *wikiLabel;


@end
