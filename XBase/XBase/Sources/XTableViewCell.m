//
//  CTableViewCell.m
//  HotelManager
//
//  Created by Tulipa on 14-4-29.
//  Copyright (c) 2014年 Tulipa. All rights reserved.
//

#import "XTableViewCell.h"
#import "XTableViewCellItem.h"

@implementation UITableViewCell (reuse)

+ (id)dequeueCellForTableView:(UITableView *)inTableView
{
    XTableViewCell* cell = [inTableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (! cell)
    {
        cell = [[[self class] alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
    }
    return cell;
}

+ (CGFloat)heightForObject:(XTableViewCellItem *)inItem tableView:(UITableView *)inTableView
{
    return 44;
}

@end

@implementation XTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setCellBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:self.cellBackgroundColor];
}

- (void)setCellBackgroundColor:(UIColor *)cellBackgroundColor
{
    [super setBackgroundColor:cellBackgroundColor];
}

- (UIColor *)cellBackgroundColor
{
    return self.backgroundColor;
}

- (void)setTableViewCellItem:(XTableViewCellItem *)tableViewCellItem
{
    _cellItem = tableViewCellItem;
}

- (XTableViewCellItem *)tableViewCellItem
{
    return _cellItem;
}

- (void)prepareForReuse
{
	[super prepareForReuse];
	self.tableViewCellItem.tableViewCell = nil;
}

@end
