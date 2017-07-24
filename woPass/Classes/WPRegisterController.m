//
//  WPRegisterController.m
//  woPass
//
//  Created by 王蕾 on 15/7/17.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPRegisterController.h"
#import "JKCountDownButton.h"
#import "WPURLManager.h"

typedef enum : NSUInteger {
    WPRegisterPhoneCodeField = 100
} WPRegisterField;

@interface WPRegisterController () <UITextFieldDelegate>

@property (nonatomic, weak)UIButton *coundDownButton;
@property (nonatomic, assign)BOOL isAdapted;

@end

@implementation WPRegisterController
{
    UIScrollView *mScrollView;
    UITextField *mNumField;
    UITextField *mPassword;
    UITextField *mPhoneCode;
    UIButton *checkBox;
}

- (void)setupSaveButton {
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.layer.masksToBounds = YES;
    saveBtn.layer.cornerRadius = 3;
    saveBtn.frame = CGRectMake(15, 5 + 3*(45+15)+15, SCREEN_WIDTH-30, 45);
    [saveBtn setTitle:@"立即设置" forState:UIControlStateNormal];
    [saveBtn setTitleColor:RGBCOLOR_HEX(0xffffff) forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:kFontMiddle];
    [saveBtn addTarget:self action:@selector(ReginstClick) forControlEvents:UIControlEventTouchUpInside];
    [mScrollView addSubview:saveBtn];
    saveBtn.backgroundColor = RGBCOLOR_HEX(KTextOrangeColor);
}

- (void)generatePage {
    float countDownBtnWidth = 90;
    
    NSArray *placeholderText = @[@"请输入联通手机号",@"请输入随机密码",@"请输入密码"];
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
        field.clearButtonMode = UITextFieldViewModeWhileEditing;
        [fieldBack addSubview:field];
        fieldBack.backgroundColor =[UIColor whiteColor];
        
        switch (i) {
            case 0: {
                mNumField = field;
                mNumField.attributedText = [[NSAttributedString alloc] initWithString:gUser.mobile attributes:@{NSFontAttributeName : XFont(kFontMiddle), NSForegroundColorAttributeName : RGBCOLOR_HEX(kDisableTitleColor)}];
                mNumField.userInteractionEnabled = NO;
            }
                break;
            case 2:
                mPassword = field;
                break;
            case 1:
                mPhoneCode = field;
                mPhoneCode.tag = WPRegisterPhoneCodeField;
                break;
            default:
                break;
        }
        
        if (i==1) {
            field.secureTextEntry = YES;
            JKCountDownButton *countDownCode = [JKCountDownButton buttonWithType:UIButtonTypeCustom];
            self.coundDownButton = countDownCode;
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
            [mScrollView addSubview:countDownCode];
            
            [countDownCode addTarget:self action:@selector(CountDownBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            countDownCode.selected = NO;
            
            weaklySelf();
            [countDownCode addToucheHandler:^(JKCountDownButton*sender, NSInteger tag) {
                
                sender.selected = YES;
                sender.userInteractionEnabled = NO;
                
                [sender startWithSecond:60];
                
                [sender didChange:^NSString *(JKCountDownButton *countDownButton,int second) {
                    NSString *title = [NSString stringWithFormat:@"剩余%d秒",second];
                    return title;
                }];
                [sender didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
                    
                    countDownButton.selected = NO;
                    countDownButton.userInteractionEnabled = YES;
                    return @"重新获取";
                    
                }];
                
            }];
            
        }
        
    }
}

//- (void)setupLabel {
//    NIAttributedLabel *label = [[NIAttributedLabel alloc]initWithFrame:CGRectMake(30, 3+3*(45+15), 300, 13)];
//    label.text = @"我已阅读并同意《使用条款和隐私政策》";
//    label.font = [UIFont systemFontOfSize:13];
//    label.textColor = RGBCOLOR_HEX(kLabelDarkColor);
//    [label setTextColor:[UIColor colorWithRed:68/255.f green:113/255.f blue:183/255.f alpha:1] range:NSMakeRange(7, 11)];
//    [mScrollView addSubview:label];
//    
//    checkBox = [UIButton buttonWithType:UIButtonTypeCustom];
//    checkBox.frame = CGRectMake(label.left-15-5, label.top+1.5-5, 20, 20);
//    [checkBox setImage:[UIImage imageNamed:@"weizhongcheckbox"] forState:UIControlStateSelected];
//    [checkBox setImage:[UIImage imageNamed:@"zhongcheckbox"] forState:UIControlStateNormal];
//    checkBox.selected = YES;
//    [checkBox addTarget:self action:@selector(checkBoxClick) forControlEvents:UIControlEventTouchUpInside];
//    [mScrollView addSubview:checkBox];
//    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(label.left+70, label.top, label.width-70, label.height);
//    btn.backgroundColor = [UIColor clearColor];
//    [btn addTarget:self action:@selector(ShowTips) forControlEvents:UIControlEventTouchUpInside];
//    [mScrollView addSubview:btn];
//}
- (void)ShowTips{
    [WPURLManager openURLWithMainTitle:nil urlString:@"https://i.wo.cn/H5/userTerms"];
}

