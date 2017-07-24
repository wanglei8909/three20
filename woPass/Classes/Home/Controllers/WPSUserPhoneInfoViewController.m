//
//  WPSUserPhoneInfoViewController.m
//  woPass
//
//  Created by 王蕾 on 15/8/28.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPSUserPhoneInfoViewController.h"
#import "WPPhoneInfoView.h"

@interface WPSUserPhoneInfoViewController ()<UITextFieldDelegate>

@property (nonatomic, strong)UITextField *numField;
@property (nonatomic, strong)WPPhoneInfoView *infoView;
@end

@implementation WPSUserPhoneInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [BaiduMob logEvent:@"id_unicom_ability" eventLabel:@"userinfo"];
    // Do any additional setup after loading the view.
    //self.view.backgroundColor = RGBCOLOR_HEX(0xf8f8f8);
//    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 64+20, 200, 20)];
//    titleLable.backgroundColor = [UIColor clearColor];
//    titleLable.text = @"用户信息查询";
//    titleLable.textColor = RGBCOLOR_HEX(kLabelDarkColor);
//    titleLable.font = [UIFont systemFontOfSize:kFontMiddle];
//    [self.view addSubview:titleLable];
//    
//    UIView *fieldBack = [[UIView alloc]initWithFrame:CGRectMake(15, titleLable.bottom+10, SCREEN_WIDTH-120, 45)];
//    fieldBack.layer.masksToBounds = YES;
//    fieldBack.layer.cornerRadius = 5;
//    fieldBack.layer.borderWidth = 1;
//    fieldBack.layer.borderColor = RGBCOLOR_HEX(kMargineColor).CGColor;
//    fieldBack.layer.backgroundColor = [UIColor whiteColor].CGColor;
//    [self.view addSubview:fieldBack];
//    
//    _numField = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, fieldBack.width-20, 45)];
//    fieldBack.backgroundColor =[UIColor clearColor];
//    _numField.delegate = self;
//    _numField.placeholder = @"输入联通手机号";
//    _numField.font = [UIFont systemFontOfSize:kFontMiddle];
//    _numField.clearButtonMode = UITextFieldViewModeAlways;
//    _numField.keyboardType = UIKeyboardTypePhonePad;
//    [fieldBack addSubview:_numField];
//    fieldBack.backgroundColor =[UIColor whiteColor];
//    
//    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    commitBtn.frame = CGRectMake(fieldBack.right+10, fieldBack.top, 80, 45);
//    commitBtn.layer.masksToBounds = YES;
//    commitBtn.layer.cornerRadius = 3;
//    commitBtn.backgroundColor = RGBCOLOR_HEX(KTextOrangeColor);
//    [commitBtn setTitle:@"查询" forState:UIControlStateNormal];
//    [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    commitBtn.titleLabel.font = [UIFont systemFontOfSize:kFontMiddle];
//    [commitBtn addTarget:self action:@selector(commitClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:commitBtn];

    _infoView = [[WPPhoneInfoView alloc]init];
    [self.view addSubview:_infoView];
    
    [self RequestHttps];
}
- (void)RequestHttps{
    [self showLoading:YES];
    
    NSString *url = @"/u/msisdnInfo";
    NSMutableDictionary *parametersDict = [[NSMutableDictionary alloc]init];
    
    [RequestManeger POST:url parameters:parametersDict complete:processComplete(^(AFHTTPRequestOperation *      operation, id responseObject, NSString *msg) {
        [self hideLoading:YES];
        /*
         data =     {
         user =         {
         brand = "\U5176\U4ed6";
         mobile = 18602201360;
         productName = "WCDMA(3G)-226\U5143iPhone\U5957\U9910";
         userState = "\U6b63\U5e38";
         userType = "\U540e\U4ed8\U8d39";
         };
         };
         */
        int code = [responseObject[@"code"] intValue];
        if (code == 0) {
            [_infoView LoadContent:responseObject[@"data"][@"user"]];
        }else if (code == 99998){
            //没网
            [self ShowNoNetWithRelodAction:^{
                [self RequestHttps];
            }];
        }
        else if (code == 1024){
            [self ShowNoData];
        }
        else{
            [self showHint:msg hide:1];
        }
        
    })];
}

- (BOOL)isUniPhone:(NSString *)phone{
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",UniPhoneRegex];
    if ([phoneTest evaluateWithObject:phone]) {
        return YES;
    }
    return NO;
}

- (void)commitClick{
    [_numField resignFirstResponder];
    if (![self isUniPhone:_numField.text]) {
        [self showHint:@"请输入联通手机号" hide:2];
        return;
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
    return @"用户信息";
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
