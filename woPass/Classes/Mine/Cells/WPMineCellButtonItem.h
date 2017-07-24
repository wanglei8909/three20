//
//  WPMineCellButtonItem.h
//  woPass
//
//  Created by 王蕾 on 15/7/15.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "XTableViewCellItem.h"
#import "XTableViewCell.h"
@class NIAttributedLabel;

@interface WPMineCellButtonItem : XTableViewCellItem

@property (nonatomic, copy)NSString *btnTitle;

@end

@interface WPMineCellButton : XTableViewCell

@property (nonatomic, strong)NIAttributedLabel *btnTitleLabel;

@end