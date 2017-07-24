//
//  CTableViewCellItem.m
//  HotelManager
//
//  Created by Tulipa on 14-4-29.
//  Copyright (c) 2014年 Tulipa. All rights reserved.
//

#import "XTableViewCellItem.h"
#import "XTableViewCell.h"

@implementation XTableViewCellItem

- (Class)cellClass
{
    return [XTableViewCell class];
}

- (CGFloat)heightForTableView:(UITableView *)inTableView
{
    return [[self cellClass] heightForObject:self tableView:inTableView];
}

- (id)applyAction:(TTURLAction *)action
{
	self.action = action;
	return self;
}

- (id)applyActionBlock:(void (^)(UITableView *, id))actionBlock
{
	self.actionBlock = actionBlock;
	return self;
}

@end
