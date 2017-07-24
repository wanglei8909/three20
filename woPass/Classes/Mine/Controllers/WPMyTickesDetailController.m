//
//  WPMyTickesDetailController.m
//  woPass
//
//  Created by 王蕾 on 15/7/24.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPMyTickesDetailController.h"

@implementation WPMyTickesDetailController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, SCREEN_HEIGHT-60)];
    self.scrollView.backgroundColor = RGBCOLOR_HEX(kBackgroundColor);
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.scrollEnabled = YES;
    [self.view addSubview:self.scrollView];
    
    self.topView = [[WPTicketDetailTopView alloc]init];
    self.topView.model = self.ticketModel;
    [self.scrollView addSubview:self.topView];
    
    self.middleView = [[WPTicketMiddleView alloc]initWithFrame:CGRectMake(0, self.topView.bottom, SCREEN_WIDTH, 0)];
    [self.scrollView addSubview:self.middleView];
    
    [self RequestHttp];
}
- (void)ReloadUI{
    [self.middleView LoadContent:self.detailModel.intro];
    
    self.ruleView = [[WPTicketRuleView alloc]initWithFrame:CGRectMake(0, self.middleView.bottom+10, SCREEN_WIDTH, 90)];
    [self.scrollView addSubview:self.ruleView];
    
    self.shopView = [[WPShopsInfoView alloc]initWithFrame:CGRectMake(0, self.ruleView.bottom+10, SCREEN_WIDTH, 97)];
    self.shopView.nameStr = self.detailModel.storeName;
    self.shopView.addressStr = self.detailModel.storeAddr;
    self.shopView.iconUrl = self.detailModel.storeImg;
    self.shopView.phoneNum = self.detailModel.storePhone;
    [self.scrollView addSubview:self.shopView];
    
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.shopView.bottom+10);
}

- (void)RequestHttp{
    [self showLoading:YES];
    NSString *url = @"/u/couponDetail";
    NSMutableDictionary *parametersDict = [[NSMutableDictionary alloc]init];
    [parametersDict setObject:[NSString stringWithFormat:@"%d",self.ticketModel.id] forKey:@"userCouponId"];
    //
    [RequestManeger POST:url parameters:parametersDict complete:processComplete(^(AFHTTPRequestOperation *      operation, id responseObject, NSString *msg) {
        [self hideLoading:YES];
        int code = [responseObject[@"code"] intValue];
        if (code == 0) {
            self.detailModel = [WPTicketDetailModel objectWithKeyValues:responseObject[@"data"]];
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
    return @"优惠券详情";
}


@end
