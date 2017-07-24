//
//  WPMyTickettViewController.m
//  woPass
//
//  Created by htz on 15/7/21.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPMyTickettViewController.h"
#import "WPSegmented.h"
#import "WPMyTicketListModel.h"
#import "WPNoDataOtisView.h"
#import "WPMyTickesDetailController.h"
#import "WPURLManager.h"

@interface WPMyTickettViewController ()
{
    WPNoDataOtisView *otisView;
}
@end

@implementation WPMyTickettViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR_HEX(kBackgroundColor);
//    [self.tableView setTop:0];
//    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//    [self.tableView setShowsVerticalScrollIndicator:NO];
//    self.tableView.backgroundColor = RGBCOLOR_HEX(kBackgroundColor);
//    [self.tableView setFrame:UIEdgeInsetsInsetRect(self.view.bounds, UIEdgeInsetsMake(self.navigationController.navigationBar.height + 22, 0, 0, 0))];
    
    
    self.dataArray = [[NSMutableArray alloc]initWithCapacity:10];
    self.mType = 0;
    __weak typeof(self) weakSelf = self;
    self.tkTtableView = [[WPMyTicketTableView alloc]initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH, SCREEN_HEIGHT-100) style:UITableViewStylePlain];
    self.tkTtableView.scrollEnabled = YES;
    [self.view addSubview:self.tkTtableView];
    
    self.tkTtableView.tableHeaderView = [[WPSegmented alloc]initWithItems:@[@"未使用",@"已使用",@"已过期"] andBlock:^(NSInteger index){
        weakSelf.mType = index;
        [weakSelf.tkTtableView.header beginRefreshing];
    }];
    self.tkTtableView.didSelectRow = ^(XTableView *tableView, NSIndexPath *indexPath){
        NSLog(@"didSelectRow");
        WPMyTicketListModel *model = weakSelf.dataArray[indexPath.row];
        [WPURLManager openURLWithMainTitle:model.activityName urlString:model.detailUrl];
        [BaiduMob logEvent:@"id_coupons" eventLabel:@"userlistclick"];
    };
    self.tkTtableView.loadMore = ^{
        weakSelf.mPage++;
        [weakSelf RequestHttps];
    };
    self.tkTtableView.refresh = ^{
        weakSelf.mPage = 1;
        [weakSelf.dataArray removeAllObjects];
        [weakSelf RequestHttps];
    };
    
    otisView = [[WPNoDataOtisView alloc]init];
    [self.tkTtableView addSubview:otisView];
    otisView.hidden = YES;
    [self.tkTtableView.footer noticeNoMoreData];
    [self.tkTtableView.header beginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)RequestHttps{

    NSString *url = @"/u/coupons";
    NSMutableDictionary *parametersDict = [[NSMutableDictionary alloc]init];
    [parametersDict setObject:[NSString stringWithFormat:@"%d",self.mPage] forKey:@"page"];
    [parametersDict setObject:[NSString stringWithFormat:@"%ld",(long)self.mType] forKey:@"couponState"];
    weaklySelf();
    [RequestManeger POST:url parameters:parametersDict complete:processComplete(^(AFHTTPRequestOperation *      operation, id responseObject, NSString *msg) {
        NSArray *array = responseObject[@"data"][@"coupons"];
        int code = [responseObject[@"code"] intValue];
        if (code == 0) {
            for (NSDictionary *dDict in array) {
                WPMyTicketListModel *model = [WPMyTicketListModel objectWithKeyValues:dDict];
                [weakSelf.dataArray addObject:model];
            }
        }         else{
            [self showHint:msg hide:2];
        }
        weakSelf.tkTtableView.data = weakSelf.dataArray;
        [weakSelf.tkTtableView reloadData];
        
        [weakSelf.tkTtableView.header endRefreshing];
        [weakSelf.tkTtableView.footer endRefreshing];
        
        otisView.hidden = weakSelf.tkTtableView.data.count!=0;
        if (array.count<10) {
            [weakSelf.tkTtableView.footer noticeNoMoreData];
        }else{
            [weakSelf.tkTtableView.footer resetNoMoreData];
        }
        
        if (code == 99998) {
            [self ShowNoNetWithRelodAction:^{
                [weakSelf RequestHttps];
            }];
            [self showHint:msg hide:2];
        }
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
    return @"我的卡券包";
}

- (Class)scrollViewClass {
    return [WPMyTicketTableView class];
}

@end
