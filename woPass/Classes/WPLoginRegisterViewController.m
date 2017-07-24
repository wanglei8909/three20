//
//  WPLoginRegisterViewController.m
//  woPass
//
//  Created by 王蕾 on 15/7/16.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPLoginRegisterViewController.h"
#import "WPLoginTypeSelectView.h"
#import "JKCountDownButton.h"
#import "WPRegisterController.h"
#import "WPFindSecurityController.h"

#define countDownBtnWidth 95

@implementation WPLoginRegisterViewController
{
    UITextField *numField;
    UITextField *securityField;
    JKCountDownButton *countDownCode;
    NSInteger loginType;
    UIButton *setPasswordBtn;
    UIButton *forgetBtn;
}


- (void)ChangeType:(NSInteger)index{
    setPasswordBtn.hidden = (index == 0);
    forgetBtn.hidden = (index == 0);
    [numField resignFirstResponder];
    [securityField resignFirstResponder];
    loginType = index;
    securityField.secureTextEntry = index == 1;
    securityField.text = @"";
    CGRect countCodeFrame = countDownCode.frame;
    CGRect securityFieldFrame = securityField.frame;
    CGRect securitySuperFrame = securityField.superview.frame;
    NSString *placeText = index == 0?@"请输入随机密码":@"请输入密码";
    if (index == 1) {
        securityField.keyboardType = UIKeyboardTypeASCIICapable;
        countCodeFrame.origin.x = SCREEN_WIDTH-15;
        countCodeFrame.size.width = 0;
        securityFieldFrame.size.width = SCREEN_WIDTH-30-20;
        securitySuperFrame.size.width = SCREEN_WIDTH-30;
    }else{
        securityField.keyboardType = UIKeyboardTypeNumberPad;
        countCodeFrame.origin.x = SCREEN_WIDTH-15-countDownBtnWidth;
        countCodeFrame.size.width = countDownBtnWidth;
        securityFieldFrame.size.width = SCREEN_WIDTH-120;
        securitySuperFrame.size.width = SCREEN_WIDTH-15-120;
    }
    
    
    [UIView animateWithDuration:0.5 animations:^{
        securityField.superview.frame = securitySuperFrame;
        securityField.frame = securityFieldFrame;
        countDownCode.frame = countCodeFrame;
        securityField.placeholder = placeText;
    }];
}
- (void)viewDidLoad{
    [super viewDidLoad];
    
    loginType = 0;
    
    WPLoginTypeSelectView *typeSelectView = [[WPLoginTypeSelectView alloc]init];
    typeSelectView.selectBlock = ^(NSInteger index){
        [self ChangeType:index];
    };
    [self.view addSubview:typeSelectView];
    
    NSArray *placeholderText = @[@"请输入联通手机号",@"请输入随机密码"];
    for (int i = 0; i<2; i++) {
        float top = 60;
        float width = i!=1?SCREEN_WIDTH-30:SCREEN_WIDTH-30-countDownBtnWidth-10;
        UIView *fieldBack = [[UIView alloc]initWithFrame:CGRectMake(15, top + i*(45+10), width, 45)];
        fieldBack.layer.masksToBounds = YES;
        fieldBack.layer.cornerRadius = 5;
        fieldBack.layer.borderWidth = 1;
        fieldBack.layer.borderColor = RGBCOLOR_HEX(kMargineColor).CGColor;
        fieldBack.layer.backgroundColor = [UIColor whiteColor].CGColor;
        [self.view addSubview:fieldBack];
        
        UITextField *field = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, width-20, 45)];
        fieldBack.backgroundColor =[UIColor clearColor];
        field.delegate = self;
        field.placeholder = placeholderText[i];
        field.font = [UIFont systemFontOfSize:kFontMiddle];
        field.clearButtonMode = UITextFieldViewModeAlways;
        [fieldBack addSubview:field];
        fieldBack.backgroundColor =[UIColor whiteColor];

        if (i==0) {
            numField = field;
            numField.keyboardType = UIKeyboardTypeNumberPad;
            [field addTarget:self action:@selector(FieldChange:) forControlEvents:UIControlEventEditingChanged];
        }else securityField = field;
        
        if (i==1) {
            securityField.keyboardType = UIKeyboardTypeNumberPad;
            countDownCode = [JKCountDownButton buttonWithType:UIButtonTypeCustom];
            countDownCode.frame = CGRectMake(0, 0, countDownBtnWidth, 39);
            countDownCode.left = fieldBack.right+10;
            countDownCode.top = fieldBack.top + 3;
            [countDownCode setTitle:@"获取随机码" forState:UIControlStateNormal];
            [countDownCode setBackgroundImage:[UIImage imageWithColor:RGBCOLOR_HEX(KTextOrangeColor)] forState:UIControlStateNormal];
            [countDownCode setBackgroundImage:[UIImage imageWithColor:RGBCOLOR_HEX(kDisableBgColor)] forState:UIControlStateSelected];
            [countDownCode setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [countDownCode setTitleColor:RGBCOLOR_HEX(kDisableTitleColor) forState:UIControlStateSelected];
            countDownCode.titleLabel.font = XFont(kFontMiddle);
            countDownCode.layer.masksToBounds = YES;
            countDownCode.layer.cornerRadius = 3;
            countDownCode.selected = YES;
            [countDownCode addTarget:self action:@selector(CountDownBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:countDownCode];
            
            [countDownCode addToucheHandler:^(JKCountDownButton*sender, NSInteger tag) {
                sender.userInteractionEnabled = NO;
                sender.selected = YES;
                [sender startWithSecond:60];
                
                [sender didChange:^NSString *(JKCountDownButton *countDownButton,int second) {
                    NSString *title = [NSString stringWithFormat:@"剩余%d秒",second];
                    return title;
                }];
                [sender didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
                    countDownButton.userInteractionEnabled = YES;
                    countDownButton.selected = NO;
                    return @"重新获取";
                }];
            }];
        }
    }
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.layer.masksToBounds = YES;
    saveBtn.layer.cornerRadius = 3;
    saveBtn.frame = CGRectMake(15, 3*(45+10)+10, SCREEN_WIDTH-30, 45);
    [saveBtn setTitle:@"登录" forState:UIControlStateNormal];
    [saveBtn setTitleColor:RGBCOLOR_HEX(0xffffff) forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:kFontMiddle];
    [saveBtn addTarget:self action:@selector(LoginClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
    saveBtn.backgroundColor = RGBCOLOR_HEX(KTextOrangeColor);
    
    UIButton *registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registBtn.backgroundColor = [UIColor clearColor];
    registBtn.frame = CGRectMake(saveBtn.left, saveBtn.bottom+5, 35, 30);
    [registBtn setTitle:@"注册" forState:UIControlStateNormal];
    registBtn.titleLabel.font = [UIFont systemFontOfSize:kFontMiddle];
    [registBtn setTitleColor:RGBCOLOR_HEX(kLabelDarkColor) forState:UIControlStateNormal];
    [registBtn addTarget:self action:@selector(ReginstClick) forControlEvents:UIControlEventTouchUpInside];
    //[self.view addSubview:registBtn];
    
    forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetBtn.backgroundColor = [UIColor clearColor];
    forgetBtn.frame = CGRectMake(SCREEN_WIDTH*0.5, SCREEN_HEIGHT-120, 80, 30);
    [forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    forgetBtn.titleLabel.font = [UIFont systemFontOfSize:kFontMiddle];
    [forgetBtn setTitleColor:RGBCOLOR_HEX(kLabelDarkColor) forState:UIControlStateNormal];
    [forgetBtn addTarget:self action:@selector(ForgetClick) forControlEvents:UIControlEventTouchUpInside];
    forgetBtn.hidden = YES;
    [self.view addSubview:forgetBtn];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, forgetBtn.height)];
    line.backgroundColor = RGBCOLOR_HEX(kMargineColor);
    [forgetBtn addSubview:line];
    
    setPasswordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    setPasswordBtn.backgroundColor = [UIColor clearColor];
    setPasswordBtn.frame = CGRectMake(SCREEN_WIDTH*0.5-80, SCREEN_HEIGHT-120, 80, 30);
    [setPasswordBtn setTitle:@"设置密码" forState:UIControlStateNormal];
    setPasswordBtn.titleLabel.font = [UIFont systemFontOfSize:kFontMiddle];
    [setPasswordBtn setTitleColor:RGBCOLOR_HEX(kLabelDarkColor) forState:UIControlStateNormal];
    [setPasswordBtn addTarget:self action:@selector(SetPasswordClick) forControlEvents:UIControlEventTouchUpInside];
    setPasswordBtn.hidden = YES;
    [self.view addSubview:setPasswordBtn];
}

