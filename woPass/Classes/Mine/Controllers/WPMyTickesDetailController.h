//
//  WPMyTickesDetailController.h
//  woPass
//
//  Created by 王蕾 on 15/7/24.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "XTableViewController.h"
#import "WPMyTicketListModel.h"
#import "WPTicketDetailModel.h"
#import "WPTicketDetailTopView.h"
#import "WPTicketMiddleView.h"
#import "WPTicketRuleView.h"
#import "WPShopsInfoView.h"

@interface WPMyTickesDetailController : XTableViewController


@property (nonatomic, strong) WPMyTicketListModel *ticketModel;
@property (nonatomic, strong) WPTicketDetailModel *detailModel;
@property (nonatomic, strong) UIScrollView *mScroller;
@property (nonatomic, strong) WPTicketDetailTopView *topView;
@property (nonatomic, strong) WPTicketMiddleView *middleView;
@property (nonatomic, strong) WPTicketRuleView *ruleView;
@property (nonatomic, strong) WPShopsInfoView *shopView;

@end
