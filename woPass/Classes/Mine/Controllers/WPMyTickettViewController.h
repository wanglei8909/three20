//
//  WPMyTickettViewController.h
//  woPass
//
//  Created by htz on 15/7/21.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "XListTableViewController.h"
#import "WPMyTicketTableView.h"


@interface WPMyTickettViewController : XListTableViewController


@property (nonatomic, assign)int mPage;
@property (nonatomic, retain)WPMyTicketTableView *tkTtableView;
@property (nonatomic, assign)NSInteger mType;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end
