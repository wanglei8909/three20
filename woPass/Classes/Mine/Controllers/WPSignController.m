//
//  WPSignController.m
//  woPass
//
//  Created by 王蕾 on 15/7/16.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPSignController.h"
#import "WPModifyUserInfoViewModel.h"
#import "WPAlertView.h"

@implementation WPSignController



-(void)viewDidLoad{
    [super viewDidLoad];
    [self AddRightTextBtn:@"保存" target:self action:@selector(SaveBtnClick)];
    
    UIView *backBg = [[UIView alloc]initWithFrame:CGRectMake(-1, 75, SCREEN_WIDTH+2, 138)];
    backBg.backgroundColor = [UIColor whiteColor];
    backBg.layer.borderWidth = 1;
    backBg.layer.borderColor = RGBCOLOR_HEX(kMargineColor).CGColor;
    [self.view addSubview:backBg];
    
    _signTextView = [[UITextView alloc]initWithFrame:CGRectMake(15, 0, backBg.width-30, backBg.height)];
    _signTextView.backgroundColor = [UIColor clearColor];
    _signTextView.font = [UIFont systemFontOfSize:15];
    _signTextView.textColor = RGBCOLOR_HEX(kLabelDarkColor);
    _signTextView.textContainerInset = UIEdgeInsetsMake(0, _signTextView.textContainerInset.left, _signTextView.textContainerInset.bottom, _signTextView.textContainerInset.right);
    _signTextView.delegate = self;
    _signTextView.text = gUser.signature;
    [backBg addSubview:_signTextView];
    
    _otisLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 300, 15)];
    _otisLabel.backgroundColor = [UIColor clearColor];
    _otisLabel.textColor = RGBCOLOR_HEX(0xc7c7c7);
    _otisLabel.font = [UIFont systemFontOfSize:15];
    _otisLabel.text = @"请输入个性签名";
    _otisLabel.hidden = _signTextView.text.length != 0;
    [backBg addSubview:_otisLabel];
}
-(void)dismiss{
    [_signTextView resignFirstResponder];
    if (_signTextView.text.length != 0) {
        weaklySelf();
        WPAlertView *av = [[WPAlertView alloc]initWithTitle:@"提示" message:@"离开将丢失已输入的内容，确定离开？" buttonTitles:@[@"留在此页",@"我要离开"] andCancleClick:^{
            [weakSelf.signTextView becomeFirstResponder];
        }andOKClick:^{
            [super dismiss];
        }];
        [av show];
    }else [super dismiss];
}


-(void)textViewDidChange:(UITextView *)textView{
    _otisLabel.hidden = textView.text.length != 0;
}


- (void)SaveBtnClick{
    [WPModifyUserInfoViewModel ChangeUserInfoWithType:@"signature" AndValue:_signTextView.text AndSecceed:^{
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
    return @"个性签名";
}

@end
