//
//  WPTiketController.h
//  woPass
//
//  Created by 王蕾 on 15/7/29.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "XViewController.h"
#import "WPTicketTable.h"
#import "WPTicketModel.h"
#import "WPNoDataOtisView.h"

@interface WPTiketController : XViewController

@property (nonatomic, strong)WPNoDataOtisView *otisView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, assign)int mPage;
@property (nonatomic, strong)WPTicketTable *tTable;


@end
