//
//  WPLoginedHeaderCellItem.h
//  woPass
//
//  Created by htz on 15/7/14.
//  Copyright (c) 2015年 unisk. All rights reserved.
//


#import "XTableViewCellItem.h"
#import "XTableViewCell.h"

typedef void(^Action)(void);

@interface WPLoginedHeaderCellItem : XTableViewCellItem

@property (nonatomic, copy)NSString *headPortraitName;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *subTitle;
@property (nonatomic, copy)NSString *realNameImageName;

@property (nonatomic, copy)NSString *locationImageName;
@property (nonatomic, copy)NSString *locationTitle;
@property (nonatomic, copy)NSString *locationSubTitle;
@property (nonatomic, copy)NSString *locationAccessoryImageName;
@property (nonatomic, copy)NSString *abnormalImageName;

@property (nonatomic, assign)BOOL showAbnormal;


- (instancetype)applyUpperAction:(Action)upperClickAction lowerAction:(Action)lowerClickAction;

@end

@interface WPLoginedHeaderCell : XTableViewCell

@end
