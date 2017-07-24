//
//  WPPrivileGetTicketSucceedCtrl.m
//  woPass
//
//  Created by 王蕾 on 15/8/7.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPPrivileGetTicketSucceedCtrl.h"
#import "WPMyTickettViewController.h"
#import "WPTiketController.h"

@implementation WPPrivileGetTicketSucceedCtrl

{
    UILabel *name;
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
    image.image = [UIImage imageNamed:@"iconfont-youhuiquan-6"];
    image.center = CGPointMake(self.view.centerX, 150);
    [self.view addSubview:image];
    
    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, image.bottom+20, SCREEN_WIDTH, 45)];
    back.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:back];
    
    for (int i = 0; i<2; i++) {
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, i*45, SCREEN_WIDTH, 1)];
        line.backgroundColor = RGBCOLOR_HEX(kMargineColor);
        [back addSubview:line];
    }
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, 45)];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"优惠券名称：";
    label.textColor = RGBCOLOR_HEX(kLabelDarkColor);
    label.font = [UIFont systemFontOfSize:16];
    [back addSubview:label];
    
    name = [[UILabel alloc]initWithFrame:CGRectMake(120, 0, SCREEN_WIDTH-150, 45)];
    name.backgroundColor = [UIColor clearColor];
    name.text = _tName;
    name.textColor = RGBCOLOR_HEX(kLabelDarkColor);
    name.font = [UIFont systemFontOfSize:16];
    [back addSubview:name];
    
    
    for (int i = 0; i<2; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(15+i*((SCREEN_WIDTH-45)/2+15), back.bottom+20, (SCREEN_WIDTH-45)/2, 35);
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 2;
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = i==0?RGBCOLOR_HEX(KTextOrangeColor).CGColor:RGBCOLOR_HEX(kLabelWeakColor).CGColor;
        [btn setTitle:i==0?@"查看全部优惠券":@"继续逛逛" forState:UIControlStateNormal];
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
            if ([ctrl isKindOfClass:[WPMyTickettViewController class]]) {
                [self.navigationController popToViewController:ctrl animated:YES];
                have = YES;
                return;
            }
        }
        if (!have) {
            WPMyTickettViewController *ctrl = [[WPMyTickettViewController alloc]init];
            [self.navigationController pushViewController:ctrl animated:YES];
        }
    }else{
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
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
