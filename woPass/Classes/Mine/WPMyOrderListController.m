//
//  WPMyOrderListController.m
//  woPass
//
//  Created by 王蕾 on 15/7/21.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPMyOrderListController.h"
#import "WPMyOrderListModel.h"
#import "WPNoDataOtisView.h"
#import "WPMyOrderDetailController.h"
#import "WPMyOrderCell.h"
#import "WPCommitOrderCtrl.h"
#import "WPSelePayTypeView.h"
#import "WPAliPayManager.h"
#import "WPPrivilegePaySucceedCtrl.h"

@implementation WPMyOrderListController
{
    WPNoDataOtisView *otisView;
}
-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.mDataArray = [[NSMutableArray alloc]initWithCapacity:10];
    self.mType = 0;
    __weak typeof(self) weakSelf = self;
    _tableView = [[WPMyOrderTableView alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, SCREEN_HEIGHT-44) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.scrollEnabled = YES;
    _tableView.tableHeaderView = [[WPSegmented alloc]initWithItems:@[@"全部",@"未付款",@"已付款"] andBlock:^(NSInteger index){
        weakSelf.mType = index;
        [_tableView.header beginRefreshing];
    }];
    _tableView.didSelectRow = ^(XTableView *tableView, NSIndexPath *indexPath){
        
        WPMyOrderDetailController *ctrl = [[WPMyOrderDetailController alloc]init];
        ctrl.orderModel = weakSelf.mDataArray[indexPath.row];
        ctrl.payFinish = ^(WPMyOrderListModel *model){
            [weakSelf RefreshPayStatus:model];
        };
        [weakSelf.navigationController pushViewController:ctrl animated:YES];
        [BaiduMob logEvent:@"id_order_form" eventLabel:@"listclick"];
    };
    _tableView.mDelegate = weakSelf;
    _tableView.payOrder = @selector(GoPay:);
    
    _tableView.loadMore = ^{
        weakSelf.mPage++;
        [weakSelf RequestHttps];
    };
    _tableView.refresh = ^{
        weakSelf.mPage = 1;
        [weakSelf.mDataArray removeAllObjects];
        weakSelf.tableView.data  =weakSelf.mDataArray;
        [weakSelf.tableView reloadData];
        [weakSelf RequestHttps];
    };
    
    [self.view addSubview:_tableView];
    
    otisView = [[WPNoDataOtisView alloc]initForOrder];
    [_tableView addSubview:otisView];
    otisView.hidden = YES;
    
    [_tableView.header beginRefreshing];
}


