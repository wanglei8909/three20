//
//  WPSecurityLevelCellItem.h
//  woPass
//
//  Created by htz on 15/7/8.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "XTableViewCellItem.h"
#import "XTableViewCell.h"
#import "WPSecurityLevelView.h"

@interface WPSecurityLevelCellItem : XTableViewCellItem

@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *subTitle;
@property (nonatomic, strong)NSArray *securityLevelCellItemArray;

@end

@interface WPSecurityLevelCell : XTableViewCell

@end

