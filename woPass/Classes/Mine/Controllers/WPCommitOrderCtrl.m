//
//  WPCommitOrderCtrl.m
//  woPass
//
//  Created by 王蕾 on 15/8/3.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPCommitOrderCtrl.h"
#import "WPSelePayTypeView.h"
#import "WPAliPayManager.h"
#import "WPPrivilegePaySucceedCtrl.h"
@implementation WPCommitOrderCtrl
{
    
    UIScrollView *scroller;
    UILabel *nameLabel;
    UILabel *perPriceLabel;    
    
    UILabel *addressLabel;
    UITextField *phoneField;
    UITextField *nameField;
    UITextField *addressField;
}

-(id)initWithNavigatorURL:(NSURL *)URL query:(NSDictionary *)query{
    self = [super initWithNavigatorURL:URL query:query];
    if (self) {
        _model = query[@"model"];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)keyboardWillShow:(NSNotification *)not{
    float b = [not.userInfo[@"UIKeyboardBoundsUserInfoKey"] CGRectValue].size.height;
    float a = SCREEN_HEIGHT-(44+20+45*8);
    if (b>a) {
        [scroller setContentOffset:CGPointMake(0, b - a+20) animated:YES];
    }
}
- (void)keyboardWillHide:(NSNotification *)not{
    [scroller setContentOffset:CGPointMake(0, -24) animated:YES];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    scroller = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 54, SCREEN_WIDTH, SCREEN_HEIGHT-54-58)];
    scroller.showsVerticalScrollIndicator = NO;
    scroller.backgroundColor = [UIColor clearColor];
    [self.view addSubview:scroller];
    
    
    NSArray *title = @[@"商品名称",@"单价",@"数量",@"总计：",@"收货地址",@"手机号",@"联系人",@"联系地址"];
    for (int i = 0; i<2; i++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, i*(4*45+10), SCREEN_WIDTH, 4*45)];
        view.backgroundColor = [UIColor whiteColor];
        [scroller addSubview:view];
        
        //line
        for (int j = 0; j<2; j++) {
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, j*4*45, SCREEN_WIDTH, 1)];
            line.backgroundColor = RGBCOLOR_HEX(kMargineColor);
            [view addSubview:line];
        }
        for (int j = 0; j<3; j++) {
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10, 45+j*45, SCREEN_WIDTH-20, 1)];
            line.backgroundColor = RGBCOLOR_HEX(kMargineColor);
            [view addSubview:line];
        }
        
        for (int j = 0; j<4; j++) {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, j*45, 100, 45)];
            label.backgroundColor = [UIColor clearColor];
            label.font = [UIFont systemFontOfSize:16];
            label.textColor = RGBCOLOR_HEX(kLabelDarkColor);
            label.text = title[i*4+j];
            [view addSubview:label];
            
            if (i*4+j==0) {
                nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-200, j*45, 180, 45)];
                nameLabel.text = self.model.title;
                nameLabel.textAlignment = NSTextAlignmentRight;
                nameLabel.textColor = RGBCOLOR_HEX(kLabelDarkColor);
                nameLabel.font = [UIFont systemFontOfSize:16];
                [view addSubview:nameLabel];
            }else if (i*4+j==1){
                perPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-200, j*45, 180, 45)];
                perPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",self.model.price];
                perPriceLabel.textColor = RGBCOLOR_HEX(KTextOrangeColor);
                perPriceLabel.font = [UIFont systemFontOfSize:16];
                perPriceLabel.textAlignment = NSTextAlignmentRight;
                [view addSubview:perPriceLabel];
            }else if (i*4+j==2) {
                weaklySelf();
                _numStepper = [[WPStepper alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-20-85, j*45+10, 85, 25)];
                _numStepper.value = 1;
                if (self.model.maxNum>1) {
                    _numStepper.maxValue = self.model.maxNum;
                }
                _numStepper.changeBlock = ^(WPStepper *stepper){
                    weakSelf.totalPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",self.model.price * stepper.value];
                };
                [view addSubview:_numStepper];
            }
            else if (i*4+j==3){
                label.textAlignment = NSTextAlignmentRight;
                label.right = SCREEN_WIDTH-90;
                
                _totalPriceLabel = [[NIAttributedLabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-90, j*45+14, 70, 45)];
                _totalPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",self.model.price];
                _totalPriceLabel.textColor = RGBCOLOR_HEX(KTextOrangeColor);
                _totalPriceLabel.font = [UIFont systemFontOfSize:16];
                _totalPriceLabel.textAlignment = NSTextAlignmentRight;
                [view addSubview:_totalPriceLabel];
            }
            else if (i*4+j==4){
                
            }
            else if (i*4+j==5){
                phoneField = [[UITextField alloc]initWithFrame:CGRectMake(100, j*45, SCREEN_WIDTH-120, 45)];
                phoneField.placeholder = @"请输入手机号";
                phoneField.text = gUser.mobile;
                phoneField.textColor = RGBCOLOR_HEX(kLabelDarkColor);
                phoneField.font = [UIFont systemFontOfSize:16];
                phoneField.textAlignment = NSTextAlignmentLeft;
                phoneField.delegate = self;
                phoneField.returnKeyType= UIReturnKeyDone;
                [view addSubview:phoneField];
            }
            else if (i*4+j==6){
                nameField = [[UITextField alloc]initWithFrame:CGRectMake(100, j*45, SCREEN_WIDTH-120, 45)];
                nameField.placeholder = @"请输入联系人姓名";
                nameField.textColor = RGBCOLOR_HEX(kLabelDarkColor);
                nameField.font = [UIFont systemFontOfSize:16];
                nameField.textAlignment = NSTextAlignmentLeft;
                nameField.returnKeyType= UIReturnKeyDone;
                nameField.delegate = self;
                [view addSubview:nameField];
            }
            else if (i*4+j==7){
                addressField = [[UITextField alloc]initWithFrame:CGRectMake(100, j*45, SCREEN_WIDTH-120, 45)];
                addressField.placeholder = @"请输入收货地址";
                addressField.textColor = RGBCOLOR_HEX(kLabelDarkColor);
                addressField.font = [UIFont systemFontOfSize:16];
                addressField.textAlignment = NSTextAlignmentLeft;
                addressField.delegate = self;
                addressField.returnKeyType= UIReturnKeyDone;
                [view addSubview:addressField];
            }
        }
    }
    
    UIView *bottom = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.bottom-58, self.view.width, 58)];
    bottom.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottom];
    
    UIButton *buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    buyBtn.frame = CGRectMake(15, 10, bottom.width-30, 38);
    buyBtn.backgroundColor = RGBCOLOR_HEX(KTextOrangeColor);
    [buyBtn setTitle:@"提交订单" forState:UIControlStateNormal];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buyBtn addTarget:self action:@selector(BuyClick) forControlEvents:UIControlEventTouchUpInside];
    [bottom addSubview:buyBtn];
}
- (void)BuyClick{
    [BaiduMob logEvent:@"id_activity" eventLabel:@"submitorders"];
    if (nameField.text.length == 0 || addressField.text.length == 0) {
        [self showHint:@"请输入姓名和地址" hide:1.5];
        return;
    }
    
    // /u/submitOrder
    [self showLoading:YES];
    
    /*
     activityId 	int 	活动ID
     num            int 	购买数量
     contactMan 	srring 	联系人姓名
     contactPhone 	srring 	联系人电话
     contactAddr 	srring 	联系人地址
     */
    
    NSString *url = @"/u/submitOrder";
    NSMutableDictionary *parametersDict = [[NSMutableDictionary alloc]init];
    [parametersDict setObject:[NSString stringWithFormat:@"%d",self.model.id] forKey:@"goodsId"];
    [parametersDict setObject:[NSString stringWithFormat:@"%d",_numStepper.value] forKey:@"num"];
    [parametersDict setObject:nameField.text forKey:@"contactMan"];
    [parametersDict setObject:phoneField.text forKey:@"contactPhone"];
    [parametersDict setObject:addressField.text forKey:@"contactAddr"];
    
    [RequestManeger POST:url parameters:parametersDict complete:processComplete(^(AFHTTPRequestOperation *      operation, id responseObject, NSString *msg) {
        [self hideLoading:YES];
        int code = [responseObject[@"code"] intValue];
        if (code == 0) {
            [self GoPay:[NSString stringWithFormat:@"%@",responseObject[@"data"][@"userOrderId"]]];
        }else{
            [self showHint:msg hide:2];
        }
    })];
}

