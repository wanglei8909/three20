//
//  WPMyOrderDetailController.h
//  woPass
//
//  Created by 王蕾 on 15/7/24.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "XViewController.h"
#import "WPMyOrderListModel.h"
#import "WPOrderDetailModel.h"
#import "WPOrderDetailTopView.h"
#import "WPShopsInfoView.h"
#import "WPOrderTimeView.h"
#import "WPTicketMiddleView.h"
#import "WPTicketRuleView.h"

typedef void(^PayFinish)(WPMyOrderListModel *model);
@interface WPMyOrderDetailController : XViewController

@property (nonatomic, copy) PayFinish payFinish;
@property (nonatomic, strong)WPMyOrderListModel *orderModel;
@property (nonatomic, strong)WPOrderDetailModel *detailModel;
@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)WPOrderDetailTopView *topView;
@property (nonatomic, strong)WPShopsInfoView *shopView;
@property (nonatomic, strong)WPOrderTimeView *timeView;
@property (nonatomic, strong)WPTicketMiddleView *middleView;
@property (nonatomic, strong)WPTicketRuleView *ruleView;

@end



