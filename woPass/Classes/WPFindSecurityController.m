//
//  WPFindSecurityController.m
//  woPass
//
//  Created by 王蕾 on 15/7/17.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPFindSecurityController.h"
#import "JKCountDownButton.h"
#import "WPAlertView.h"

@implementation WPFindSecurityController
{
    UIScrollView *mScrollView;
    UITextField *mPhoneCode;
    UITextField *mNumField;
    UITextField *mPassword;
    //UITextField *mPassword2;
    JKCountDownButton *countDownCode;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    mScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, SCREEN_HEIGHT)];
    mScrollView.backgroundColor = [UIColor clearColor];
    mScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:mScrollView];
    
    float countDownBtnWidth = 90;
    
    NSArray *placeholderText = @[@"请输入联通手机号",@"请输入随机密码",@"请输入新密码",@"请确认新密码"];
    for (int i = 0; i<3; i++) {
        float top = 5;
        float width = i!=1?SCREEN_WIDTH-30:SCREEN_WIDTH-30-countDownBtnWidth-10;
        UIView *fieldBack = [[UIView alloc]initWithFrame:CGRectMake(15, top + i*(45+15), width, 45)];
        
        fieldBack.layer.masksToBounds = YES;
        fieldBack.layer.cornerRadius = 5;
        fieldBack.layer.borderWidth = 1;
        fieldBack.layer.borderColor = RGBCOLOR_HEX(kMargineColor).CGColor;
        fieldBack.layer.backgroundColor = [UIColor whiteColor].CGColor;
        [mScrollView addSubview:fieldBack];
        
        UITextField *field = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, width-20, 45)];
        fieldBack.backgroundColor =[UIColor clearColor];
        field.delegate = self;
        field.placeholder = placeholderText[i];
        field.font = [UIFont systemFontOfSize:kFontMiddle];
        field.clearButtonMode = UITextFieldViewModeAlways;
        [fieldBack addSubview:field];
        fieldBack.backgroundColor =[UIColor whiteColor];
        switch (i) {
            case 0:
                mNumField = field;
                field.keyboardType = UIKeyboardTypeNumberPad;
                [field addTarget:self action:@selector(FieldChange:) forControlEvents:UIControlEventEditingChanged];
                break;
            case 1:
                mPhoneCode = field;
                field.keyboardType = UIKeyboardTypeNumberPad;
                break;
            case 2:
                mPassword = field;
                break;
            default:
                break;
        }
        
        if (i==1) {
            
            countDownCode = [JKCountDownButton buttonWithType:UIButtonTypeCustom];
            countDownCode.frame = CGRectMake(0, 0, countDownBtnWidth, 39);
            countDownCode.left = fieldBack.right+10;
            countDownCode.top = fieldBack.top + 3;
            [countDownCode setTitle:@"获取随机码" forState:UIControlStateNormal];
            [countDownCode setBackgroundImage:[UIImage imageWithColor:RGBCOLOR_HEX(KTextOrangeColor)] forState:UIControlStateNormal];
            [countDownCode setBackgroundImage:[UIImage imageWithColor:RGBCOLOR_HEX(kDisableBgColor)] forState:UIControlStateSelected];
            [countDownCode setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [countDownCode setTitleColor:RGBCOLOR_HEX(kDisableTitleColor) forState:UIControlStateSelected];
            countDownCode.selected = YES;
            countDownCode.titleLabel.font = [UIFont systemFontOfSize:14];
            countDownCode.layer.masksToBounds = YES;
            countDownCode.layer.cornerRadius = 3;
            [countDownCode addTarget:self action:@selector(CountDownBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [mScrollView addSubview:countDownCode];
            
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
                    sender.selected = NO;
                    return @"重新获取";
                    
                }];
                
            }];
        }
    }
    
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.layer.masksToBounds = YES;
    saveBtn.layer.cornerRadius = 3;
    saveBtn.frame = CGRectMake(15, 5 + 3*(45+15), SCREEN_WIDTH-30, 45);
    [saveBtn setTitle:@"确定" forState:UIControlStateNormal];
    [saveBtn setTitleColor:RGBCOLOR_HEX(0xffffff) forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:kFontMiddle];
    [saveBtn addTarget:self action:@selector(ReginstClick) forControlEvents:UIControlEventTouchUpInside];
    [mScrollView addSubview:saveBtn];
    saveBtn.backgroundColor = RGBCOLOR_HEX(KTextOrangeColor);
    
    
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
    [mNumField endEditing:YES];

    if (![self isUniPhone:mNumField.text]) {
        [self showHint:@"请输入联通手机号" hide:2];
        return;
    }
    [self showLoading:YES];
    NSString *url = @"/c/sendForgetPwdCode";
    NSMutableDictionary *parametersDict = [[NSMutableDictionary alloc]init];
    [parametersDict setObject:mNumField.text forKey:@"mobile"];
    //
    [RequestManeger POST:url parameters:parametersDict complete:processComplete(^(AFHTTPRequestOperation *      operation, id responseObject, NSString *msg) {
        [self hideLoading:YES];
        [self showHint:msg hide:1];
        NSInteger code = [responseObject[@"code"] integerValue];
        if (code == 0  && responseObject) {
            if (sender.touchedDownBlock) {
                sender.touchedDownBlock(sender,sender.tag);
            }
        }
    })];
}
- (BOOL)HasNumAndAl:(NSString *)passWord{
    NSPredicate *passRegx = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"(?=^.{6,16}$)(?=.*\\d)(?=.*.+)(?=.*[a-z])(?!.*\n).*$"];
    return [passRegx evaluateWithObject:passWord];
}

- (void)ReginstClick{
    [mPhoneCode endEditing:YES];
    [mNumField endEditing:YES];
    [mPassword endEditing:YES];
    if (![self isUniPhone:mNumField.text]) {
        [self showHint:@"请正确填写手机号" hide:2];
        return;
    }
    if (mPhoneCode.text.length != 6) {
        [self showHint:@"请正确填写验证码" hide:2];
        return;
    }
    if (mPassword.text.length < 6 || mPassword.text.length >16 || ![self HasNumAndAl:mPassword.text]) {
        [self showHint:@"密码为6-16位字符，必须包含数字和字母" hide:2];
        return;
    }
    
    [self showLoading:YES];
    NSString *url = @"/u/changePassword";
    NSMutableDictionary *parametersDict = [[NSMutableDictionary alloc]init];
    [parametersDict setObject:mNumField.text forKey:@"mobile"];
    [parametersDict setObject:mPassword.text forKey:@"password"];
    [parametersDict setObject:mPhoneCode.text forKey:@"validateCode"];
    
    weaklySelf();
    [RequestManeger POST:url parameters:parametersDict complete:processComplete(^(AFHTTPRequestOperation *      operation, id responseObject, NSString *msg) {
        
        [weakSelf hideLoading:YES];
        [weakSelf showHint:msg hide:2];
        int code = [responseObject[@"code"] intValue];
        if (code == 0  && responseObject) {
            weaklySelf();
            WPAlertView *av = [[WPAlertView alloc] initWithTitle:@"设置成功"
                                                         message:@"请重新登录"
                                                    buttonTitles:@[@"确定"] andCancleClick:^{
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }andOKClick:^{
                
                
            }];
            [av show];
        }
    })];
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
    return _mTitle;
}
@end
