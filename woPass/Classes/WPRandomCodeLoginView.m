//
//  WPRandomCodeLoginView.m
//  woPass
//
//  Created by 王蕾 on 15/10/30.
//  Copyright © 2015年 unisk. All rights reserved.
//

#import "WPRandomCodeLoginView.h"
#import "JKCountDownButton.h"
#import "UIView+ShowMsg.h"
#import "NIAttributedLabel.h"

#define countDownBtnWidth 105

@implementation WPRandomCodeLoginView
{
    UITextField *numField;
    UILabel *numFieldTitle;
    UIButton *saveBtn;
    UITextField *codeField;
    NSString *mobileNum;
    NSString *codeNum;
    JKCountDownButton *countDownCode;
    UILabel *tipsLabel;
    UIView *fieldBack;
    NIAttributedLabel *securetyType;
}
- (void)setStep:(int)step{
    _step = step;
    if (step == 1) {
        numFieldTitle.text = @"手机号";
        numField.placeholder = @"请输入联通手机号";
        [saveBtn setTitle:@"获取随机密码" forState:UIControlStateNormal];
        countDownCode.hidden = YES;
        tipsLabel.hidden = YES;
        fieldBack.top = fieldBack.top - 25;
        saveBtn.top = saveBtn.top - 25;
        securetyType.top = securetyType.top - 25;
    }else if (step == 2){
        numFieldTitle.text = @"随机密码";
        numField.placeholder = @"请输入随机密码";
        [saveBtn setTitle:@"立即登录" forState:UIControlStateNormal];
        countDownCode.hidden = NO;
        tipsLabel.text = [NSString stringWithFormat:@"动态密码将发送至%@",mobileNum];
        tipsLabel.hidden = NO;
        fieldBack.top = fieldBack.top + 25;
        saveBtn.top = saveBtn.top + 25;
        securetyType.top = securetyType.top + 25;
    }
}
- (instancetype)init{
    self = [super initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, SCREEN_HEIGHT-100)];
    if (self) {
        _step = 1;
        self.backgroundColor = [UIColor clearColor];
        
        tipsLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, SCREEN_HEIGHT, 15)];
        tipsLabel.font = [UIFont systemFontOfSize:kFontTiny];
        tipsLabel.hidden = YES;
        tipsLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:tipsLabel];
        
        fieldBack = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
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
        numField.keyboardType = UIKeyboardTypeNumberPad;
        [fieldBack addSubview:numField];
        fieldBack.backgroundColor =[UIColor whiteColor];
        
        saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        saveBtn.layer.masksToBounds = YES;
        saveBtn.layer.cornerRadius = 3;
        saveBtn.frame = CGRectMake(15, (45+10)+10, SCREEN_WIDTH-30, 45);
        [saveBtn setTitle:@"获取随机密码" forState:UIControlStateNormal];
        [saveBtn setTitleColor:RGBCOLOR_HEX(0xffffff) forState:UIControlStateNormal];
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
        //验证码
        countDownCode = [JKCountDownButton buttonWithType:UIButtonTypeCustom];
        countDownCode.frame = CGRectMake(0, 0, countDownBtnWidth, 25);
        countDownCode.left = fieldBack.right-countDownBtnWidth-10;
        countDownCode.top = 10;
        [countDownCode setTitle:@"获取随机码" forState:UIControlStateNormal];
        [countDownCode setBackgroundImage:[UIImage imageWithColor:RGBCOLOR_HEX(KTextOrangeColor)] forState:UIControlStateNormal];
        [countDownCode setBackgroundImage:[UIImage imageWithColor:RGBCOLOR_HEX(kDisableBgColor)] forState:UIControlStateSelected];
        [countDownCode setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [countDownCode setTitleColor:RGBCOLOR_HEX(kDisableTitleColor) forState:UIControlStateSelected];
        countDownCode.titleLabel.font = XFont(kFontMiddle);
        countDownCode.layer.masksToBounds = YES;
        countDownCode.layer.cornerRadius = 3;
        countDownCode.selected = YES;
        countDownCode.hidden = YES;
        [countDownCode addTarget:self action:@selector(CountDownBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [fieldBack addSubview:countDownCode];
        
        [countDownCode addToucheHandler:^(JKCountDownButton*sender, NSInteger tag) {
            sender.userInteractionEnabled = NO;
            sender.selected = YES;
            [sender startWithSecond:60];
            
            [sender didChange:^NSString *(JKCountDownButton *countDownButton,int second) {
                NSString *title = [NSString stringWithFormat:@"获取随机码(%ds)",second];
                return title;
            }];
            [sender didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
                countDownButton.userInteractionEnabled = YES;
                countDownButton.selected = NO;
                return @"重新获取";
            }];
        }];
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
- (void)LoginClick{
    [numField endEditing:YES];
    if (self.step == 1) {
        
        if (![self isUniPhone:numField.text]) {
            [self showHint:@"请输入联通手机号" hide:2];
            return;
        }
        [self getCode];
        
    }
    else if (self.step == 2){
        if (numField.text.length==0) {
            [self showHint:@"请输入验证码" hide:2];
            return;
        }
        codeNum = numField.text;
        if (self.loginBlock) {
            self.loginBlock(mobileNum,codeNum);
        }
    }
}
- (void)getCode{
    saveBtn.enabled = NO;
    mobileNum = [numField.text copy];
    [self CountDownBtnClick:countDownCode];
    
}
- (void)CountDownBtnClick:(JKCountDownButton *)sender{
    
     [numField endEditing:YES];
    
     NSString *url = @"/c/sendLoginCode";
     NSMutableDictionary *parametersDict = [[NSMutableDictionary alloc]init];
     [parametersDict setObject:mobileNum forKey:@"mobile"];
     //
     [RequestManeger POST:url parameters:parametersDict complete:processComplete(^(AFHTTPRequestOperation *      operation, id responseObject, NSString *msg) {
     NSInteger code = [responseObject[@"code"] integerValue];
         if (code == 0 && responseObject) {
             if (sender.touchedDownBlock) {
                 sender.touchedDownBlock(sender,sender.tag);
             }
             self.step = 2;
             numField.text = nil;
         }
         
     [self showHint:msg hide:2];
         saveBtn.enabled = YES;
     })];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
