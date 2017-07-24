//
//  WPMyOrderDetailController.m
//  woPass
//
//  Created by 王蕾 on 15/7/24.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPMyOrderDetailController.h"
#import "WPCommitOrderCtrl.h"
#import "WPSelePayTypeView.h"
#import "WPAliPayManager.h"
#import "WPOrderBuySucceedCtrl.h"
#import "WPPrivilegePaySucceedCtrl.h"

@implementation WPMyOrderDetailController


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
- (void)GoAliPay:(WPMyOrderListModel *)orderModel :(NSString *)callBakcUrl{
    weaklySelf();
    [WPAliPayManager PayWithOrderNo:[NSString stringWithFormat:@"%d",orderModel.id] withProductName:orderModel.goodsName withProductDescription:@"缺此参数" withAmount:[NSString stringWithFormat:@"%.2f",orderModel.orderPrice] withCallBackUrl:callBakcUrl andSucceedBlock:^{
        
        weakSelf.orderModel.orderPayState = 1;
        [weakSelf.topView layoutSubviews];
        
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
        
        
        if (self.payFinish) {
            self.payFinish(orderModel);
        }
        
        [weakSelf hideLoading:YES];
        
    }andFaildBlock:^(NSString *code){
        [weakSelf hideLoading:YES];
        
    }];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, SCREEN_HEIGHT-44)];
    self.scrollView.backgroundColor = RGBCOLOR_HEX(kBackgroundColor);
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.scrollEnabled = YES;
    [self.view addSubview:self.scrollView];
    
    self.topView = [[WPOrderDetailTopView alloc]init];
    self.topView.model = self.orderModel;
    weaklySelf();
    self.topView.payBlock = ^{
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        WPSelePayTypeView *payTypeView = [[WPSelePayTypeView alloc]initWithFrame:window.bounds];
        payTypeView.mBlock = ^(NSInteger index){
            [weakSelf showLoading:YES];
            if (index == 1) {//支付宝
                [weakSelf CheckOrder:index :weakSelf.orderModel];
            }else if (index == 2){//微信
                [weakSelf CheckOrder:index :weakSelf.orderModel];
            }
        };
        [window addSubview:payTypeView];
    };
    [self.scrollView addSubview:self.topView];
    
    [self RequestHttp];
}
- (void)ReloadUI{
    self.shopView = [[WPShopsInfoView alloc]initWithFrame:CGRectMake(0, self.topView.bottom+10, SCREEN_WIDTH, 90)];
    self.shopView.nameStr = self.detailModel.storeName;
    self.shopView.addressStr = self.detailModel.storeAddr;
    self.shopView.iconUrl = self.detailModel.storeImg;
    self.shopView.phoneNum = self.detailModel.storePhone;
    [self.scrollView addSubview:self.shopView];
    
    self.timeView = [[WPOrderTimeView alloc]initWithFrame:CGRectMake(0, self.shopView.bottom+10, SCREEN_WIDTH, 67)];
    self.timeView.timeStr = [NSString stringWithFormat:@"%@ 至 %@",self.detailModel.validStartDate,self.detailModel.validEndDate];
    [self.scrollView addSubview:self.timeView];
    
    self.middleView = [[WPTicketMiddleView alloc]initWithFrame:CGRectMake(0, self.timeView.bottom+10, SCREEN_WIDTH, 100)];
    [self.middleView LoadContent:self.detailModel.intro];
    [self.scrollView addSubview:self.middleView];
    
    self.ruleView = [[WPTicketRuleView alloc]initWithFrame:CGRectMake(0, self.middleView.bottom+10, SCREEN_WIDTH, 90)];
    [self.scrollView addSubview:self.ruleView];
    
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.ruleView.bottom+10);
    
}

- (void)RequestHttp{
    [self showLoading:YES];
    NSString *url = @"/u/orderDetail";
    NSMutableDictionary *parametersDict = [[NSMutableDictionary alloc]init];
    [parametersDict setObject:[NSString stringWithFormat:@"%d",self.orderModel.id] forKey:@"userOrderId"];
    //
    [RequestManeger POST:url parameters:parametersDict complete:processComplete(^(AFHTTPRequestOperation *      operation, id responseObject, NSString *msg) {
        [self hideLoading:YES];
        int code = [responseObject[@"code"] intValue];
        if (code == 0) {
            self.detailModel = [WPOrderDetailModel objectWithKeyValues:responseObject[@"data"]];
            [self ReloadUI];
        }
        /*
         data =     {
         activityName = wsxing;
         couponBalance = 10;
         couponNo = 10000;
         couponStatus = 0;
         expire = 1;
         id = 1;
         img = "http://api.life.wobendi.cn/res/2015/07/15/f0b39697-2084-4ba2-b635-3794c953a3f4.png";
         intro = "<null>";
         rules = "<null>";
         storeAddr = "\U676d\U5dde";
         storeImg = "http://api.life.wobendi.cn/res/2015/04/14/a35d22ba-9242-4d2d-9ed9-051385e94657.jpeg";
         storeName = "\U5929\U732b";
         storePhone = 12345678901;
         storeUrl = "<null>";
         userId = 1516607202800;
         validEndDate = "2015-08-18";
         validStartDate = "2015-07-14";
         };
         */
        [self showHint:msg hide:1];
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
    return @"订单详情";
}

@end
