//
//  CTableViewCellItem.h
//  HotelManager
//
//  Created by Tulipa on 14-4-29.
//  Copyright (c) 2014年 Tulipa. All rights reserved.
//

#import "XObject.h"

@class XTableViewCell;

@interface XTableViewCellItem : XObject

@property (nonatomic, strong) TTURLAction* action;

@property (nonatomic, strong) void(^actionBlock)(UITableView *tableView, id info);

@property (nonatomic, weak) XTableViewCell *tableViewCell;

- (Class)cellClass;

- (CGFloat)heightForTableView:(UITableView*)inTableView;

- (id)applyAction:(TTURLAction *)action;
- (id)applyActionBlock:(void (^)(UITableView *, id))actionBlock;

@end
