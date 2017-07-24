//
//  CTableViewController.h
//  HotelManager
//
//  Created by Tulipa on 14-5-3.
//  Copyright (c) 2014年 Tulipa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YDTableViewDelegate.h"
#import "XScrollViewController.h"
#import "XTableView.h"

@interface XTableViewController : XScrollViewController <YDTableViewDelegate>

@property (nonatomic, readonly) XTableView* tableView;
@property (nonatomic, strong) UIView* emptyView;

- (Class)tableViewClass;

- (UITableViewStyle)tableViewStyle;

@end
