//
//  WPLLSucceedCtrl.m
//  woPass
//
//  Created by 王蕾 on 15/8/3.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPLLSucceedCtrl.h"

@implementation WPLLSucceedCtrl
{
    UILabel *name;
    UILabel *price;
    NSString *nameStr;
    NSString *paiceStr;
}


- (id)initWithNavigatorURL:(NSURL *)URL query:(NSDictionary *)query {
    
    if (self =[super initWithNavigatorURL:URL query:query]) {
        nameStr = query[@"name"];
        paiceStr = query[@"price"];
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
        
        UILabel *sLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, i*45, SCREEN_WIDTH-120, 45)];
        sLabel.backgroundColor = [UIColor clearColor];
        sLabel.text = i==0?nameStr:paiceStr;
        sLabel.textColor = RGBCOLOR_HEX(kLabelDarkColor);
        sLabel.font = [UIFont systemFontOfSize:16];
        [back addSubview:sLabel];
        i==0?(name=sLabel):(price=sLabel);
    }
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(85, back.bottom+20, SCREEN_WIDTH-170, 35);
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 2;
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = RGBCOLOR_HEX(kLabelWeakColor).CGColor;
    [btn setTitle:@"返回首页" forState:UIControlStateNormal];
    [btn setTitleColor:RGBCOLOR_HEX(kLabelWeakColor) forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(GoHome) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
- (void)GoHome{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