- (void)CheckOrder : (NSInteger) index :(WPMyOrderListModel *)orderModel{
    //u/payOrder
    NSString *url = @"/u/payOrder";
    NSMutableDictionary *parametersDict = [[NSMutableDictionary alloc]init];
    [parametersDict setObject:[NSString stringWithFormat:@"%d",orderModel.id] forKey:@"userOrderId"];
    [parametersDict setObject:[NSString stringWithFormat:@"%ld",(long)index] forKey:@"payType"];
    
    [RequestManeger POST:url parameters:parametersDict complete:processComplete(^(AFHTTPRequestOperation *      operation, id responseObject, NSString *msg) {
        /*
         {
         code = 0;
         data =     {
         payCallbackUrl = "http://dev.txz.wohulian.cn/cb/aliPay";
         payType = 1;
         userOrderId = 20;
         };
         message = success;
         }
         */
        int code = [responseObject[@"code"] intValue];
        if (code == 0) {
            if (index == 1) {
                [self GoAliPay:orderModel :responseObject[@"data"][@"payCallbackUrl"]];
            }
            
        }else{
            [self showHint:responseObject[@"msg"] hide:2];
        }
        
    })];
}
- (void)RefreshPayStatus:(WPMyOrderListModel *)orderModel{
    if (self.mType == 1) {
        for (WPMyOrderListModel*model in _mDataArray) {
            if (model.id == orderModel.id) {
                [_mDataArray removeObject:model];
                [_tableView reloadData];
                otisView.hidden = _tableView.data.count!=0;
                break;
            }
        }
    }else if(self.mType == 0){
        for (WPMyOrderListModel*model in _mDataArray) {
            if (model.id == orderModel.id) {
                model.orderPayState = 1;
                [_tableView reloadData];
                break;
            }
        }
    }
}
- (void)GoAliPay:(WPMyOrderListModel *)orderModel :(NSString *)callBakcUrl{
    weaklySelf();
    [WPAliPayManager PayWithOrderNo:[NSString stringWithFormat:@"%d",orderModel.id] withProductName:orderModel.goodsName withProductDescription:@"缺此参数" withAmount:[NSString stringWithFormat:@"%.2f",orderModel.orderPrice] withCallBackUrl:callBakcUrl andSucceedBlock:^{
        [weakSelf hideLoading:YES];
        [weakSelf RefreshPayStatus:orderModel ];
        [weakSelf hideLoading:YES];
        
        BOOL have = NO;
        for (UIViewController *ctrl in self.navigationController.viewControllers) {
            if ([ctrl isKindOfClass:[WPPrivilegePaySucceedCtrl class]]) {
                have = YES;
                WPPrivilegePaySucceedCtrl *sCtrl = (WPPrivilegePaySucceedCtrl *)ctrl;
                sCtrl.goodsName = orderModel.goodsName;
                sCtrl.goodsPrice = [NSString stringWithFormat:@"%.2f",orderModel.orderPrice];
                [self.navigationController popToViewController:sCtrl animated:YES];
            }
        }
        if (!have) {
            WPPrivilegePaySucceedCtrl *ctrl = [[WPPrivilegePaySucceedCtrl alloc]init];
            ctrl.goodsName = orderModel.goodsName;
            ctrl.goodsPrice = [NSString stringWithFormat:@"%.2f",orderModel.orderPrice];
            [self.navigationController pushViewController:ctrl animated:YES];
        }
        
    }andFaildBlock:^(NSString *code){
        [weakSelf hideLoading:YES];
        
    }];
}
- (void)GoPay:(WPMyOrderCell *)cell{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    WPSelePayTypeView *payTypeView = [[WPSelePayTypeView alloc]initWithFrame:window.bounds];
    payTypeView.mBlock = ^(NSInteger index){
        [self showLoading:YES];
        if (index == 1) {//支付宝
            [self CheckOrder:index :cell.model];
        }else if (index == 2){//微信
            [self CheckOrder:index :cell.model];
        }
    };
    [window addSubview:payTypeView];

}

- (void)RequestHttps{
    
    int type = -1;
    switch (self.mType) {
        case 0:
            type = -1;
            break;
        case 1:
            type = 0;
            break;
        case 2:
            type = 1;
            break;
        default:
            break;
    }
    
    NSString *url = @"/u/orders";
    NSMutableDictionary *parametersDict = [[NSMutableDictionary alloc]init];
    [parametersDict setObject:[NSString stringWithFormat:@"%d",self.mPage] forKey:@"page"];
    [parametersDict setObject:[NSString stringWithFormat:@"%d",type] forKey:@"orderType"];
    [RequestManeger POST:url parameters:parametersDict complete:processComplete(^(AFHTTPRequestOperation *      operation, id responseObject, NSString *msg) {
        NSArray *array = responseObject[@"data"][@"orders"];
        int code = [responseObject[@"code"] intValue];
        if (code == 0) {
            for (NSDictionary *dDict in array) {
                WPMyOrderListModel *model = [WPMyOrderListModel objectWithKeyValues:dDict];
                [self.mDataArray addObject:model];
            }
            _tableView.data = self.mDataArray;
            [_tableView reloadData];
            
            
        }else{
            [self showHint:msg hide:2];
        }
        [_tableView.header endRefreshing];
        [_tableView.footer endRefreshing];
        otisView.hidden = _tableView.data.count!=0;
        if (array.count<10) {
            [_tableView.footer noticeNoMoreData];
        }else{
            [_tableView.footer resetNoMoreData];
        }
        
        if (code == 99998) {
            [self ShowNoNetWithRelodAction:^{
                [self RequestHttps];
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
    return @"我的订单";
}

@end
