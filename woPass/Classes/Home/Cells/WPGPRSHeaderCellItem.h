//
//  WPGPRSHeaderCellItem.h
//  woPass
//
//  Created by htz on 15/8/10.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "XTableViewCellItem.h"
#import "XTableViewCell.h"
#import "MJExtension.h"

@interface WPGPRSHeaderCellItem : XTableViewCellItem

@property (nonatomic, copy)NSString *unusedValue;
@property (nonatomic, copy)NSString *mobile;
@property (nonatomic, copy)NSString *uesdPercent;
@property (nonatomic, copy)NSString *usedValue;
@property (nonatomic, copy)NSString *total;
@property (nonatomic, copy)NSString *dayUnused;
@property (nonatomic, copy)NSString *dayUsed;

@property (nonatomic, strong)NSArray *usageArray;



@end

@interface WPGPRSHeaderCell : XTableViewCell

@end
