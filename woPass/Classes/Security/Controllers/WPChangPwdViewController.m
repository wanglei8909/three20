//
//  WPChangPwdViewController.m
//  woPass
//
//  Created by htz on 15/7/9.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPChangPwdViewController.h"
#import "NIAttributedLabel.h"
#import "WPTextField.h"
#import "WPButton.h"
#import "Masonry.h"

typedef NS_ENUM(NSUInteger, PWDTextFieldType) {
    PWDTextFieldNow,
    PWDTextFieldSetNew,
    PWDTextFieldConNew,
};

@interface WPChangPwdViewController () <UITextFieldDelegate>

@property (nonatomic, strong)NIAttributedLabel *currentAccountLabel;
@property (nonatomic, strong)WPTextField *nowPwdTextField;
@property (nonatomic, strong)WPTextField *setNewPwdTextField;
//@property (nonatomic, strong)WPTextField *conNewPwdTextField;
@property (nonatomic, strong)UIView *textFieldBgView;
@property (nonatomic, strong)WPButton *conNewPwdButton;
@property (nonatomic, assign)BOOL isAdapted;


@end

@implementation WPChangPwdViewController

- (UIView *)textFieldBgView {
    if (!_textFieldBgView) {
        _textFieldBgView = [[UIView alloc] init];
        _textFieldBgView.layer.cornerRadius = 5;
        _textFieldBgView.layer.borderWidth = 1;
        _textFieldBgView.layer.borderColor = RGBCOLOR_HEX(kMargineColor).CGColor;
        _textFieldBgView.layer.masksToBounds = YES;
        [self.tableView addSubview:_textFieldBgView];
        
        weaklySelf();
        [_textFieldBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(weakSelf.tableView);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 36, 45));
            make.top.equalTo(weakSelf.nowPwdTextField.mas_bottom).with.offset(18);
        }];
        
    }
    return _textFieldBgView;
}

- (NIAttributedLabel *)currentAccountLabel {
    if (!_currentAccountLabel) {
        _currentAccountLabel = [NIAttributedLabel labelWithFontSize:kFontTiny color:RGBCOLOR_HEX(kLabelDarkColor)];
        [_currentAccountLabel x_sizeToFit];
        
        weaklySelf();
        [self.tableView addSubview:_currentAccountLabel];
        
        [_currentAccountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(weakSelf.tableView).with.offset(18);
            make.left.equalTo(weakSelf.tableView).with.offset(18);
        }];
    }
    return _currentAccountLabel;
}
- (UITextField *)nowPwdTextField {
    if (!_nowPwdTextField) {
        _nowPwdTextField = [WPTextField textFieldWithPlaceholder:@"请输入当前密码"];
        _nowPwdTextField.delegate = self;
        _nowPwdTextField.tag = PWDTextFieldNow;
        [self.tableView addSubview:_nowPwdTextField];
        _nowPwdTextField.secureTextEntry = YES;
        weaklySelf();
        [_nowPwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.tableView);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 36, 45));
            make.top.equalTo(weakSelf.currentAccountLabel.mas_bottom).with.offset(18);
            
        }];
    }
    return _nowPwdTextField;
}
- (WPTextField *)setNewPwdTextField {
    if (!_setNewPwdTextField) {
        _setNewPwdTextField = [WPTextField textFieldWithPlaceholder:@"请输入新密码"];
        _setNewPwdTextField.delegate = self;
        _setNewPwdTextField.tag = PWDTextFieldSetNew;
        _setNewPwdTextField.layer.cornerRadius = 0;
        _setNewPwdTextField.layer.borderWidth = 0.5;
        [self.textFieldBgView addSubview:_setNewPwdTextField];
        
        weaklySelf();
        [_setNewPwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.equalTo(weakSelf.nowPwdTextField);
            make.centerX.equalTo(weakSelf.nowPwdTextField);
            make.top.equalTo(weakSelf.textFieldBgView.mas_top);
        }];
    }
    return _setNewPwdTextField;
}
//- (WPTextField *)conNewPwdTextField {
//    if (!_conNewPwdTextField) {
//        _conNewPwdTextField = [WPTextField textFieldWithPlaceholder:@"请输入新密码"];
//        _conNewPwdTextField.delegate = self;
//        _conNewPwdTextField.tag = PWDTextFieldConNew;
//        _conNewPwdTextField.layer.cornerRadius = 0;
//        _conNewPwdTextField.layer.borderWidth = 0.5;
//        _conNewPwdTextField.secureTextEntry  = YES;
//        [self.textFieldBgView addSubview:_conNewPwdTextField];
//        
//        weaklySelf();
//        [_conNewPwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
//           
//            make.size.equalTo(weakSelf.setNewPwdTextField);
//            make.centerX.equalTo(weakSelf.setNewPwdTextField);
//            make.top.equalTo(weakSelf.setNewPwdTextField.mas_bottom);
//        }];
//    }
//    return _conNewPwdTextField;
//}
- (WPButton *)conNewPwdButton {
    if (!_conNewPwdButton) {
        _conNewPwdButton = [[WPButton alloc] initWithTitle:@"确认修改"];
        [_conNewPwdButton addTarget:self action:@selector(clickConNewPwdButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.tableView addSubview:_conNewPwdButton];
        _conNewPwdButton.adjustsImageWhenDisabled = NO;
        _conNewPwdButton.adjustsImageWhenHighlighted = NO;
        
        weaklySelf();
        [_conNewPwdButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.equalTo(weakSelf.setNewPwdTextField);
            make.centerX.equalTo(weakSelf.setNewPwdTextField);
            make.top.equalTo(weakSelf.setNewPwdTextField.mas_bottom).with.offset(20);
        }];
        
    }
    return _conNewPwdButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [BaiduMob logEvent:@"id_password" eventLabel:@"revise"];
    
    self.view.backgroundColor = RGBCOLOR_HEX(kBackgroundColor);
    [self.tableView setTop:0];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setShowsVerticalScrollIndicator:NO];
    self.tableView.backgroundColor = RGBCOLOR_HEX(kBackgroundColor);
    [self.tableView setFrame:UIEdgeInsetsInsetRect(self.view.bounds, UIEdgeInsetsMake(self.navigationController.navigationBar.height + 22, 0, 0, 0))];
    
    [self currentAccountLabel];
    [self nowPwdTextField];
    [self setNewPwdTextField];
    //[self conNewPwdTextField];
    [self conNewPwdButton];
    
    self.currentAccountLabel.text = [NSString stringWithFormat:@"当前帐号：%@", [gUser.mobile isEqualToString:@""] ? @"暂未登录" : gUser.mobile];
    [self.currentAccountLabel setTextColor:RGBCOLOR_HEX(KTextOrangeColor) range:NSMakeRange(5, self.currentAccountLabel.text.length - 5)];
    
    [self getPageContent];
    
}
- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 50 - 55)];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    
    if (SCREEN_HEIGHT < 569 && textField.tag == PWDTextFieldConNew && !self.isAdapted) {
        
        [self upTableView];
        self.isAdapted = YES;
    }
}

