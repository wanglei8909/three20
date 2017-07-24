//
//  WPLoginHistoryCellItem.h
//  woPass
//
//  Created by htz on 15/7/19.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "XTableViewCellItem.h"
#import "XTableViewCell.h"
#import "MJExtension.h"
@class NIAttributedLabel;

@interface WPLoginHistoryCellItem : XTableViewCellItem

@property (nonatomic, copy)NSString *loginDT;
@property (nonatomic, copy)NSString *deviceType;
@property (nonatomic, copy)NSString *loginCity;
@property (nonatomic, copy)NSString *loginIP;
@property (nonatomic, copy)NSString *loginDate;
@property (nonatomic, copy)NSString *loginTime;
@property (nonatomic, copy)NSString *loginAppName;
@property (nonatomic, copy)NSString *remoteLogin;
@property (nonatomic, copy)NSString *detailLoginTime;
@property (nonatomic, assign)BOOL isFirst;


@end

@interface WPLoginHistoryCell : XTableViewCell





@end