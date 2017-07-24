//
//  WPTiketController.m
//  woPass
//
//  Created by 王蕾 on 15/7/29.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPTiketController.h"
#import "WPURLManager.h"
#import "WPPrivileGetTicketSucceedCtrl.h"


@implementation WPTiketController

- (void)getTicket:(UITableView *)table :(NSIndexPath *)indexPath{
    //u/receiveCoupon
    [self showLoading:YES];
    
    NSLog(@"---%ld--->%ld",indexPath.section,indexPath.row);
    
    
    WPTicketModel *model = _dataArray[indexPath.row];
    
    NSString *url = @"/u/receiveCoupon";
    NSMutableDictionary *parametersDict = [[NSMutableDictionary alloc]init];
    [parametersDict setObject:[NSString stringWithFormat:@"%d",model.id] forKey:@"couponId"];
    
    [RequestManeger POST:url parameters:parametersDict complete:processComplete(^(AFHTTPRequestOperation *      operation, id responseObject, NSString *msg) {
        [self hideLoading:YES];
        int code = [responseObject[@"code"] intValue];
        if (code == 0) {
            model.hasGot = 1;
            NSArray *array = [[NSArray alloc]initWithObjects:indexPath, nil];
            [table reloadRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationLeft];
            WPPrivileGetTicketSucceedCtrl *ctrl = [[WPPrivileGetTicketSucceedCtrl alloc]init];
            ctrl.tName = model.activityName;
            [self.navigationController pushViewController:ctrl animated:YES];
        }
        [self showHint:msg hide:1];
    })];
}
-(void)viewDidLoad{
    [super viewDidLoad];
    self.dataArray = [[NSMutableArray alloc]initWithCapacity:10];
    self.mPage = 0;
    __weak typeof(self) weakSelf = self;
    self.tTable = [[WPTicketTable alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, SCREEN_HEIGHT-44) style:UITableViewStylePlain];
    [self.view addSubview:self.tTable];
    self.tTable.didSelectRow = ^(XTableView *tableView, NSIndexPath *indexPath){
        NSLog(@"didSelectRow");
        WPTicketModel *model = weakSelf.dataArray[indexPath.row];
        [WPURLManager openURLWithMainTitle:@"优惠券详情" urlString:model.detailUrl];
        [BaiduMob logEvent:@"id_coupons" eventLabel:@"couplistclick"];
    };
    self.tTable.loadMore = ^{
        weakSelf.mPage++;
        [weakSelf RequestToHttp];
    };
    self.tTable.refresh = ^{
        weakSelf.mPage = 1;
        [weakSelf.dataArray removeAllObjects];
        weakSelf.tTable.data  =weakSelf.dataArray;
        [weakSelf.tTable reloadData];
        [weakSelf RequestToHttp];
    };
    self.tTable.getTicket = ^(UITableView *tableView,NSIndexPath *indexPath){
        [weakSelf getTicket:tableView :indexPath];
    };
    
    
    _otisView = [[WPNoDataOtisView alloc]initForCoupon];
    [self.tTable addSubview:_otisView];
    _otisView.hidden = YES;
    
    [self.tTable.footer noticeNoMoreData];
    
    
    //[self RequestToHttp];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tTable.header beginRefreshing];
}

- (void)RequestToHttp {
    
    NSString *url = @"/life/coupons";
    NSMutableDictionary *parametersDict = [[NSMutableDictionary alloc]init];
    [parametersDict setObject:[NSString stringWithFormat:@"%d",self.mPage] forKey:@"page"];
    weaklySelf();
    [RequestManeger POST:url parameters:parametersDict complete:processComplete(^(AFHTTPRequestOperation *      operation, id responseObject, NSString *msg) {
        NSArray *cArray = responseObject[@"data"][@"couponList"];
        
        for (NSDictionary *dict in cArray) {
            WPTicketModel *model = [WPTicketModel objectWithKeyValues:dict];
            [_dataArray addObject:model];
        }
        _tTable.data = _dataArray;
        [_tTable reloadData];
        [weakSelf.tTable.footer endRefreshing];
        [weakSelf.tTable.header endRefreshing];
        
        if (cArray.count<10) {
            [weakSelf.tTable.footer noticeNoMoreData];
        }else{
            [weakSelf.tTable.footer resetNoMoreData];
        }
        
        if ([msg isEqualToString:@"网络异常，请重试"]) {
            [weakSelf ShowNoNetWithRelodAction:^{
                [weakSelf.tTable.header beginRefreshing];
            }];
            [weakSelf showHint:msg hide:2];
            return ;
        }
        
        weakSelf.otisView.hidden = weakSelf.tTable.data.count != 0;
        
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
    return @"品牌优惠券";
}
@end