- (void)upTableView {
    weaklySelf();
    [UIView animateWithDuration:0.25 animations:^{
        
        weakSelf.tableView.top -= 50;
    }];
}

- (void)downTableView {
    weaklySelf();
    [UIView animateWithDuration:0.25 animations:^{
        
        weakSelf.tableView.top += 50;
    }];
}

// 无意义，为了让超时的用户再次登陆
- (void)getPageContent {
    
    [self showLoading:YES];
    weaklySelf();
    [RequestManeger POST:@"/u/bindEmailInfo" parameters:nil complete:processComplete(^(AFHTTPRequestOperation *operation, id responseObject, NSString *msg) {
        
        [weakSelf hideLoading:YES];
        [weakSelf showHint:msg hide:1];
    })];
}

- (void)clickConNewPwdButton:(UIButton *)button {
    
    if (SCREEN_HEIGHT < 569 && self.isAdapted) {
        
        [self downTableView];
        self.isAdapted = NO;
    }

    
    [self.view endEditing:YES];
    
//    
//    if (![self.conNewPwdTextField.text isEqualToString:self.setNewPwdTextField.text]) {
//        
//        [self showHint:@"两次输入密码不一致" hide:1];
//        return;
//    }
    
    NSString *pass = self.nowPwdTextField.text;
    NSPredicate *passRegx = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"(?=^.{6,16}$)(?=.*\\d)(?=.*.+)(?=.*[a-z])(?!.*\n).*$"];
    
    if(!(pass.length >= 6 && pass.length <= 16 && [passRegx evaluateWithObject:pass])) {
        
        [self showHint:@"原密码为6-16位字符，必须包含数字和字母" hide:1];
        return;
    }
    
    pass = self.setNewPwdTextField.text;
    if(!(pass.length >= 6 && pass.length <= 16 && [passRegx evaluateWithObject:pass])) {
        
        [self showHint:@"新密码为6-16位字符，必须包含数字和字母" hide:1];
        return;
    }
    
//    pass = self.conNewPwdTextField.text;
//    if(!(pass.length >= 6 && pass.length <= 16 && [passRegx evaluateWithObject:pass])) {
//        
//        [self showHint:@"确认新密码为6-16位字符，必须包含数字和字母" hide:1];
//        return;
//    }
    
    NSLog(@"---->%@\n----%@",self.nowPwdTextField.text,self.setNewPwdTextField.text);
    
    [self showLoading:YES];
    weaklySelf();
    [RequestManeger POST:@"/u/modifyPassword" parameters:@{
                                                           @"oldPass" : self.nowPwdTextField.text,
                                                           @"newPass" : self.setNewPwdTextField.text
                                                          } complete:processComplete(^(AFHTTPRequestOperation *operation, id responseObject, NSString *msg) {
        [weakSelf hideLoading:YES];
        if (!msg) {
            
            [weakSelf showHint:@"密码修改成功" hide:1];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [weakSelf dismiss];
            });
        } else {
            
            [weakSelf showHint:msg hide:1];
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
    return @"修改密码";
}

@end
