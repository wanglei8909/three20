//
//  YDTableCellGroupStyleItem.h
//  common
//
//  Created by Tulipa on 14-7-14.
//  Copyright (c) 2014年  com.7ulipa. All rights reserved.
//

#import "XTableViewCellItem.h"
#import "XTableViewCell.h"

typedef NS_OPTIONS(NSUInteger, YDTableViewCellPosition)
{
    YDTableViewCellPositionTop = 1 << 0,
    YDTableViewCellPositionCenter = 1 << 1,
    YDTableViewCellPositionBottom = 1 << 2,
};

@interface XTableCellGroupStyleItem : XTableViewCellItem

//默认是 center
@property (nonatomic, assign) YDTableViewCellPosition position;

@end

@interface XTableGroupStyleCell : XTableViewCell

+ (UIImage *)bgImageForPosition:(YDTableViewCellPosition)position;

@end