- (void)checkBoxClick{
    checkBox.selected = !checkBox.selected;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [BaiduMob logEvent:@"id_password" eventLabel:@"set"];
    
    [self.tableView setTop:0];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setShowsVerticalScrollIndicator:NO];
    self.tableView.backgroundColor = RGBCOLOR_HEX(kBackgroundColor);
    [self.tableView setFrame:UIEdgeInsetsInsetRect(self.view.bounds, UIEdgeInsetsMake(self.navigationController.navigationBar.height + 22, 0, 0, 0))];
    
    mScrollView = [[UIScrollView alloc]initWithFrame:UIEdgeInsetsInsetRect(self.tableView.bounds, UIEdgeInsetsMake(10, 0, 0, 0))];
    mScrollView.backgroundColor = [UIColor clearColor];
    mScrollView.showsVerticalScrollIndicator = NO;
    [self.tableView addSubview:mScrollView];
    
    [self generatePage];
    
    //[self setupLabel];
    
    [self setupSaveButton];

}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    

    if (SCREEN_HEIGHT < 569 && textField.tag == WPRegisterPhoneCodeField && !self.isAdapted) {
        
        [self upTableView];
        self.isAdapted = YES;
    }
}

- (void)upTableView {
    weaklySelf();
    [UIView animateWithDuration:0.25 animations:^{
        
        weakSelf.tableView.top -= 100;
    }];
}

- (void)downTableView {
    weaklySelf();
    [UIView animateWithDuration:0.25 animations:^{
        
        weakSelf.tableView.top += 100;
    }];
}

- (void)CountDownBtnClick:(JKCountDownButton *)sender{
    
    [self.view endEditing:YES];
    
    NSString *phoneRegex = UniPhoneRegex;
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    if (![phoneTest evaluateWithObject:mNumField.text]) {
        
        [self showHint:@"请输入联通号码" hide:1];
        return ;
    }
    
    weaklySelf();
    [self showLoading:YES];
    [RequestManeger POST:@"/u/sendModPwdCode" parameters:@{
                                                           @"mobile" : mNumField.text
                                                           } complete:processComplete(^(AFHTTPRequestOperation *operation, id responseObject, NSString *msg) {
        [weakSelf hideLoading:YES];
        [weakSelf showHint:msg hide:1];
        if (!msg) {
            
            if (sender.touchedDownBlock) {
                sender.touchedDownBlock(sender,sender.tag);
            }
        }
    })];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 50 - 55)];
}

- (void)ReginstClick{
    
    
    if (SCREEN_HEIGHT < 569 && self.isAdapted) {
        
        [self downTableView];
        self.isAdapted = NO;
    }
    
    [self.view endEditing:YES];
    
    NSString *phoneRegex = UniPhoneRegex;
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    NSPredicate *passTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"(?=^.{6,16}$)(?=.*\\d)(?=.*.+)(?=.*[a-z])(?!.*\n).*$"];
    
    if (![phoneTest evaluateWithObject:mNumField.text]) {
        
        [self showHint:@"请输入正确的手机号" hide:1];
        return;
    } else if (![passTest evaluateWithObject:mPassword.text]) {
        
        [self showHint:@"密码长度为6-16位，需包含数字和字母" hide:1];
        return;
    } else if ([mPhoneCode.text isEqualToString:@""] || !mPhoneCode.text) {
        
        [self showHint:@"请输入验证码" hide:1];
        return;
    }
    
    weaklySelf();
    [self showLoading:YES];
    [RequestManeger POST:@"/u/modifyPasswordByCode" parameters:@{
                                                                @"mobile" : mNumField.text,
                                                                @"password" : mPassword.text,
                                                                @"validateCode" : mPhoneCode.text
                                                                } complete:processComplete(^(AFHTTPRequestOperation *operation, id responseObject, NSString *msg) {
        [weakSelf showHint:msg hide:1];
        [weakSelf hideLoading:YES];
        if (!msg) {
            [weakSelf showHint:@"密码设置成功" hide:1];
            gUser.isSet = @"1";
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [weakSelf dismiss];
            });
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
    return @"设置密码";
}


@end
