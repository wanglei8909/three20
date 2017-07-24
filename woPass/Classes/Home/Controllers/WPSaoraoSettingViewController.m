//
//  WPSaoraoSettingViewController.m
//  woPass
//
//  Created by 王蕾 on 16/2/26.
//  Copyright © 2016年 unisk. All rights reserved.
//

#import "WPSaoraoSettingViewController.h"
#import "WPFangSaoRaoNavigation.h"
#import "NIAttributedLabel.h"
#import "WPUMShareManeger.h"

@interface WPSaoraoSettingViewController ()

@property (nonatomic, strong)UILabel *tipLabel;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UIButton *openButton;
@property (nonatomic, strong)UIImageView *image;
@property (nonatomic, assign)BOOL hasOpen;

@end

@implementation WPSaoraoSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    weaklySelf();
    WPFangSaoRaoNavigation *navigation = [[WPFangSaoRaoNavigation alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 294)];
    navigation.iTitle = @"防骚扰设置";
    navigation.backBlock = ^{
        [weakSelf dismiss];
    };
    [self.view addSubview:navigation];
    
    _image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 95, 95)];
    _image.image = [UIImage imageNamed:@"saoraoweikaitong"];
    _image.center = CGPointMake(SCREEN_WIDTH*0.5, 64+80);
    [navigation addSubview:_image];
    
    _tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _image.bottom+10, SCREEN_WIDTH, 30)];
    _tipLabel.textAlignment = NSTextAlignmentCenter;
    _tipLabel.textColor = [UIColor whiteColor];
    _tipLabel.text = @"您暂未开通此功能";
    [navigation addSubview:_tipLabel];
    
    _openButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _openButton.frame = CGRectMake(0, _tipLabel.bottom+5, 100, 35);
    _openButton.centerX = SCREEN_WIDTH*0.5;
    _openButton.backgroundColor = [UIColor colorWithRed:252/255.f green:166/255.f blue:41/255.f alpha:1];
    [_openButton setTitle:@"立即开通" forState:UIControlStateNormal];
    [_openButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _openButton.layer.masksToBounds = YES;
    _openButton.layer.cornerRadius = 5;
    [_openButton addTarget:self action:@selector(openClick) forControlEvents:UIControlEventTouchUpInside];
    [navigation addSubview:_openButton];
    
    _titleLabel= [[UILabel alloc]initWithFrame:CGRectMake(20, navigation.bottom, SCREEN_WIDTH-40, 50)];
    _titleLabel.textColor = RGBCOLOR_HEX(kLabelDarkColor);
    _titleLabel.font = [UIFont systemFontOfSize:17];
    _titleLabel.text = @"如何开通防骚扰提醒？";
    [self.view addSubview:_titleLabel];
    
    NIAttributedLabel *tlabel = [[NIAttributedLabel alloc]initWithFrame:CGRectMake(20, _titleLabel.bottom-10, SCREEN_WIDTH-40, 100)];
    tlabel.font = [UIFont systemFontOfSize:13];
    tlabel.text = @"为了尽可能的压缩号码库大小，我们只下发经过云端分析最近24小时最有可能骚扰您的电话（不一定是被标记最多的哦），建议您每月更新确保比较高的识别率，另外，您手动标记的号码将100%被识别出来。";
    tlabel.textColor = RGBCOLOR_HEX(kLabelWeakColor);
    tlabel.numberOfLines = 0;
    tlabel.lineHeight = 21;
    [self.view  addSubview:tlabel];
    
    UIView *shareView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-45, SCREEN_WIDTH, 45)];
    shareView.backgroundColor = [UIColor colorWithRed:95/255.f green:120/255.f blue:210/255.f alpha:1];
    [self.view addSubview:shareView];
    
    UILabel *shareLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 190, 45)];
    shareLabel.centerX = SCREEN_WIDTH*0.5+15;
    shareLabel.textColor = [UIColor whiteColor];
    shareLabel.text = @"好消息转告给您的小伙伴";
    [shareView addSubview:shareLabel];
    
    UIImageView *shareImage = [[UIImageView alloc]initWithFrame:CGRectMake(shareLabel.left-30, 12.5, 20, 19)];
    shareImage.image = [UIImage imageNamed:@"saoraofenxiang"];
    [shareView addSubview:shareImage];
    
    [shareView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shareClick)]];
}
- (void)shareClick{
    [[WPUMShareManeger shareManager] shareWithmShareUrl:@"i.wo.cn" andContent:@"开通防骚扰" andImage:nil];
}
- (void)reloadUI{
    if (_hasOpen) {
        _image.image = [UIImage imageNamed:@"saoraoshouye"];
        _titleLabel.text = @"为什么有的防骚扰电话没有识别出来？";
        _openButton.hidden = YES;
        _tipLabel.text = @"您已开通此功能";
    }else{
        _image.image = [UIImage imageNamed:@"saoraoweikaitong"];
        _titleLabel.text = @"如何开通防骚扰提醒？";
        _openButton.hidden = NO;
        _tipLabel.text = @"您暂未开通此功能";
    }
    
}
- (void)openClick{
    _hasOpen = !_hasOpen;
    [self reloadUI];
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