- (void)FieldChange:(UITextField *)sender{
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",UniPhoneRegex];
    countDownCode.selected = ![phoneTest evaluateWithObject:sender.text];
    countDownCode.userInteractionEnabled = [phoneTest evaluateWithObject:sender.text];
}
- (BOOL)isUniPhone:(NSString *)phone{
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",UniPhoneRegex];
    if ([phoneTest evaluateWithObject:phone]) {
        return YES;
    }
    return NO;
}
- (void)CountDownBtnClick:(JKCountDownButton *)sender{
    [numField endEditing:YES];
    if (![self isUniPhone:numField.text]) {
        [self showHint:@"请输入联通手机号" hide:2];
        return;
    }
    
    [self showLoading:YES];
    NSString *url = @"/c/sendLoginCode";
    NSMutableDictionary *parametersDict = [[NSMutableDictionary alloc]init];
    [parametersDict setObject:numField.text forKey:@"mobile"];
    //
    [RequestManeger POST:url parameters:parametersDict complete:processComplete(^(AFHTTPRequestOperation *      operation, id responseObject, NSString *msg) {
        [self hideLoading:YES];
        NSInteger code = [responseObject[@"code"] integerValue];
        if (code == 0 && responseObject) {
            if (sender.touchedDownBlock) {
                sender.touchedDownBlock(sender,sender.tag);
            }
        }
        
        [self showHint:msg hide:2];
        
    })];
}
- (BOOL)HasNumAndAl:(NSString *)passWord{
    NSPredicate *passRegx = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"(?=^.{6,16}$)(?=.*\\d)(?=.*.+)(?=.*[a-z])(?!.*\n).*$"];
    return [passRegx evaluateWithObject:passWord];
}
- (BOOL)CheckSecurity:(NSString *)passWord{
    if (passWord.length < 6 || passWord.length > 16) {
        return NO;
    }
    if (![self HasNumAndAl:passWord]) {
        return NO;
    }
    return YES;
}
- (void)LoginClick{
    [numField endEditing:YES];
    [securityField endEditing:YES];
    if (![self isUniPhone:numField.text]) {
        [self showHint:@"请输入联通手机号" hide:2];
        return;
    }
    //1：密码登录 2：验证码登录
    NSString *mLoginType = loginType==0?@"2":@"1";
    NSString *passWord = securityField.text;
    if (loginType == 0) {
        //校验 1、短信验证码登录不做校验，但是不能为空
        [BaiduMob logEvent:@"id_login_click" eventLabel:@"message"];
        if (passWord.length==0) {
            [self showHint:@"请输入验证码" hide:2];
            return;
        }
    }else if (loginType == 1){
        //2、密码登录需要校验密码是否符合规则
        [BaiduMob logEvent:@"id_login_click" eventLabel:@"passport"];
        if (![self CheckSecurity:passWord]) {
            [self showHint:@"密码不正确" hide:2];
            return;
        }
    }
    
    [self showLoading:YES];
    
    NSString *url = @"/u/login";
    NSMutableDictionary *parametersDict = [[NSMutableDictionary alloc]init];
    [parametersDict setObject:numField.text forKey:@"mobile"];
    [parametersDict setObject:passWord forKey:@"password"];
    [parametersDict setObject:mLoginType forKey:@"loginType"];
    
    // 登录
    [RequestManeger POST:url parameters:parametersDict complete:processComplete(^(AFHTTPRequestOperation *      operation, id responseObject, NSString *msg) {
        [self hideLoading:YES];
        /*
         {
            code = 0;
            data =     {
                qrRegularExpression = "^http://www.wobendi.com/";
                refreshToken = "";
                userId = 1516607202800;
                woToken = fface206542dc78fa4b0ad3d481e1810;
            };
            message = "\U6210\U529f";
         }
         */
        NSDictionary *userDict = responseObject[@"data"];
        [gUser SetLogin:userDict];
        NSLog(@"%@",gUser.woToken);
        self.loginFinish(@{});
        [self showHint:msg hide:2];
        if (loginType == 0) {
            //校验 1、短信验证码登录不做校验，但是不能为空
            [BaiduMob logEvent:@"id_login_success" eventLabel:@"random"];
        }else if (loginType == 1){
            //2、密码登录需要校验密码是否符合规则
            [BaiduMob logEvent:@"id_login_success" eventLabel:@"passport"];
        }
    })];
}
- (void)ReginstClick{
    WPRegisterController *rCtrl = [[WPRegisterController alloc]init];
    rCtrl.finishBlock = ^{
        self.loginFinish(@{});
    };
    [self.navigationController pushViewController:rCtrl animated:YES];
}
- (void)ForgetClick{
    [@"WP://WPFindSecurityTypeCtrl" open];
}
- (void)SetPasswordClick{
    WPFindSecurityController *ctrl = [[WPFindSecurityController alloc]init];
    ctrl.mTitle = @"设置密码";
    [self.navigationController pushViewController:ctrl animated:YES];
    [BaiduMob logEvent:@"id_password" eventLabel:@"set_login"];
}

- (BOOL)hideNavigationBar
{
    return YES;
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
    return @"登录";
}

@end
