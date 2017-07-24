//
//  WPDetermineLogoffViewController.m
//  woPass
//
//  Created by 王蕾 on 16/2/15.
//  Copyright © 2016年 unisk. All rights reserved.
//

#import "WPDetermineLogoffViewController.h"
#import "NIAttributedLabel.h"
#import "WPURLManager.h"
#import "XNavigationController.h"
#import "RDVTabBarController.h"

@interface WPDetermineLogoffViewController ()

@end

@implementation WPDetermineLogoffViewController
{
    UIButton *checkBox;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH, 160)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    for (int i = 0; i<2; i++) {
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, i*(backView.height-1), backView.width, 1)];
        line.backgroundColor = RGBCOLOR_HEX(kMargineColor);
        [backView addSubview:line];
    }
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(15, (backView.height-50), backView.width-30, 1)];
    line.backgroundColor = RGBCOLOR_HEX(kMargineColor);
    [backView addSubview:line];
    
    NSArray *textArray = @[@"注销后，将放弃以下资产或权益：",@"∙个人身份信息、帐号信息将被清空且无法恢复。",@"∙应用授权信息将被清空，并解除绑定。"];
    for (int i = 0; i<3; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, i*(90/3)+10, backView.width-30, 90/3)];
        label.font = [UIFont systemFontOfSize:kFontLarge];
        label.textColor = RGBCOLOR_HEX(kLabelDarkColor);
        [backView addSubview:label];
        label.text = textArray[i];
        [backView addSubview:label];
    }
    
    NIAttributedLabel *label = [[NIAttributedLabel alloc]initWithFrame:CGRectMake(30, 128, 300, 13)];
    label.text = @"同意《沃通行证帐号注销协议》";
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = RGBCOLOR_HEX(kLabelDarkColor);
    [label setTextColor:[UIColor colorWithRed:68/255.f green:113/255.f blue:183/255.f alpha:1] range:NSMakeRange(2, 11)];
    [backView addSubview:label];
    
    checkBox = [UIButton buttonWithType:UIButtonTypeCustom];
    checkBox.frame = CGRectMake(label.left-15-5, label.top+1.5-5, 20, 20);
    [checkBox setImage:[UIImage imageNamed:@"weizhongcheckbox"] forState:UIControlStateSelected];
    [checkBox setImage:[UIImage imageNamed:@"zhongcheckbox"] forState:UIControlStateNormal];
    checkBox.selected = YES;
    [checkBox addTarget:self action:@selector(checkBoxClick) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:checkBox];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(label.left+70, label.top, label.width-70, label.height);
    btn.backgroundColor = [UIColor clearColor];
    [btn addTarget:self action:@selector(ShowTips) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:btn];
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.layer.masksToBounds = YES;
    saveBtn.layer.cornerRadius = 3;
    saveBtn.frame = CGRectMake(15, backView.bottom+20, SCREEN_WIDTH-30, 45);
    [saveBtn setTitle:@"确认注销" forState:UIControlStateNormal];
    [saveBtn setTitleColor:RGBCOLOR_HEX(0xffffff) forState:UIControlStateNormal];
    [self.view addSubview:saveBtn];
    [saveBtn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    saveBtn.backgroundColor = RGBCOLOR_HEX(KTextOrangeColor);
    
}
- (void)ShowTips{
    [WPURLManager openURLWithMainTitle:nil urlString:@"https://i.wo.cn/H5/userTerms"];
}

- (void)checkBoxClick{
    checkBox.selected = !checkBox.selected;
}


- (void)buttonClick{
    
    
    [gUser QutiLogin:^{
        XNavigationController *nCtrl = (XNavigationController *)[XNavigator navigator].window.rootViewController;
        for (UIViewController *ctrl in nCtrl.viewControllers) {
            if ([ctrl isKindOfClass:[RDVTabBarController class]] && ctrl) {
                RDVTabBarController *rCtrl = (RDVTabBarController *)ctrl;
                [rCtrl setSelectedIndex:0];
            }
        }
        [nCtrl popToRootViewControllerAnimated:NO];
    }];
    
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
    return @"注销帐号";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
