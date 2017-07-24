//
//  WPWOHuLianLoginView.m
//  woPass
//
//  Created by 王蕾 on 15/10/30.
//  Copyright © 2015年 unisk. All rights reserved.
//

#import "WPWOHuLianLoginView.h"
#import "UIView+ShowMsg.h"
#import "NIAttributedLabel.h"

@implementation WPWOHuLianLoginView
{
    UITextField *numField;
    UILabel *numFieldTitle;
    UIButton *saveBtn;
    NIAttributedLabel *securetyType;
}

- (void) loginAgain{
    [self ChangeBtnStatus:YES];
}

- (instancetype)init{
    self = [super initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, SCREEN_HEIGHT-100)];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        
        UIView *fieldBack = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
        fieldBack.layer.masksToBounds = YES;
        fieldBack.layer.cornerRadius = 3;
        fieldBack.layer.borderWidth = 0.6;
        fieldBack.layer.borderColor = RGBCOLOR_HEX(kMargineColor).CGColor;
        fieldBack.layer.backgroundColor = [UIColor whiteColor].CGColor;
        [self addSubview:fieldBack];
        
        numFieldTitle = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 80, 45)];
        numFieldTitle.text = @"手机号";
        numFieldTitle.font = [UIFont systemFontOfSize:kFontMiddle];
        [fieldBack addSubview:numFieldTitle];
        
        numField = [[UITextField alloc]initWithFrame:CGRectMake(80, 0, SCREEN_WIDTH-120, 45)];
        numField.backgroundColor =[UIColor clearColor];
        numField.delegate = self;
        numField.placeholder = @"请输入联通手机号";
        numField.font = [UIFont systemFontOfSize:kFontMiddle];
        numField.clearButtonMode = UITextFieldViewModeAlways;
        [fieldBack addSubview:numField];
        numField.keyboardType = UIKeyboardTypeNumberPad;
        fieldBack.backgroundColor =[UIColor whiteColor];
        
        saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        saveBtn.layer.masksToBounds = YES;
        saveBtn.layer.cornerRadius = 3;
        saveBtn.frame = CGRectMake(15, (45+10)+10, SCREEN_WIDTH-30, 45);
        [saveBtn setTitle:@"立即登录" forState:UIControlStateNormal];
        ;        [saveBtn setTitleColor:RGBCOLOR_HEX(0xffffff) forState:UIControlStateNormal];
        saveBtn.titleLabel.font = [UIFont systemFontOfSize:kFontMiddle];
        [saveBtn addTarget:self action:@selector(LoginClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:saveBtn];
        saveBtn.backgroundColor = RGBCOLOR_HEX(KTextOrangeColor);
        
        securetyType = [[NIAttributedLabel alloc]initWithFrame:CGRectMake(0, saveBtn.bottom+10, 140, 16)];
        securetyType.text = @"使用帐号密码登录";
        securetyType.textAlignment = NSTextAlignmentRight;
        securetyType.textColor = [UIColor blueColor];
        securetyType.font = [UIFont systemFontOfSize:kFontMiddle];
        securetyType.right = saveBtn.right;
        securetyType.underlineStyle = kCTUnderlineStyleSingle;
        securetyType.userInteractionEnabled = YES;
        [self addSubview:securetyType];
        
        UIButton *securetyTypeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        securetyTypeBtn.backgroundColor =[UIColor clearColor];
        securetyTypeBtn.frame = securetyType.bounds;
        [securetyTypeBtn addTarget:self action:@selector(securetyTypeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [securetyType addSubview:securetyTypeBtn];
    }
    return self;
}
- (void)securetyTypeBtnClick{
    if (self.secuBlock) {
        self.secuBlock();
    }
}
- (BOOL)isUniPhone:(NSString *)phone{
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",UniPhoneRegex];
    if ([phoneTest evaluateWithObject:phone]) {
        return YES;
    }
    return NO;
}
- (void)ChangeBtnStatus:(BOOL) enable{
    if (enable) {
        saveBtn.enabled = enable;
        [saveBtn setTitle:@"立即登录" forState:UIControlStateNormal];
        saveBtn.backgroundColor = RGBCOLOR_HEX(KTextOrangeColor);
    }else{
        saveBtn.enabled = enable;
        [saveBtn setTitle:@"正在等待验证" forState:UIControlStateNormal];
        saveBtn.backgroundColor = RGBCOLOR_HEX(kDisableBgColor);
    }
}
- (void)LoginClick{
    [numField endEditing:YES];
    if (![self isUniPhone:numField.text]) {
        [self showHint:@"请输入联通手机号" hide:2];
        return;
    }
    [self ChangeBtnStatus:NO];
    if (self.loginBlock) {
        self.loginBlock(numField.text);
    }
}

@end






