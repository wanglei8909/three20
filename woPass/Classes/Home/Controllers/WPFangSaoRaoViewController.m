//
//  WPFangSaoRaoViewController.m
//  woPass
//
//  Created by 王蕾 on 16/2/25.
//  Copyright © 2016年 unisk. All rights reserved.
//

#import "WPFangSaoRaoViewController.h"
#import "WPFangSaoRaoNavigation.h"
#import "NIAttributedLabel.h"

@interface WPFangSaoRaoViewController ()

@property (nonatomic, assign)BOOL hasOpen;
@property (nonatomic, retain)WPFangSaoRaoNavigation *navigation;
@property (nonatomic, retain)UIView *hasOpenView;
@property (nonatomic, retain)UITextField *phoneField;
@end

@implementation WPFangSaoRaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _hasOpen = YES;
    
    [self configUI];
    
}
- (void)configUI{
    
    weaklySelf();
    _navigation = [[WPFangSaoRaoNavigation alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 373)];
    _navigation.backBlock = ^{
        [weakSelf dismiss];
    };
    [self.view addSubview:_navigation];
    
    _hasOpenView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    _hasOpenView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_hasOpenView];
    
    [self configHasOpenView];
    
}
- (void)configHasOpenView{
    UIButton *chengjiuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    chengjiuBtn.backgroundColor = [UIColor clearColor];
    chengjiuBtn.frame = CGRectMake(SCREEN_WIDTH-90, 0, 90, 30);
    [chengjiuBtn addTarget:self action:@selector(chengjiuBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_hasOpenView addSubview:chengjiuBtn];
    
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jiangbei"]];
    image.frame = CGRectMake(0, 0, 12, 13.5);
    image.centerY = chengjiuBtn.height/2;
    [chengjiuBtn addSubview:image];
    
    NIAttributedLabel *label = [[NIAttributedLabel alloc]initWithFrame:CGRectMake(14, 0, 70, 14)];
    label.font = [UIFont systemFontOfSize:14];
    label.centerY = image.centerY;
    label.text = @"我的成就";
    label.textColor = [UIColor colorWithRed:244/255.f green:193/255.f blue:36/255.f alpha:1];
    [chengjiuBtn addSubview:label];
    
    UIImageView *bigImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 78*1.5, 93*1.5)];
    bigImage.image = [UIImage imageNamed:@"fsrkaitong"];
    bigImage.center = CGPointMake(SCREEN_WIDTH*0.5, 90);
    [_hasOpenView addSubview:bigImage];
    
    UIView *fieldBack = [[UIView alloc]initWithFrame:CGRectMake(20, 373-84-55, SCREEN_WIDTH-20-82, 45)];
    fieldBack.backgroundColor = [UIColor whiteColor];
    fieldBack.layer.cornerRadius = 5;
    fieldBack.layer.masksToBounds = YES;
    [_hasOpenView addSubview:fieldBack];
    
    _phoneField = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20-82-15, 45)];
    _phoneField.backgroundColor = [UIColor whiteColor];
    _phoneField.layer.cornerRadius = 5;
    _phoneField.layer.masksToBounds = YES;
    _phoneField.placeholder = @" 请输入手机号码";
    [fieldBack addSubview:_phoneField];
    
    UILabel *tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, fieldBack.top-23, 90, 20)];
    tipLabel.textColor = [UIColor whiteColor];
    tipLabel.font = [UIFont systemFontOfSize:15];
    tipLabel.text = @"标记陌生号码";
    [_hasOpenView addSubview:tipLabel];
    
    tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, fieldBack.top-23, 160, 20)];
    tipLabel.textColor = [UIColor whiteColor];
    tipLabel.font = [UIFont systemFontOfSize:12];
    tipLabel.text = @"(可查询归属地和标记信息)";
    [_hasOpenView addSubview:tipLabel];
    
    UIButton *checkBut = [UIButton buttonWithType:UIButtonTypeCustom];
    checkBut.frame = CGRectMake(fieldBack.right+8, fieldBack.top+2.5, 60, 40);
    checkBut.backgroundColor = [UIColor colorWithRed:252/255.f green:166/255.f blue:41/255.f alpha:1];
    [checkBut setTitle:@"查询" forState:UIControlStateNormal];
    [checkBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    checkBut.layer.masksToBounds = YES;
    checkBut.layer.cornerRadius = 5;
    [checkBut addTarget:self action:@selector(checkButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_hasOpenView addSubview:checkBut];
    
    UIView *openRecognizeView = [[UIView alloc]initWithFrame:CGRectMake(0, 373-64, SCREEN_WIDTH, 50)];
    openRecognizeView.backgroundColor = [UIColor whiteColor];
    openRecognizeView.userInteractionEnabled = YES;
    [_hasOpenView addSubview:openRecognizeView];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
    line.backgroundColor = RGBCOLOR_HEX(kMargineColor);
    [openRecognizeView addSubview:line];
    
    UIImageView *openRecognizeImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 7.5, 35, 35)];
    openRecognizeImage.image = [UIImage imageNamed:@"fangshaoraosaorao"];
    [openRecognizeView addSubview:openRecognizeImage];
    
    tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, 160, 50)];
    tipLabel.textColor = RGBCOLOR_HEX(kLabelDarkColor);
    tipLabel.font = [UIFont systemFontOfSize:17];
    tipLabel.text = @"开启骚扰识别";
    [openRecognizeView addSubview:tipLabel];
    
    openRecognizeImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-25, 17.5, 9, 15)];
    openRecognizeImage.image = [UIImage imageNamed:@"fangsaoraojiantou2"];
    [openRecognizeView addSubview:openRecognizeImage];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openRecognize)];
    [openRecognizeView addGestureRecognizer:tap];
    
    tipLabel= [[UILabel alloc]initWithFrame:CGRectMake(20, openRecognizeView.bottom, 200, 50)];
    tipLabel.textColor = RGBCOLOR_HEX(kLabelDarkColor);
    tipLabel.font = [UIFont systemFontOfSize:17];
    tipLabel.text = @"如何开通防骚扰提醒？";
    [_hasOpenView addSubview:tipLabel];
    
    NIAttributedLabel *tlabel = [[NIAttributedLabel alloc]initWithFrame:CGRectMake(20, tipLabel.bottom-10, SCREEN_WIDTH-40, 100)];
    tlabel.font = [UIFont systemFontOfSize:13];
    tlabel.text = @"为了尽可能的压缩号码库大小，我们只下发经过云端分析最近24小时最有可能骚扰您的电话（不一定是被标记最多的哦），建议您每月更新确保比较高的识别率，另外，您手动标记的号码将100%被识别出来。";
    tlabel.textColor = RGBCOLOR_HEX(kLabelWeakColor);
    tlabel.numberOfLines = 0;
    tlabel.lineHeight = 21;
    [_hasOpenView addSubview:tlabel];
}
- (void)chengjiuBtnClick{
    [@"WP://WPSaoRaoChengJiuViewController"  open];
}
- (void)openRecognize{
    [@"WP://WPSaoraoSettingViewController" open];
}
- (void)checkButtonClick{
    [@"WP://WPSaoRaoResultViewController" openWithQuery:@{
                                                          @"phoneNum":_phoneField.text
                                                          }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (BOOL)hideNavigationBar
{
    return YES;
}

- (BOOL)hasYDNavigationBar
{
    return NO;
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
