//
//  WPBindingEmailViewController.m
//  woPass
//
//  Created by htz on 15/7/9.
//  Copyright (c) 2015年 unisk. All rights reserved.
//

#import "WPBindingEmailViewController.h"
#import "NIAttributedLabel.h"
#import "WPTextField.h"
#import "WPButton.h"

#define kTimerup 60

@interface WPBindingEmailViewController () <UIAlertViewDelegate>

@property (nonatomic, strong)NIAttributedLabel *bindingStateLabel;
@property (nonatomic, strong)WPTextField *EmailInputTextField;
@property (nonatomic, strong)WPTextField *verificationCodeTextField;
@property (nonatomic, strong)UIButton *getVerificationCdoeButtom;
@property (nonatomic, strong)WPButton *bindingButton;
@property (nonatomic, assign)NSInteger enableTime;
@property (nonatomic, strong)NSTimer *timer;

@end

@implementation WPBindingEmailViewController

- (NIAttributedLabel *)bindingStateLabel {
    if (!_bindingStateLabel) {
        _bindingStateLabel = [NIAttributedLabel labelWithFontSize:kFontTiny color:RGBCOLOR_HEX(kLabelDarkColor)];
        [self.tableView addSubview:_bindingStateLabel];
    }
    return _bindingStateLabel;
}
- (UITextField *)EmailInputTextField {
    if (!_EmailInputTextField) {
        _EmailInputTextField = [WPTextField textFieldWithPlaceholder:@"请输入邮箱"];
        [self.tableView addSubview:_EmailInputTextField];
    }
    return _EmailInputTextField;
}
- (UITextField *)verificationCodeTextField {
    if (!_verificationCodeTextField) {
        _verificationCodeTextField = [WPTextField textFieldWithPlaceholder:@"请输入手机验证码"];
        _verificationCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
        [self.tableView addSubview:_verificationCodeTextField];
    }
    return _verificationCodeTextField;
}
- (UIButton *)getVerificationCdoeButtom {
    if (!_getVerificationCdoeButtom) {
        _getVerificationCdoeButtom = [UIButton buttonWithType:UIButtonTypeCustom];
        [_getVerificationCdoeButtom setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getVerificationCdoeButtom setBackgroundImage:[UIImage imageWithColor:RGBCOLOR_HEX(KTextOrangeColor)] forState:UIControlStateNormal];
        [_getVerificationCdoeButtom setBackgroundImage:[UIImage imageWithColor:RGBCOLOR_HEX(kDisableBgColor)] forState:UIControlStateSelected];
        [_getVerificationCdoeButtom setTitleColor:RGBCOLOR_HEX(kDisableTitleColor) forState:UIControlStateSelected];
        [_getVerificationCdoeButtom setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _getVerificationCdoeButtom.selected = YES;
        _getVerificationCdoeButtom.userInteractionEnabled = NO;
        [_getVerificationCdoeButtom addTarget:self action:@selector(getVerificationcodeButtonDidClicked:) forControlEvents:UIControlEventTouchDown];
        _getVerificationCdoeButtom.layer.borderColor = RGBCOLOR_HEX(kMargineColor).CGColor;
        _getVerificationCdoeButtom.layer.borderWidth = 1;
        _getVerificationCdoeButtom.layer.cornerRadius = 5;
        _getVerificationCdoeButtom.layer.masksToBounds = YES;
        _getVerificationCdoeButtom.titleLabel.font = XFont(kFontTiny);
        [self.tableView addSubview:_getVerificationCdoeButtom];
    }
    return _getVerificationCdoeButtom;
}
- (UIButton *)bindingButton {
    if (!_bindingButton) {
        _bindingButton = [[WPButton alloc] initWithTitle:@"绑定"];
        [_bindingButton addTarget:self action:@selector(bindingbuttonDidClicked:) forControlEvents:UIControlEventTouchUpInside
         ];
        [self.tableView addSubview:_bindingButton];
    }
    return _bindingButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGBCOLOR_HEX(kBackgroundColor);
    [self.tableView setTop:0];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setShowsVerticalScrollIndicator:NO];
    self.tableView.backgroundColor = RGBCOLOR_HEX(kBackgroundColor);
    [self.tableView setFrame:UIEdgeInsetsInsetRect(self.view.bounds, UIEdgeInsetsMake(self.navigationController.navigationBar.height + 22, 0, 0, 0))];
    
    self.enableTime = kTimerup;
    
    [self autoRrefreshTitleLabel];
    [self setupTitleLabel];
    [self getPageContent];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emailTextChanged:) name:UITextFieldTextDidChangeNotification object:self.EmailInputTextField];
}
- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 50 - 55)];
}

- (void)getPageContent {
    [self showLoading:YES];
    weaklySelf();
    [RequestManeger POST:@"/u/bindEmailInfo" parameters:nil complete:processComplete(^(AFHTTPRequestOperation *operation, id responseObject, NSString *msg) {
        
        [weakSelf hideLoading:YES];
        [weakSelf showHint:msg hide:1];
        
        if (!msg) {
            
            gUser.email = [[[responseObject objectForKey:@"data"] objectForKey:@"user"] objectForKey:@"email"];
            gUser.emailIsavalible = [gUser.email isEqualToString:@""] ? @"0" : @"1";
        }
    })];
}

