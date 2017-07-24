//
//  WPPhoneNumController.m
//  woPass
//
//  Created by 王蕾 on 15/7/16.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPPhoneNumController.h"
#import "NIAttributedLabel.h"
#import "JKCountDownButton.h"
#import "WPChangePhoneController.h"

@implementation WPPhoneNumController

{
    UIScrollView *mScrollView;
    UITextField *codeField;
    JKCountDownButton *countDownCode;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    NSArray *cArray = self.navigationController.viewControllers;

    
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
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 45, 100, 45)];
    label.text= @"当前帐号：";
    label.font = [UIFont systemFontOfSize:kFontMiddle];
    [mScrollView addSubview:label];
    
    NSLog(@"---->%@",gUser.mobile);
    
    UILabel *phone = [[UILabel alloc]initWithFrame:CGRectMake(90, 45, 140, 45)];
    phone.text = gUser.mobile;
    phone.textColor = RGBCOLOR_HEX(KTextOrangeColor);
    phone.font = [UIFont systemFontOfSize:kFontLarge];
    [mScrollView addSubview:phone];
    
    float top = 45;
    float width = SCREEN_WIDTH-15-120;
    UIView *fieldBack = [[UIView alloc]initWithFrame:CGRectMake(15, top + (45+10), width, 45)];
    
    fieldBack.layer.masksToBounds = YES;
    fieldBack.layer.cornerRadius = 5;
    fieldBack.layer.borderWidth = 1;
    fieldBack.layer.borderColor = RGBCOLOR_HEX(kMargineColor).CGColor;
    fieldBack.layer.backgroundColor = [UIColor whiteColor].CGColor;
    [mScrollView addSubview:fieldBack];
    
    UITextField *field = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, width-20, 45)];
    fieldBack.backgroundColor =[UIColor clearColor];
    field.delegate = self;
    field.placeholder = @"请输入验证码";
    [fieldBack addSubview:field];
    fieldBack.backgroundColor =[UIColor whiteColor];
    field.keyboardType = UIKeyboardTypeNumberPad;
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
    countDownCode.selected = NO;
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
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.layer.masksToBounds = YES;
    saveBtn.layer.cornerRadius = 3;
    saveBtn.frame = CGRectMake(15, 65 + 2*(45+10)+10, SCREEN_WIDTH-30, 45);
    [saveBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [saveBtn setTitleColor:RGBCOLOR_HEX(0xffffff) forState:UIControlStateNormal];
    [mScrollView addSubview:saveBtn];
    [saveBtn addTarget:self action:@selector(CheckCode) forControlEvents:UIControlEventTouchUpInside];
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
    [self showLoading:YES];
    NSString *url = @"/u/sendModifyMobileCode";
    NSMutableDictionary *parametersDict = [[NSMutableDictionary alloc]init];
    [parametersDict setObject:gUser.mobile forKey:@"mobile"];
    //
    [RequestManeger POST:url parameters:parametersDict complete:processComplete(^(AFHTTPRequestOperation *      operation, id responseObject, NSString *msg) {
        [self hideLoading:YES];
        //NSInteger code = [responseObject[@"code"] integerValue];
        
        if (sender.touchedDownBlock) {
            sender.touchedDownBlock(sender,sender.tag);
        }
        
        [self showHint:msg hide:1];
        
    })];
}


- (void)CheckCode{
    [codeField endEditing:YES];
    if (codeField.text.length != 6) {
        [self showHint:@"验证码无效" hide:2];
        return;
    }
    [self showLoading:YES];
    NSString *url = @"/u/checkModifyMobileCode";
    NSMutableDictionary *parametersDict = [[NSMutableDictionary alloc]init];
    [parametersDict setObject:gUser.mobile forKey:@"mobile"];
    [parametersDict setObject:codeField.text forKey:@"code"];
    //
    [RequestManeger POST:url parameters:parametersDict complete:processComplete(^(AFHTTPRequestOperation *      operation, id responseObject, NSString *msg) {
        [self hideLoading:YES];
        NSInteger code = [responseObject[@"code"] integerValue];
        if (code == 0) {
            WPChangePhoneController *ctrl = [[WPChangePhoneController alloc]init];
            [self.navigationController pushViewController:ctrl animated:YES];
        }else if(code == 20003){
            [self showHint:@"验证码无效" hide:1];
        }
        else{
            [self showHint:msg hide:1];
        }
    })];
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
