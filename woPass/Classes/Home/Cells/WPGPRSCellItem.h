//
//  WPGPRSCellItem.h
//  woPass
//
//  Created by htz on 15/8/10.
//  Copyright (c) 2015年 unisk. All rights reserved.
//



#import "XTableViewCellItem.h"
#import "XTableViewCell.h"

@interface WPGPRSCellItem : XTableViewCellItem

@property (nonatomic, copy)NSString *unusedValue;
@property (nonatomic, strong)NSArray *functionCellItemArray;
@property (nonatomic, assign)NSInteger numCol;


@end

@interface WPGPRSCell : XTableViewCell

@end
