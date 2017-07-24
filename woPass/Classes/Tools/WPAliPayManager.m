//
//  WPAliPayManager.m
//  woPass
//
//  Created by 王蕾 on 15/8/4.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPAliPayManager.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>

@implementation WPAliPayManager

+ (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand(time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}

+ (void)PayWithOrderNo:(NSString *)tradeNO withProductName:(NSString *)productName withProductDescription:(NSString *)productDescription withAmount:(NSString *)amount withCallBackUrl:(NSString *)callBackUrl andSucceedBlock:(void(^)()) succeedBlock andFaildBlock:(void(^)(NSString *faildCode)) faildBlock{
    
    callBackUrl = @"www.baidu.com";
    
    
    if (tradeNO.length==0 || productName.length == 0 || amount.length == 0) {
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"支付失败" message:@"商品信息不全" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
        return;
    }
    
    NSString *partner = PartnerID;
    NSString *seller = SellerID;
    NSString *privateKey = PartnerPrivKey;
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    
    order.tradeNO = tradeNO; //订单ID（由商家自行制定）
    order.productName = productName; //商品标题
    order.productDescription = productDescription; //商品描述
    order.amount = amount; //商品价格
    
    order.notifyURL =  callBackUrl; //回调URL ”通知商户服务端“
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"wopass";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            if ([resultDic[@"resultStatus"] intValue] == 9000) {
                succeedBlock();
            }
            else{
                faildBlock([NSString stringWithFormat:@"%@",resultDic[@"resultStatus"]]);
            }
            /*
             9000 	订单支付成功
             8000 	正在处理中
             4000 	订单支付失败
             6001 	用户中途取消
             6002 	网络连接出错*/
        }];
    }
}


@end