- (void)CheckOrder : (NSInteger) index :(NSString *)orderId{
    //u/payOrder
    NSString *url = @"/u/payOrder";
    NSMutableDictionary *parametersDict = [[NSMutableDictionary alloc]init];
    [parametersDict setObject:orderId forKey:@"userOrderId"];
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
                [self GoAliPay:orderId :responseObject[@"data"][@"payCallbackUrl"]];
            }
            
        }else{
            [self showHint:responseObject[@"msg"] hide:2];
        }
        
    })];
}
- (void)GoAliPay:(NSString *)orderId :(NSString *)callBakcUrl{
    weaklySelf();
    [WPAliPayManager PayWithOrderNo:orderId withProductName:weakSelf.model.title withProductDescription:weakSelf.model.intro withAmount:[weakSelf.totalPriceLabel.text substringFromIndex:1] withCallBackUrl:callBakcUrl andSucceedBlock:^{
        WPPrivilegePaySucceedCtrl *ctrl = [[WPPrivilegePaySucceedCtrl alloc]init];
        ctrl.goodsName = weakSelf.model.title;
        ctrl.goodsPrice = weakSelf.totalPriceLabel.text;
        [self.navigationController pushViewController:ctrl animated:YES];
        [weakSelf hideLoading:YES];
        [BaiduMob logEvent:@"id_activity" eventLabel:@"paysuccess"];
    }andFaildBlock:^(NSString *code){
        [weakSelf hideLoading:YES];
    }];
}

- (void)GoPay :(NSString *)orderId{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    WPSelePayTypeView *payTypeView = [[WPSelePayTypeView alloc]initWithFrame:window.bounds];
    payTypeView.mBlock = ^(NSInteger index){
        [BaiduMob logEvent:@"id_activity" eventLabel:@"choosepay"];
        [self showLoading:YES];
        if (index == 1) {//支付宝
            [self CheckOrder:index :orderId];
        }else if (index == 2){//微信
            [self CheckOrder:index :orderId];
        }
    };
    [window addSubview:payTypeView];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField endEditing:YES];
    return NO;
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
    return @"提交订单";
}
@end
