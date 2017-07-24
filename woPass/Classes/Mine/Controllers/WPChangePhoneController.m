//
//  WPChangePhoneController.m
//  woPass
//
//  Created by 王蕾 on 15/7/23.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPChangePhoneController.h"
#import "JKCountDownButton.h"
#import "NIAttributedLabel.h"
#import "WPRootViewController.h"

@implementation WPChangePhoneController


{
    UIScrollView *mScrollView;
    UITextField *numField;
    UITextField *codeField;
    JKCountDownButton *countDownCode;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    mScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, SCREEN_HEIGHT)];
    mScrollView.backgroundColor = [UIColor clearColor];
    mScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:mScrollView];
    
    NIAttributedLabel *titleLabel = [[NIAttributedLabel alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH-30, 60)];
    titleLabel.text = @"更换绑定后请使用新绑定的手机号登录沃通行证和第三方应用。";
    titleLabel.font = [UIFont systemFontOfSize:12];
    titleLabel.textColor = RGBCOLOR_HEX(0x333333);
    titleLabel.numberOfLines = 0;
    titleLabel.lineHeight = 18;
    [mScrollView addSubview:titleLabel];
    
    NSArray *placeholderText = @[@"请输入新手机号",@"请输入验证码"];
    for (int i = 0; i<2; i++) {
        float top = 65;
        float width = i!=1?SCREEN_WIDTH-30:SCREEN_WIDTH-15-120;
        UIView *fieldBack = [[UIView alloc]initWithFrame:CGRectMake(15, top + i*(45+10), width, 45)];
        
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
        field.clearButtonMode = UITextFieldViewModeAlways;
        [fieldBack addSubview:field];
        fieldBack.backgroundColor =[UIColor whiteColor];
        field.keyboardType = UIKeyboardTypeNumberPad;
        if (i==0) {
            numField = field;
            [field addTarget:self action:@selector(FieldChange:) forControlEvents:UIControlEventEditingChanged];
        }
        if (i==1) {
            codeField = field;
            
            countDownCode = [JKCountDownButton buttonWithType:UIButtonTypeCustom];
            countDownCode.frame = CGRectMake(0, 0, SCREEN_WIDTH-15-10-fieldBack.right, 39);
            countDownCode.left = fieldBack.right+10;
            countDownCode.top = fieldBack.top + 3;
            [countDownCode setTitle:@"获取验证码" forState:UIControlStateNormal];
            [countDownCode setBackgroundImage:[UIImage imageWithColor:RGBCOLOR_HEX(KTextOrangeColor)] forState:UIControlStateNormal];
            [countDownCode setBackgroundImage:[UIImage imageWithColor:RGBCOLOR_HEX(kDisableBgColor)] forState:UIControlStateSelected];
            [countDownCode setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [countDownCode setTitleColor:RGBCOLOR_HEX(kDisableTitleColor) forState:UIControlStateSelected];
            countDownCode.selected = YES;
            countDownCode.titleLabel.font = [UIFont systemFontOfSize:14];
            countDownCode.layer.masksToBounds = YES;
            countDownCode.layer.cornerRadius = 3;
            [mScrollView addSubview:countDownCode];
            [countDownCode addTarget:self action:@selector(CountDownBtnClick:) forControlEvents:UIControlEventTouchUpInside];
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
    saveBtn.frame = CGRectMake(15, 65 + 2*(45+10)+10, SCREEN_WIDTH-30, 45);
    [saveBtn setTitle:@"立即更换" forState:UIControlStateNormal];
    [saveBtn setTitleColor:RGBCOLOR_HEX(0xffffff) forState:UIControlStateNormal];
    [mScrollView addSubview:saveBtn];
    [saveBtn addTarget:self action:@selector(ChangePhone) forControlEvents:UIControlEventTouchUpInside];
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
    [numField endEditing:YES];
    [codeField endEditing:YES];
    if (![self isUniPhone:numField.text]) {
        [self showHint:@"请输入联通手机号" hide:2];
        return;
    }
    [numField endEditing:YES];
    [codeField endEditing:YES];
    [self showLoading:YES];
    NSString *url = @"/u/sendModifyMobileCode";
    NSMutableDictionary *parametersDict = [[NSMutableDictionary alloc]init];
    [parametersDict setObject:numField.text forKey:@"mobile"];
    //
    [RequestManeger POST:url parameters:parametersDict complete:processComplete(^(AFHTTPRequestOperation *      operation, id responseObject, NSString *msg) {
        [self hideLoading:YES];
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            if (sender.touchedDownBlock) {
                sender.touchedDownBlock(sender,sender.tag);
            }
        }else{
            
        }
        [self showHint:msg hide:2];
    })];
}

- (void)ChangePhone{
    [numField endEditing:YES];
    [codeField endEditing:YES];
    if (numField.text.length!=11) {
        [self showHint:@"手机号不正确" hide:2];
        return;
    }
    if (codeField.text.length != 6) {
        [self showHint:@"验证码不正确" hide:2];
        return;
    }
    [numField endEditing:YES];
    [codeField endEditing:YES];
    [self showLoading:YES];
    NSString *url = @"/u/modifyMobile";
    NSMutableDictionary *parametersDict = [[NSMutableDictionary alloc]init];
    [parametersDict setObject:numField.text forKey:@"mobile"];
    [parametersDict setObject:codeField.text forKey:@"code"];
    //
    [RequestManeger POST:url parameters:parametersDict complete:processComplete(^(AFHTTPRequestOperation *      operation, id responseObject, NSString *msg) {
        [self hideLoading:YES];
        NSInteger code = [responseObject[@"code"] integerValue];
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            if (code == 0) {
                //验证成功
                ///u/modifyMobile   mobile
                
                gUser.mobile = numField.text;
                UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"绑定成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [av show];
            }else{
                [self showHint:msg hide:2];
            }
        }
        else{
            [self showHint:msg hide:2];
        }
    })];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    dispatch_time_t time=dispatch_time(DISPATCH_TIME_NOW, 0.3*NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        for (UIViewController *ctrl in self.navigationController.viewControllers) {
            if (ctrl && [ctrl isKindOfClass:[WPRootViewController class]]) {
                [self.navigationController popToViewController:ctrl animated:YES];
            }
        }
    });
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
    return @"手机绑定";
}

@end
