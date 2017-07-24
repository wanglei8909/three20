//
//  WPMoreActController.m
//  woPass
//
//  Created by 王蕾 on 15/7/29.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPMoreActController.h"
#import "WPPriActListModel.h"
#import "WPURLManager.h"

@implementation WPMoreActController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.dataArray = [[NSMutableArray alloc]initWithCapacity:10];
    self.mPage = 0;
    __weak typeof(self) weakSelf = self;
    self.tTable = [[WPActTable alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, SCREEN_HEIGHT-44) style:UITableViewStylePlain];
    [self.view addSubview:self.tTable];
    self.tTable.didSelectRow = ^(XTableView *tableView, NSIndexPath *indexPath){
        NSLog(@"didSelectRow");
        WPPriActListModel *model = weakSelf.dataArray[indexPath.row];
        [WPURLManager openURLWithMainTitle:@"活动详情" urlString:model.detailUrl];
        [BaiduMob logEvent:@"id_activity" eventLabel:@"lifelistclick"];
    };
    self.tTable.loadMore = ^{
        weakSelf.mPage++;
        [weakSelf RequestToHttp];
    };
    self.tTable.refresh = ^{
        weakSelf.mPage = 1;
        [weakSelf.dataArray removeAllObjects];
        [weakSelf RequestToHttp];
    };
    
    //    otisView = [[WPNoDataOtisView alloc]init];
    //    [self.tTable addSubview:otisView];
    //    otisView.hidden = YES;
    [self.tTable.footer noticeNoMoreData];
    [self.tTable.header beginRefreshing];
    
    //[self RequestToHttp];
}

- (void)RequestToHttp{
    
    //[self showLoading:YES];
    NSString *url = @"/life/activities";
    NSMutableDictionary *parametersDict = [[NSMutableDictionary alloc]init];
    [parametersDict setObject:[NSString stringWithFormat:@"%d",self.mPage] forKey:@"page"];
    
    [RequestManeger POST:url parameters:parametersDict complete:processComplete(^(AFHTTPRequestOperation *      operation, id responseObject, NSString *msg) {
        NSArray *cArray = responseObject[@"data"][@"actList"];
        
        for (NSDictionary *dict in cArray) {
            WPPriActListModel *model = [WPPriActListModel objectWithKeyValues:dict];
            [_dataArray addObject:model];
        }
        _tTable.data = _dataArray;
        //[self hideLoading:YES];
        [self.tTable.footer endRefreshing];
        [self.tTable.header endRefreshing];
        [_tTable reloadData];
    })];
}


- (BOOL)hideNavigationBar
{
    return YES;
}

- (BOOL)hasYDNavigationBar
{
    return YES;
}

- (BOOL)autoGenerateBackBarButtonItem
{
    return YES;
}

- (NSString *)title {
    return @"精彩活动";
}

@end