- (void)emailTextChanged:(id) info {
    
    NSString *email = [[info valueForKey:@"object"] text];
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    if ([emailTest evaluateWithObject:email]) {
        
        self.getVerificationCdoeButtom.userInteractionEnabled = YES;
        self.getVerificationCdoeButtom.selected = NO;
    }
}

#pragma mark - 设置自动刷新title

- (void)autoRrefreshTitleLabel {
    [gUser addObserver:self forKeyPath:@"email" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {

    [self setupTitleLabel];
}

- (void)setupTitleLabel {
    
    self.bindingStateLabel.text = [NSString stringWithFormat:@"当前绑定邮箱 : %@", [gUser.email isEqualToString:@""] ? @"暂未绑定" : gUser.email];
    [self.bindingStateLabel setTextColor:RGBCOLOR_HEX(kTitleStateOrangeColor) range:NSMakeRange(7, self.bindingStateLabel.text.length - 7)];
    [self.bindingStateLabel x_sizeToFit];
}

#pragma mark - 获取验证码点击

- (void)getVerificationcodeButtonDidClicked:(UIButton *)button {
    
    self.getVerificationCdoeButtom.selected = YES;
    self.getVerificationCdoeButtom.userInteractionEnabled = NO;
    [self.getVerificationCdoeButtom setTitle:[NSString stringWithFormat:@"获取验证码（%d）", kTimerup] forState:UIControlStateSelected];
    
    // 发送验证码
    weaklySelf();
    [self showLoading:YES];
    [RequestManeger POST:@"/u/sendBindEmailCode" parameters:nil complete:processComplete(^(AFHTTPRequestOperation *operation, id responseObject, NSString *msg) {
        
        [weakSelf hideLoading:YES];
        [weakSelf showHint:msg hide:1];
        if (!msg) {
            
            weakSelf.timer = [NSTimer timerWithTimeInterval:1 target:weakSelf selector:@selector(timeupAction) userInfo:nil repeats:YES];
            [[NSRunLoop mainRunLoop] addTimer:weakSelf.timer forMode:NSRunLoopCommonModes];
        }
        
    })];
    
}

#pragma mark - 绑定按钮点击

- (void)bindingbuttonDidClicked:(UIButton *)button {
    [self.EmailInputTextField resignFirstResponder];
    [self.verificationCodeTextField resignFirstResponder];
    [BaiduMob logEvent:@"id_mail_tie" eventLabel:@"tie"];
    
    NSString *email = self.EmailInputTextField.text;
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    if (![emailTest evaluateWithObject:email]) {
        
        [self showHint:@"请输入正确的邮箱帐号" hide:1];
        return;
    }
    
    NSString *code = self.verificationCodeTextField.text;
    if ([code isEqualToString:@""] || !code) {
        
        [self showHint:@"请输入验证码" hide:1];
        return;
    }
    
    weaklySelf();
    [self showLoading:YES];
    [RequestManeger POST:@"/u/bindEmail" parameters:@{
                                                      @"email" : self.EmailInputTextField.text,
                                                      @"validateCode" : self.verificationCodeTextField.text
                                                      } complete:processComplete(^(AFHTTPRequestOperation *operation, id responseObject, NSString *msg) {
        
        [weakSelf hideLoading:YES];
        [weakSelf showHint:msg hide:1];
        if (!msg) {
            
//            gUser.email = [NSString stringWithFormat:@"未激活( %@ )", weakSelf.EmailInputTextField.text];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"请登录邮箱，进行绑定激活" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles: nil];
            [alertView show];
        }
    })];

}

- (void)alertViewCancel:(UIAlertView *)alertView {
    
    [self dismiss];
}

- (void)timeupAction{

    if (-- self.enableTime) {

        [self.getVerificationCdoeButtom setTitle:[NSString stringWithFormat:@"获取验证码（%ld）", self.enableTime] forState:UIControlStateSelected];
    } else {

        [self.timer invalidate];
        self.timer = nil;
        self.enableTime = kTimerup;
        [self.getVerificationCdoeButtom setTitle:[NSString stringWithFormat:@"获取验证码（0）"] forState:UIControlStateSelected];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
           
            self.getVerificationCdoeButtom.userInteractionEnabled = YES;
            self.getVerificationCdoeButtom.selected = NO;
        });
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.bindingStateLabel x_sizeToFit];
    self.bindingStateLabel.top = 18;
    self.bindingStateLabel.left = 18;
    
    self.EmailInputTextField.frame = CGRectMake(self.bindingStateLabel.left, self.bindingStateLabel.bottom + 18, self.tableView.width - 36, 45);
    
    self.verificationCodeTextField.frame = CGRectMake(self.EmailInputTextField.left, self.EmailInputTextField.bottom + 10, self.EmailInputTextField.width * 0.6, self.EmailInputTextField.height);
    
    self.getVerificationCdoeButtom.center = self.verificationCodeTextField.center;
    self.getVerificationCdoeButtom.left = self.verificationCodeTextField.right + 10;
    self.getVerificationCdoeButtom.height = 40;
    self.getVerificationCdoeButtom.width = self.EmailInputTextField.width - self.verificationCodeTextField.width - 10;
    
    self.bindingButton.frame = self.EmailInputTextField.frame;
    self.bindingButton.top = self.verificationCodeTextField.bottom + 22;
}

- (void)dealloc {
    
    [gUser removeObserver:self forKeyPath:@"email"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    return @"邮箱绑定";
}

@end
