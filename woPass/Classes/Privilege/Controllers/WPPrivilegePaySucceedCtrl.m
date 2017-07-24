//
//  WPPrivilegePaySucceedCtrl.m
//  woPass
//
//  Created by 王蕾 on 15/8/7.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPPrivilegePaySucceedCtrl.h"
#import "WPMyOrderListController.h"
#import "WPGoOnBuyCtrl.h"

@implementation WPPrivilegePaySucceedCtrl

{
    UILabel *name;
    UILabel *price;
}


- (id)initWithNavigatorURL:(NSURL *)URL query:(NSDictionary *)query {
    
    if (self =[super initWithNavigatorURL:URL query:query]) {
        
        
    }
    return self;
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 235, 95)];
    //chenggong  471 × 190
    image.image = [UIImage imageNamed:@"chenggong"];
    image.center = CGPointMake(self.view.centerX, 150);
    [self.view addSubview:image];
    
    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, image.bottom+20, SCREEN_WIDTH, 90)];
    back.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:back];
    
    for (int i = 0; i<3; i++) {
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, i*45, SCREEN_WIDTH, 1)];
        line.backgroundColor = RGBCOLOR_HEX(kMargineColor);
        [back addSubview:line];
    }
    
    for (int i = 0; i<2; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, i*45, 80, 45)];
        label.backgroundColor = [UIColor clearColor];
        label.text = i==0?@"商品名称：":@"价格：";
        label.textColor = RGBCOLOR_HEX(kLabelDarkColor);
        label.font = [UIFont systemFontOfSize:16];
        [back addSubview:label];
        
        UILabel *sLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, i*45, SCREEN_WIDTH-150, 45)];
        sLabel.backgroundColor = [UIColor clearColor];
        sLabel.text = i==0?_goodsName:_goodsPrice;
        sLabel.textColor = RGBCOLOR_HEX(kLabelDarkColor);
        sLabel.font = [UIFont systemFontOfSize:16];
        [back addSubview:sLabel];
        i==0?(name=sLabel):(price=sLabel);
    }
    
    
    for (int i = 0; i<2; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(15+i*((SCREEN_WIDTH-45)/2+15), back.bottom+20, (SCREEN_WIDTH-45)/2, 35);
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 2;
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = i==0?RGBCOLOR_HEX(KTextOrangeColor).CGColor:RGBCOLOR_HEX(kLabelWeakColor).CGColor;
        [btn setTitle:i==0?@"查看全部订单":@"继续逛逛" forState:UIControlStateNormal];
        [btn setTitleColor:i==0?RGBCOLOR_HEX(KTextOrangeColor):RGBCOLOR_HEX(kLabelWeakColor) forState:UIControlStateNormal];
        btn.tag = 100+i;
        [btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}
- (void)BtnClick:(UIButton *)sender{
    
    NSLog(@"----->%@",self.navigationController.viewControllers);
    if (sender.tag == 100) {
        BOOL have = NO;
        for (UIViewController *ctrl in self.navigationController.viewControllers) {
            if ([ctrl isKindOfClass:[WPMyOrderListController class]]) {
                [self.navigationController popToViewController:ctrl animated:YES];
                have = YES;
                return;
            }
        }
        if (!have) {
            WPMyOrderListController *ctrl = [[WPMyOrderListController alloc]init];
            [self.navigationController pushViewController:ctrl animated:YES];
        }
    }else{
        BOOL have = NO;
        for (UIViewController *ctrl in self.navigationController.viewControllers) {
            if ([ctrl isKindOfClass:[WPGoOnBuyCtrl class]]) {
                [self.navigationController popToViewController:ctrl animated:YES];
                have = YES;
                return;
            }
        }
        if (!have) {
            WPGoOnBuyCtrl *ctrl = [[WPGoOnBuyCtrl alloc]init];
            [self.navigationController pushViewController:ctrl animated:YES];
        }
    }
}

-(void)dismiss{
    [super dismiss];
    NSLog(@"self.tabBarController.viewControllers----->%@",self.tabBarController.viewControllers);
    NSLog(@"self.navigationController.viewControllers---->%@",self.navigationController.viewControllers);
    
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
    return @"购买成功";
}

@end
