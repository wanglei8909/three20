//
//  WPMyTicketController.m
//  woPass
//
//  Created by 王蕾 on 15/7/21.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPMyTicketController.h"
#import "WPSegmented.h"

@implementation WPMyTicketController

-(void)viewDidLoad{
    
    
    self.mType = 0;
    __weak typeof(self) weakSelf = self;
    _mTableView = [[WPMyTicketTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _mTableView.scrollEnabled = YES;
    _mTableView.tableHeaderView = [[WPSegmented alloc]initWithItems:@[@"未使用",@"已使用",@"已过期"] andBlock:^(NSInteger index){
        weakSelf.mType = index;
    }];
    _mTableView.didSelectRow = ^(XTableView *tableView, NSIndexPath *indexPath){
        
    };
    _mTableView.loadMore = ^{
        weakSelf.mPage++;
        [weakSelf RequestHttps];
    };
    _mTableView.refresh = ^{
        weakSelf.mPage = 1;
        [weakSelf RequestHttps];
    };
    
    [self.view addSubview:_mTableView];
    
    [_mTableView.header beginRefreshing];
}
- (void)RequestHttps{
    [self showLoading:YES];
    
    NSString *url = @"/u/coupons";
    NSMutableDictionary *parametersDict = [[NSMutableDictionary alloc]init];
    [parametersDict setObject:[NSString stringWithFormat:@"%d",self.mPage] forKey:@"page"];
    
    [RequestManeger POST:url parameters:parametersDict complete:processComplete(^(AFHTTPRequestOperation *      operation, id responseObject, NSString *msg) {
        [_mTableView.header endRefreshing];
        [_mTableView.footer endRefreshing];
        [self hideLoading:YES];
        
    })];
}


- (BOOL)hideNavigationBar
{
    return YES;
}

- (BOOL)hasYDNavigationBar
{
    return NO;
}

- (BOOL)autoGenerateBackBarButtonItem
{
    return YES;
}

- (NSString *)title {
    return @"我的卡券";
}

@end
