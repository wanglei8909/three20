//
//  WPSettingCellItem.h
//  woPass
//
//  Created by 王蕾 on 16/2/15.
//  Copyright © 2016年 unisk. All rights reserved.
//

#import "XTableViewCellItem.h"
#import "XTableViewCell.h"
#import "NIAttributedLabel.h"

@interface WPSettingCellItem : XTableViewCellItem

@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *iconName;
@property (nonatomic, copy)NSString *accessoryName;

@end

@interface WPSettingCell : XTableViewCell

@property (nonatomic, strong)NIAttributedLabel *titleLabel;
@property (nonatomic, strong)UIImageView *iconImageView;
@property (nonatomic, strong)UIImageView *accessoryImageView;
@property (nonatomic, strong)UILabel *cacheLabel;

@end
