//
//  WPMineCellItem.h
//  woPass
//
//  Created by 王蕾 on 15/7/15.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "XTableViewCellItem.h"
#import "XTableViewCell.h"

@class NIAttributedLabel;

@interface WPMineCellItem : XTableViewCellItem
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *iconName;
@property (nonatomic, copy)NSString *accessoryName;


@end

@interface WPMineCell : XTableViewCell
@property (nonatomic, strong)NIAttributedLabel *titleLabel;
@property (nonatomic, strong)UIImageView *iconImageView;
@property (nonatomic, strong)UIImageView *accessoryImageView;
@property (nonatomic, strong)UILabel *cacheLabel;

@end







