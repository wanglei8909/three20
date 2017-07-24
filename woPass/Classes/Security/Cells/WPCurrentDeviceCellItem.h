//
//  WPCurrentDeviceCellItem.h
//  woPass
//
//  Created by htz on 15/7/9.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "TZBasicCellItem.h"
#import "MJExtension.h"

@interface WPCurrentDeviceCellItem : TZBasicCellItem

@property (nonatomic, copy)NSString *subHeadTitle;
@property (nonatomic, copy)NSString *subTitle;
@property (nonatomic, copy)NSString *deviceId;

@end


@interface WPCurrentDeviceCell : TZBasicCell

@end
