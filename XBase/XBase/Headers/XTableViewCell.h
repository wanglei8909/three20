//
//  CTableViewCell.h
//  HotelManager
//
//  Created by Tulipa on 14-4-29.
//  Copyright (c) 2014年 Tulipa. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YDTableViewDelegate.h"


@class XTableViewCellItem;

@interface UITableViewCell (reuse)

+ (id)dequeueCellForTableView:(UITableView*)inTableView;

+ (CGFloat)heightForObject:(XTableViewCellItem*)inItem tableView:(UITableView*)inTableView;

@end

@interface XTableViewCell : UITableViewCell
{
    XTableViewCellItem* _cellItem;
}

@property (nonatomic, strong) XTableViewCellItem* tableViewCellItem;
@property (nonatomic, weak) id<YDTableViewDelegate> delegate;
@property (nonatomic, weak) UIColor* cellBackgroundColor;
@property (nonatomic, weak) UITableView* tableView;

@end
