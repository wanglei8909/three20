//
//  WPBuyLLController.m
//  woPass
//
//  Created by 王蕾 on 15/7/31.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPBuyLLController.h"
#import "WPBuyLLField.h"
#import "WPOnlyUnicom.h"
#import "WPNoGoods.h"
#import "WPSelePayTypeView.h"
#import "WPLLSucceedCtrl.h"
#import "WPLLProductModel.h"
#import "WPLLCell.h"
#import "WPUnionAreaView.h"
#import "WPAliPayManager.h"

@interface WPBuyLLController ()
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) WPBuyLLField *numField;
@property (nonatomic, strong) WPOnlyUnicom *onlyUnicom;
@property (nonatomic, strong) WPNoGoods *noGoods;
@property (nonatomic, strong) WPSelePayTypeView *payTypeView;
@property (nonatomic, strong) WPUnionAreaView *areaView;
@property (nonatomic, strong) WPLLProductModel *chooseModel;

@end

@implementation WPBuyLLController

- (void)RequestToHttp{
    _onlyUnicom.hidden = YES;
    [self showLoading:YES];
    [_dataArray removeAllObjects];
    [_table reloadData];
    NSString *url = @"/life/flowProducts";
    NSMutableDictionary *parametersDict = [[NSMutableDictionary alloc]init];
    [parametersDict setObject:[NSString stringWithFormat:@"%@",_numField.text] forKey:@"mobile"];
    
    [RequestManeger POST:url parameters:parametersDict complete:processComplete(^(AFHTTPRequestOperation *      operation, id responseObject, NSString *msg) {
        
        int code = [responseObject[@"code"] intValue];
        if (code==0) {
            NSArray *all = responseObject[@"data"][@"products"];
            if (all && [all isKindOfClass:[NSArray class]]) {
                for (int i = 0; i<all.count; i++) {
                    NSDictionary *llDict = all[i];
                    WPLLProductModel *model = [WPLLProductModel objectWithKeyValues:llDict];
                    [model setDes:llDict[@"description"]];
                    if (i==0) {
                        [model setSelected:YES];
                        _chooseModel = model;
                    }else{
                        [model setSelected:NO];
                    }
                    [_dataArray addObject:model];
                }
                
            }
            [_table reloadData];
            if (_dataArray.count > 0) {
                _noGoods.hidden = YES;
            }else{
                _noGoods.hidden = NO;
            }
            
            NSString *area = responseObject[@"data"][@"province"];
            if (area && [area isKindOfClass:[NSString class]] && area.length>0) {
                _areaView.hidden = NO;
                [_areaView setAreaString:area];
            }else{
                _areaView.hidden = YES;
            }
        }
        else{
            _noGoods.hidden = NO;
            _areaView.hidden = YES;
        }
        [self hideLoading:YES];
        
    })];
}
- (BOOL)isUniPhone:(NSString *)phone{
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",UniPhoneRegex];
    if ([phoneTest evaluateWithObject:phone]) {
        return YES;
    }
    return NO;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    if (![phoneTest evaluateWithObject:textField.text]) {
        [self showHint:@"请输入正确手机号" hide:1];
        [_dataArray removeAllObjects];
        [_table reloadData];
        return NO;
    }
    
    if (![self isUniPhone:textField.text]) {
        _onlyUnicom.hidden = NO;
        _areaView.hidden = YES;
        [_dataArray removeAllObjects];
        [_table reloadData];
        return NO;
    }
    
    _onlyUnicom.hidden = YES;
    
    [self RequestToHttp];
    [textField endEditing:YES];
    return NO;
}

- (UIView *)GetHeaderView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 115)];
    view.backgroundColor = [UIColor clearColor];
    
    UIView *fieldBack = [[UIView alloc]initWithFrame:CGRectMake(20, 20, SCREEN_WIDTH-40, 45)];
    fieldBack.backgroundColor = [UIColor whiteColor];
    fieldBack.layer.borderWidth = 1;
    fieldBack.layer.borderColor = RGBCOLOR_HEX(kMargineColor).CGColor;
    fieldBack.layer.masksToBounds = YES;
    fieldBack.layer.cornerRadius = 3;
    [view addSubview:fieldBack];
    
    _numField = [[WPBuyLLField alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-80, 45)];
    _numField.backgroundColor = [UIColor whiteColor];
    _numField.placeholder = @"请输入或选择联通手机号码";
    _numField.delegate = self;
    _numField.returnKeyType = UIReturnKeyDone;
    [_numField drawPlaceholderInRect:_numField.bounds];
    [fieldBack addSubview:_numField];
    
    UIButton *addressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addressBtn.frame = CGRectMake(fieldBack.right-60, 0, 40, 45) ;
    [addressBtn setImage:[UIImage imageNamed:@"iconfont-tongxunlu-2"] forState:UIControlStateNormal];
    [addressBtn addTarget:self action:@selector(ToAddressBook) forControlEvents:UIControlEventTouchUpInside ];
    [fieldBack addSubview:addressBtn];
    
    _onlyUnicom = [[WPOnlyUnicom alloc]initWithFrame:CGRectMake(fieldBack.left, fieldBack.bottom+5, _numField.width, 14)];
    _onlyUnicom.hidden = YES;
    [view addSubview:_onlyUnicom];
    
    _areaView = [[WPUnionAreaView alloc]init];
    _areaView.hidden = YES;
    [view addSubview:_areaView];
    
    return view;
}
-(void)viewDidLoad{
    [super viewDidLoad];
    
    [BaiduMob logEvent:@"id_unicom_ability" eventLabel:@"trafficbuy"];
    
    _dataArray= [[NSMutableArray alloc]initWithCapacity:10];
    
    [self InitPicker];
    
    _noGoods = [[WPNoGoods alloc]initWithFrame:CGRectMake(0, 220, SCREEN_WIDTH, 200)];
    _noGoods.hidden = YES;
    [self.view addSubview:_noGoods];
    
    _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height-122) style:UITableViewStylePlain];
    _table.showsVerticalScrollIndicator = NO;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.backgroundColor = [UIColor clearColor];
    _table.tableHeaderView = [self GetHeaderView];
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
    
    UIView *bottom = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.bottom-58, self.view.width, 58)];
    bottom.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottom];
    
    UIButton *buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    buyBtn.frame = CGRectMake(15, 10, bottom.width-30, 38);
    buyBtn.backgroundColor = RGBCOLOR_HEX(KTextOrangeColor);
    [buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buyBtn addTarget:self action:@selector(BuyClick) forControlEvents:UIControlEventTouchUpInside];
    [bottom addSubview:buyBtn];
}

