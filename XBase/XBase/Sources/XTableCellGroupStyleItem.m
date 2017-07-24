//
//  YDTableCellGroupStyleItem.m
//  common
//
//  Created by Tulipa on 14-7-14.
//  Copyright (c) 2014年  com.7ulipa. All rights reserved.
//

#import "XTableCellGroupStyleItem.h"

@implementation XTableCellGroupStyleItem

- (instancetype)init
{
    self = [super init];
    if (self)
	{
        self.position = YDTableViewCellPositionCenter;
    }
    return self;
}

@end

@implementation XTableGroupStyleCell

- (void)setTableViewCellItem:(XTableCellGroupStyleItem *)tableViewCellItem
{
	[super setTableViewCellItem:tableViewCellItem];
	[self setBackgroundView:[[UIImageView alloc]  initWithImage:[[self class] bgImageForPosition:tableViewCellItem.position]]];
}

+ (UIImage *)bgImageForPosition:(YDTableViewCellPosition)position
{
	switch (position)
	{
		case YDTableViewCellPositionTop:
			return [[UIImage imageNamed:@"common_cell_top"] stretchableImageByCenter];
			break;
		case YDTableViewCellPositionCenter:
			return [[UIImage imageNamed:@"common_cell_center"] stretchableImageByCenter];
			break;
		case YDTableViewCellPositionBottom:
			return [[UIImage imageNamed:@"common_cell_bottom"] stretchableImageByCenter];
			break;
			
		default:
			break;
	}
}

@end