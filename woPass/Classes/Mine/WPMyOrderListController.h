//
//  WPMyOrderListController.h
//  woPass
//
//  Created by 王蕾 on 15/7/21.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "XViewController.h"
#import "WPSegmented.h"
#import "WPMyOrderTableView.h"


@interface WPMyOrderListController : XViewController

@property (nonatomic, strong)NSMutableArray *mDataArray;
@property (nonatomic, assign)int mPage;
@property (nonatomic, strong)WPMyOrderTableView *tableView;
@property (nonatomic, assign)NSInteger mType;

@end
