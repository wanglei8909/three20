
//
//  WPNikeController.m
//  woPass
//
//  Created by 王蕾 on 15/7/16.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPNikeController.h"
#import "WPModifyUserInfoViewModel.h"
#import "WPAlertView.h"

@implementation WPNikeController
{
    
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    
    [self AddRightTextBtn:@"保存" target:self action:@selector(SaveBtnClick)];
    
    UIView *backBg = [[UIView alloc]initWithFrame:CGRectMake(-1, 75, SCREEN_WIDTH+2, 45)];
    backBg.backgroundColor = [UIColor whiteColor];
    backBg.layer.borderWidth = 1;
    backBg.layer.borderColor = RGBCOLOR_HEX(kMargineColor).CGColor;
    [self.view addSubview:backBg];
    
    _nikeField = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, backBg.width-22, 45)];
    _nikeField.placeholder = @"请输入昵称";
    _nikeField.clearButtonMode = UITextFieldViewModeAlways;
    _nikeField.text = gUser.nickname;
    _nikeField.delegate = self;
    [backBg addSubview:_nikeField];
    [_nikeField becomeFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSString *text = textField.text;
    if (!text) {
        text = @"";
    }
    text = [text stringByReplacingCharactersInRange:range withString:string];
    if (text.length>15) {
        return NO;
    }
    
    return YES;
}

-(void)dismiss{
    if (_nikeField.text.length != 0) {
        [_nikeField resignFirstResponder];
        weaklySelf();
        WPAlertView *av = [[WPAlertView alloc]initWithTitle:@"提示" message:@"离开将丢失已输入的内容，确定离开？" buttonTitles:@[@"留在此页",@"我要离开"] andCancleClick:^{
            [weakSelf.nikeField becomeFirstResponder];
        }andOKClick:^{
            [super dismiss];
        }];
        [av show];
    }else [super dismiss];
}


- (void)SaveBtnClick{
    [_nikeField resignFirstResponder];
    if (_nikeField.text.length==0 || _nikeField.text.length > 15) {
        [self showHint:@"请输入1~15位昵称" hide:1];
        return;
    }
    
    [WPModifyUserInfoViewModel ChangeUserInfoWithType:@"nickname" AndValue:_nikeField.text AndSecceed:^{
        [self.navigationController popViewControllerAnimated:YES];
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
    return @"昵称修改";
}

@end
