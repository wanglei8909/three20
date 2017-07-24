//
//  WPMyTicketController.h
//  woPass
//
//  Created by 王蕾 on 15/7/21.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "XViewController.h"
#import "WPMyTicketTableView.h"

@interface WPMyTicketController : XViewController

@property (nonatomic, assign)int mPage;
@property (nonatomic, strong)WPMyTicketTableView *mTableView;
@property (nonatomic, assign)NSInteger mType;


@end
