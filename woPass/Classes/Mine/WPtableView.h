//
//  WPtableView.h
//  woPass
//
//  Created by 王蕾 on 15/7/21.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "XTableView.h"
#import "MJRefresh.h"

typedef void(^DidSelectRow)(XTableView *tableView,NSIndexPath *indexPath);
typedef void(^LoadMore)();
typedef void(^Refresh)();

@interface WPtableView : XTableView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, copy) DidSelectRow didSelectRow;
@property (nonatomic, copy) LoadMore loadMore;
@property (nonatomic, copy) Refresh refresh;

@end
