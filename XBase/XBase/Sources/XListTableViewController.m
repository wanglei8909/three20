//
//  CListTableViewController.m
//  HotelManager
//
//  Created by Tulipa on 14-5-9.
//  Copyright (c) 2014年 Tulipa. All rights reserved.
//

#import "XListTableViewController.h"
#import "NSArray+YDTableSectionView.h"

@interface XListTableViewController ()

@end

@implementation XListTableViewController

- (NSArray *)items
{
    return _items;
}

- (void)setItems:(NSArray *)items
{
    _items = items;
    
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.items.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.items[section] count];
}

- (id)objectForTableView:(UITableView *)inTableView atIndex:(NSIndexPath *)indexPath
{
    return [self.items[indexPath.section] objectAtIndex:indexPath.row];
}

- (id)objectForTableviewSectionHeader:(UITableView *)inTableView atSection:(NSUInteger)section
{
	return [self.items[section] sectionHeaderItem];
}

- (id)objectForTableviewSectionFooter:(UITableView *)inTableView atSection:(NSUInteger)section
{
    return [self.items[section] sectionFooterItem];
}

@end
