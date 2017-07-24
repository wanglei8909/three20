//
//  TZBasicCellItem.h
//  woPass
//
//  Created by htz on 15/7/9.
//  Copyright (c) 2015年 unisk. All rights reserved.
//



#import "XTableViewCellItem.h"
#import "XTableViewCell.h"
@class NIAttributedLabel;

typedef NS_ENUM(NSUInteger, TZBasicCellMarginType) {
    TZBasicCellMiddleMargin,
    TZBasicCellTopMargin,
    TZBasicCellBottomMargin,
    TZBasicCellAllMargin
};

@interface TZBasicCellItem : XTableViewCellItem

@property (nonatomic, copy)NSString *headTitle;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *iconName;
@property (nonatomic, copy)NSString *accessoryName;
@property (nonatomic, assign)TZBasicCellMarginType marginType;


@end

@interface TZBasicCell : XTableViewCell

@property (nonatomic, strong)NIAttributedLabel *headTitleLabel;
@property (nonatomic, strong)NIAttributedLabel *titleLabel;
@property (nonatomic, strong)UIImageView *iconImageView;
@property (nonatomic, strong)UIImageView *accessoryImageView;

@end