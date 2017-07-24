//
//  WPTicketTable.h
//  woPass
//
//  Created by 王蕾 on 15/7/29.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPtableView.h"

typedef void (^GetTicket)(UITableView *tableview,NSIndexPath *indexPath);

@interface WPTicketTable : WPtableView

@property (nonatomic, copy) GetTicket getTicket;

@end
