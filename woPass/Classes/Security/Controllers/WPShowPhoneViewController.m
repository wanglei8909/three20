//
//  WPShowPhoneViewController.m
//  woPass
//
//  Created by 王蕾 on 16/2/15.
//  Copyright © 2016年 unisk. All rights reserved.
//

#import "WPShowPhoneViewController.h"

@interface WPShowPhoneViewController ()

@property (nonatomic, strong)UILabel *phoneLabel;

@end

@implementation WPShowPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"path-dashouji-4"]];
    image.center = CGPointMake(SCREEN_WIDTH*0.5, 130);
    [self.view addSubview:image];
    
    _phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    _phoneLabel.centerX = SCREEN_WIDTH*0.5;
    _phoneLabel.textColor = RGBCOLOR_HEX(kLabelDarkColor);
    _phoneLabel.text = [NSString stringWithFormat:@"当前手机号：%@",gUser.mobile];
    _phoneLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_phoneLabel];
    _phoneLabel.top = 190;
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.layer.masksToBounds = YES;
    saveBtn.layer.cornerRadius = 3;
    saveBtn.frame = CGRectMake(15, _phoneLabel.bottom+15, SCREEN_WIDTH-30, 45);
    [saveBtn setTitle:@"更换手机" forState:UIControlStateNormal];
    [saveBtn setTitleColor:RGBCOLOR_HEX(0xffffff) forState:UIControlStateNormal];
    [self.view addSubview:saveBtn];
    [saveBtn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    saveBtn.backgroundColor = RGBCOLOR_HEX(KTextOrangeColor);
    
    UILabel *noteLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, saveBtn.bottom+10, saveBtn.width, 45)];
    noteLabel.textColor = RGBCOLOR_HEX(kLabelWeakColor);
    noteLabel.font = [UIFont systemFontOfSize:kFontMiddle];
    noteLabel.text = @"更换绑定后，下次请使用新绑定的手机号登陆沃通行证和第三方应用。";
    noteLabel.numberOfLines = 0;
    [self.view addSubview:noteLabel];
}
- (void)buttonClick{
    [@"WP://WPPhoneNumController" openWithQuery:nil animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _phoneLabel.text = [NSString stringWithFormat:@"当前手机号：%@",gUser.mobile];
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
    return @"绑定手机";
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