- (void)BuyClick{
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",UniPhoneRegex];
    
    if (![phoneTest evaluateWithObject:_numField.text]) {
        [self showHint:@"请输入正确手机号" hide:1];
        [_dataArray removeAllObjects];
        [_table reloadData];
        return ;
    }
    
    if (![self isUniPhone:_numField.text]) {
        _onlyUnicom.hidden = NO;
        _areaView.hidden = YES;
        [_dataArray removeAllObjects];
        [_table reloadData];
        return ;
    }
    if (!_chooseModel || _dataArray.count==0) {
        [self showHint:@"请选择商品" hide:1];
        return;
    }
    [self showLoading:YES];
    //提交订单
    NSString *url = @"/u/submitOrder";
    NSMutableDictionary *parametersDict = [[NSMutableDictionary alloc]init];
    
    [parametersDict setObject:@"2" forKey:@"goodsType"];
    [parametersDict setObject:[NSString stringWithFormat:@"%d",_chooseModel.productId] forKey:@"goodsId"];
    [parametersDict setObject:@"1" forKey:@"num"];
    [parametersDict setObject:_numField.text forKey:@"mobile"];
    
    
    [RequestManeger POST:url parameters:parametersDict complete:processComplete(^(AFHTTPRequestOperation *      operation, id responseObject, NSString *msg) {
        [self hideLoading:YES];
        int code = [responseObject[@"code"] intValue];
        int userOrderId = [responseObject[@"data"][@"userOrderId"] intValue];
        if (code == 0 && userOrderId>0) {
            [self GoPay:[NSString stringWithFormat:@"%@",responseObject[@"data"][@"userOrderId"]]];
        }else{
            [self showHint:msg hide:2];
        }
    })];
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
    [WPAliPayManager PayWithOrderNo:orderId withProductName:weakSelf.chooseModel.productName withProductDescription:weakSelf.chooseModel.des withAmount:[weakSelf.chooseModel.current_price substringFromIndex:1] withCallBackUrl:callBakcUrl andSucceedBlock:^{
        [weakSelf hideLoading:YES];
        [@"WP://WPLLSucceedCtrl" openWithQuery:@{@"name":weakSelf.chooseModel.productName,
                                                 @"price":weakSelf.chooseModel.current_price} animated:YES];
    }andFaildBlock:^(NSString *code){
        [weakSelf hideLoading:YES];
    }];
}

#pragma -mark ABPeoplePickerNavigationControllerDelegate
- (void)InitPicker{
    _picker = [[ABPeoplePickerNavigationController alloc] init];
    _picker.peoplePickerDelegate = self;
}
- (void)ToAddressBook{
    [self presentViewController:_picker animated:YES completion:nil];
}

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person{
    NSLog(@"didSelectPerson--->%@",person);
    [self displayPerson:person];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)peoplePickerNavigationControllerDidCancel:
(ABPeoplePickerNavigationController *)peoplePicker
{
    NSLog(@"peoplePickerNavigationControllerDidCancel");
}


- (BOOL)peoplePickerNavigationController:
(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person {
    NSLog(@"shouldContinueAfterSelectingPerson");
    [self displayPerson:person];
    [self dismissViewControllerAnimated:YES completion:nil];
    return NO;
}



- (void)displayPerson:(ABRecordRef)person
{
    //NSString* name = (__bridge_transfer NSString*)ABRecordCopyValue(person,kABPersonFirstNameProperty);
    //numField.text = name;
    
    NSString* phone = nil;
    ABMultiValueRef phoneNumbers = ABRecordCopyValue(person,
                                                     kABPersonPhoneProperty);
    if (ABMultiValueGetCount(phoneNumbers) > 0) {
        phone = (__bridge_transfer NSString*)
        ABMultiValueCopyValueAtIndex(phoneNumbers, 0);
    } else {
        phone = @"";
    }

    phone = [phone stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    _numField.text = phone;
    CFRelease(phoneNumbers);
    [_dataArray removeAllObjects];
    [_table reloadData];
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",UniPhoneRegex];
    
    if (![phoneTest evaluateWithObject:phone]) {
        [self showHint:@"请输入正确手机号" hide:1];
        [_dataArray removeAllObjects];
        [_table reloadData];
        return ;
    }
    
    if (![self isUniPhone:phone]) {
        _onlyUnicom.hidden = NO;
        _areaView.hidden = YES;
        [_dataArray removeAllObjects];
        [_table reloadData];
        return ;
    }
    
    _onlyUnicom.hidden = YES;
    
    [self RequestToHttp];
}

#pragma -mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"WPLLCell";
    WPLLCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[WPLLCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.model = _dataArray[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 79;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _chooseModel.selected = NO;
    _chooseModel = _dataArray[indexPath.row];
    _chooseModel.selected = YES;
    [tableView reloadData];
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
    return @"流量办理";
}

@end
