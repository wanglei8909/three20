//
//  WPFindSecurityTypeCtrl.m
//  woPass
//
//  Created by 王蕾 on 15/11/30.
//  Copyright © 2015年 unisk. All rights reserved.
//

#import "WPFindSecurityTypeCtrl.h"
#import "WPFindSecurityController.h"
#import "WPTypePhoneFindCtrl.h"
#import "WPTypeMailFindCtrl.h"
@implementation WPFindSecurityTypeCtrl

- (void)viewDidLoad{
    [super viewDidLoad];
    
    
    
    for (int i = 0; i<2; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(37, 40+i*(67+15), SCREEN_WIDTH-74, 67);
        btn.backgroundColor = [UIColor whiteColor];
        btn.layer.borderWidth = 2;
        btn.layer.borderColor = RGBCOLOR_HEX(kMargineColor).CGColor;
        btn.layer.masksToBounds =YES;
        btn.layer.cornerRadius = 5;
        btn.tag = i+100;
        [btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(i==0?15:10, i==0?15:20, i==0?25:35, i==0?40:27)];
        image.image = [UIImage imageNamed:i==0?@"shouji":@"youxiang"];
        [btn addSubview:image];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(55, 0, 300, 67)];
        label.text = i==0?@"使用手机号码找回":@"使用绑定邮箱找回";
        label.font = [UIFont systemFontOfSize:kFontLarge];
        [btn addSubview:label];
        
    }
    
}
- (void)BtnClick:(UIButton *)sender{
    if (sender.tag == 100) {
        WPTypePhoneFindCtrl *ctrl = [[WPTypePhoneFindCtrl alloc]init];
        [self.navigationController pushViewController:ctrl animated:YES];
        [BaiduMob logEvent:@"id_password" eventLabel:@"forget_message"];
    }else{
        WPTypeMailFindCtrl *ctrl = [[WPTypeMailFindCtrl alloc] init];
        [self.navigationController pushViewController:ctrl animated:YES];
        [BaiduMob logEvent:@"id_password" eventLabel:@"forget_mail"];
    }
}





- (BOOL)hideNavigationBar
{
    return NO;
}

- (BOOL)hasYDNavigationBar
{
    return NO;
}

- (BOOL)autoGenerateBackBarButtonItem
{
    return YES;
}

- (NSString *)title {
    return @"忘记密码";
}


@end
