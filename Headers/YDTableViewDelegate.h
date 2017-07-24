//
//  YDTableViewDelegate.h
//  HotelManager
//
//  Created by Tulipa on 14-5-3.
//  Copyright (c) 2014年 Tulipa. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XTableViewCellItem;
@class XTableViewCell;

@protocol YDTableViewDelegate <NSObject, UITableViewDelegate, UITableViewDataSource>

- (id)objectForTableView:(UITableView*)inTableView atIndex:(NSIndexPath*)indexPath;

- (void)didSelectObject:(id)inObject forTableView:(UITableView*)inTableView atIndex:(NSIndexPath*)indexPath;

- (void)handleActionForCell:(XTableViewCell*)cell object:(XTableViewCellItem*)item info:(id)info;

- (id)objectForTableviewSectionHeader:(UITableView *)inTableView atSection:(NSUInteger)section;

- (id)objectForTableviewSectionFooter:(UITableView *)inTableView atSection:(NSUInteger)section;

@end
