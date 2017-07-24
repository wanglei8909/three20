//
//  WPSecurityLoginView.m
//  woPass
//
//  Created by 王蕾 on 15/10/30.
//  Copyright © 2015年 unisk. All rights reserved.
//

#import "WPSecurityLoginView.h"
#import "NIAttributedLabel.h"
#import "UIView+ShowMsg.h"

@implementation WPSecurityLoginView
{
    UIButton *saveBtn;
    NIAttributedLabel *securetyType;
    UITextField *numField;
    UITextField *codeField;
}
- (instancetype)init{
    self = [super initWithFrame:CGRectMake(SCREEN_WIDTH, 10, SCREEN_WIDTH, SCREEN_HEIGHT-100)];
    if (self) {
        
        
        UIView *fieldBack = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 90)];
        fieldBack.layer.masksToBounds = YES;
        fieldBack.layer.cornerRadius = 3;
        fieldBack.layer.borderWidth = 0.6;
        fieldBack.layer.borderColor = RGBCOLOR_HEX(kMargineColor).CGColor;
        fieldBack.layer.backgroundColor = [UIColor whiteColor].CGColor;
        [self addSubview:fieldBack];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(80, 45, SCREEN_WIDTH-80, 0.6)];
        line.backgroundColor = RGBCOLOR_HEX(kMargineColor);
        [fieldBack addSubview:line];
        
        NSArray *titleArray = @[@"手机号",@"密码"];
        NSArray *placeholderArray = @[@"请输入联通手机号",@"请输入密码"];
        for (int i = 0; i<2; i++) {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, i*45, 80, 45)];
            label.text = titleArray[i];
            label.font = [UIFont systemFontOfSize:kFontMiddle];
            [fieldBack addSubview:label];
            
            UITextField *field = [[UITextField alloc]initWithFrame:CGRectMake(80, i*45, SCREEN_WIDTH-120, 45)];
            field.backgroundColor =[UIColor clearColor];
            field.delegate = self;
            field.placeholder = placeholderArray[i];
            field.font = [UIFont systemFontOfSize:kFontMiddle];
            field.clearButtonMode = UITextFieldViewModeAlways;
            
            [fieldBack addSubview:field];
            fieldBack.backgroundColor =[UIColor whiteColor];
            if (i==0) {
                numField = field;
                field.keyboardType = UIKeyboardTypeNumberPad;
            }else{
                codeField = field;
                codeField.secureTextEntry = YES;
            }
        }
        
        saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        saveBtn.layer.masksToBounds = YES;
        saveBtn.layer.cornerRadius = 3;
        saveBtn.frame = CGRectMake(15, (90+10)+10, SCREEN_WIDTH-30, 45);
        [saveBtn setTitle:@"立即登录" forState:UIControlStateNormal];
        ;        [saveBtn setTitleColor:RGBCOLOR_HEX(0xffffff) forState:UIControlStateNormal];
        saveBtn.titleLabel.font = [UIFont systemFontOfSize:kFontMiddle];
        [saveBtn addTarget:self action:@selector(LoginClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:saveBtn];
        saveBtn.backgroundColor = RGBCOLOR_HEX(KTextOrangeColor);
        
        securetyType = [[NIAttributedLabel alloc]initWithFrame:CGRectMake(0, saveBtn.bottom+15, 140, 16)];
        securetyType.text = @"使用快捷登录";
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
        
        NIAttributedLabel *forget = [[NIAttributedLabel alloc]initWithFrame:CGRectMake(0, saveBtn.bottom+15, 140, 16)];
        forget.text = @"忘记密码";
        forget.textColor = [UIColor blueColor];
        forget.font = [UIFont systemFontOfSize:kFontMiddle];
        forget.left = saveBtn.left;
        forget.underlineStyle = kCTUnderlineStyleSingle;
        forget.userInteractionEnabled = YES;
        [self addSubview:forget];
        
        UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        forgetBtn.backgroundColor =[UIColor clearColor];
        forgetBtn.frame = securetyType.bounds;
        [forgetBtn addTarget:self action:@selector(ForgetClick) forControlEvents:UIControlEventTouchUpInside];
        [forget addSubview:forgetBtn];
        
    }
    return self;
}
- (void)ForgetClick{
    //    WPFindSecurityController *ctrl = [[WPFindSecurityController alloc]init];
    //    [self.navigationController pushViewController:ctrl animated:YES];
#warning 兼容，下版重构
    [@"WP://findPwd_vc" open];
}
- (BOOL)isUniPhone:(NSString *)phone{
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",UniPhoneRegex];
    if ([phoneTest evaluateWithObject:phone]) {
        return YES;
    }
    return NO;
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
- (void)securetyTypeBtnClick{
    if (self.swiftBlock) {
        self.swiftBlock();
    }
}
- (void)LoginClick{
    
    [self endEditing:YES];
    if (![self isUniPhone:numField.text]) {
        [self showHint:@"请输入联通手机号" hide:2];
        return;
    }
    if (![self CheckSecurity:codeField.text]) {
        [self showHint:@"密码不正确" hide:2];
        return;
    }
    
    if (self.loginBlock) {
        self.loginBlock(numField.text,codeField.text);
    }
}


@end
