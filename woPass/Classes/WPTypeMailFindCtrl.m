//
//  WPTypeMailFindCtrl.m
//  woPass
//
//  Created by 王蕾 on 15/11/30.
//  Copyright © 2015年 unisk. All rights reserved.
//

#import "WPTypeMailFindCtrl.h"
#import "WPWrapperLoginViewController.h"


@implementation WPTypeMailFindCtrl
{
    NSArray *imageNames;
    NSArray *labelTexts;
    UITextField *numField;
    UIButton *saveBtn;
    UIView *textView;
    int mStatus;
}

- (void)setStatus:(int)status{
    mStatus = status;
    textView.hidden = YES;
    _topImage.image = [UIImage imageNamed:imageNames[status]];
    _titleLabel.text = labelTexts[status];
    
    UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    okBtn.layer.masksToBounds = YES;
    okBtn.layer.cornerRadius = 3;
    okBtn.frame = CGRectMake(15, 4*(45+10)+10, SCREEN_WIDTH-30, 45);
    [okBtn setTitle:@"知道了" forState:UIControlStateNormal];
    [okBtn setTitleColor:RGBCOLOR_HEX(0xffffff) forState:UIControlStateNormal];
    okBtn.titleLabel.font = [UIFont systemFontOfSize:kFontMiddle];
    [okBtn addTarget:self action:@selector(okBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:okBtn];
    okBtn.backgroundColor = RGBCOLOR_HEX(KTextOrangeColor);
}

- (void)viewDidLoad{
    [super viewDidLoad];
    mStatus = 0;
    imageNames = @[@"忘记密码_08",@"忘记密码_11",@"忘记密码_05"];
    labelTexts = @[@"找回密码邮件已经下发，打开邮件完成重置密码操作。",@"对不起，邮件下发失败，请稍后再试。",@"您未绑定邮箱，请使用手机号码找回密码"];
    
    _topImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 80)];
    _topImage.center = CGPointMake(SCREEN_WIDTH *0.5, 130);
    [self.view addSubview:_topImage];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, _topImage.bottom+10, SCREEN_WIDTH-120, 40)];
    _titleLabel.font = [UIFont systemFontOfSize:kFontLarge];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = RGBCOLOR_HEX(kLabelDarkColor);
    _titleLabel.numberOfLines = 0;
    [self.view addSubview:_titleLabel];
    
    //[self setStatus:(arc4random() % 3)];
    
    textView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT)];
    textView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:textView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, SCREEN_WIDTH, 40)];
    label.text = @"请输入要找回的帐号";
    label.textColor = RGBCOLOR_HEX(kLabelDarkColor);
    label.font = [UIFont systemFontOfSize:kFontMiddle];
    [textView addSubview:label];
    
    float top = 60;
    float width = SCREEN_WIDTH-30;
    UIView *fieldBack = [[UIView alloc]initWithFrame:CGRectMake(15, top, width, 45)];
    fieldBack.layer.masksToBounds = YES;
    fieldBack.layer.cornerRadius = 5;
    fieldBack.layer.borderWidth = 1;
    fieldBack.layer.borderColor = RGBCOLOR_HEX(kMargineColor).CGColor;
    fieldBack.layer.backgroundColor = [UIColor whiteColor].CGColor;
    [textView addSubview:fieldBack];
    
    numField = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, width-20, 45)];
    fieldBack.backgroundColor =[UIColor clearColor];
    numField.delegate = self;
    numField.placeholder = @"请输入联通手机号";
    numField.font = [UIFont systemFontOfSize:kFontMiddle];
    numField.clearButtonMode = UITextFieldViewModeAlways;
    [fieldBack addSubview:numField];
    fieldBack.backgroundColor =[UIColor whiteColor];
    numField.keyboardType = UIKeyboardTypeNumberPad;
    //[numField addTarget:self action:@selector(FieldChange:) forControlEvents:UIControlEventEditingChanged];
    
    saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.layer.masksToBounds = YES;
    saveBtn.layer.cornerRadius = 3;
    saveBtn.frame = CGRectMake(15, 2*(45+10)+10, SCREEN_WIDTH-30, 45);
    [saveBtn setTitle:@"确定" forState:UIControlStateNormal];
    [saveBtn setTitleColor:RGBCOLOR_HEX(0xffffff) forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:kFontMiddle];
    [saveBtn addTarget:self action:@selector(LoginClick) forControlEvents:UIControlEventTouchUpInside];
    [textView addSubview:saveBtn];
    saveBtn.backgroundColor = RGBCOLOR_HEX(KTextOrangeColor);
}

- (BOOL)isUniPhone:(NSString *)phone{
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",UniPhoneRegex];
    if ([phoneTest evaluateWithObject:phone]) {
        return YES;
    }
    return NO;
}


- (void)LoginClick{
    [numField endEditing:YES];
    if (![self isUniPhone:numField.text]) {
        [self showHint:@"请输入联通手机号" hide:2];
        return;
    }
    
    NSString *url = @"/c/sendChangePasswordEmail";
    NSMutableDictionary *parametersDict = [[NSMutableDictionary alloc]init];
    [parametersDict setObject:numField.text forKey:@"mobile"];
    [self showLoading:YES];
    // 登录
    [RequestManeger POST:url parameters:parametersDict complete:processComplete(^(AFHTTPRequestOperation *      operation, id responseObject, NSString *msg) {
        [self hideLoading:YES];
        int code = [[responseObject objectForKey:@"code"] intValue];
        if (code == 20014) {
            [self setStatus:2];
        }else if (code == 0){
            [self setStatus:0];
        }else{
            [self setStatus:1];
        }
    })];
}



- (void)okBtnClick{
    if (mStatus==2) {
        [self dismiss];
    }else{
        for (UIViewController *ctrl in self.navigationController.viewControllers) {
            if ([ctrl isKindOfClass:[WPWrapperLoginViewController class]]) {
                [self.navigationController popToViewController:ctrl animated:YES];
            }
        }
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
    return @"忘记密码";
}

@end
